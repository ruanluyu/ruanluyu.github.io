# テクスチャシステム
---

> `v3.3.0+`のPixelsWorldを持っていることを確認してください

この章を通じて、`PixelsWorld`のテクスチャシステムの使い方をすばやく学ぶことができます。

- [newTex](#テクスチャの作成)
- [delTex](#テクスチャの削除)
- [getSize](#サイズの取得)
- [swapTex](#テクスチャの交換)
- [drawTo](#描画先の設定)
- [castTex](#テクスチャの投射)
- [blendTex](#テクスチャの混合)
- [copyTex](#テクスチャのコピー)
- [fetchTex](#任意の時間におけるレイヤーピクセルの取得)
- [savePNG,loadPNG,saveEXR,loadEXR,saveRAW,loadRAW](#テクスチャの読み込みと保存)
- [rotateTex,flipTex,resizeTex,trimTex](#テクスチャの修整)


## テクスチャID

`PixelsWorld`では、テクスチャは整数（テクスチャID）で表されます。`PixelsWorld`が提供する基本的なテクスチャIDは以下の通りです：

|テクスチャID|Luaモードグローバル定数|GLSLモードグローバル定数|Shadertoyモードグローバル定数|説明|
|--|--|--|--|--|
|`-3`|`OUTPUT`|アクセス不可|アクセス不可|出力テクスチャ|
|`-2`|`TEMP`|`PW_TEMP_LAYER`|`_PixelsWorld_PW_TEMP_LAYER`|バッファテクスチャ|
|`-1`|`INPUT`|`AE_INPUT_LAYER`|`_PixelsWorld_AE_INPUT_LAYER`|入力テクスチャ|
|`0`|`PARAM0`|`0`|`0`|パラメーターレイヤー0|
|`1`|`PARAM1`|`1`|`1`|パラメーターレイヤー1|
|`...`|`PARAM...`|`...`|`...`|...|
|`9`|`PARAM9`|`9`|`9`|パラメーターレイヤー9|

> テクスチャIDを自分で作成することもできます。方法は後述します。

## 基本的な流れ

通常、`Ae`は1枚の画像を`PixelsWorld`に送信し、`PixelsWorld`はまずその画像を`INPUT`に配置します。そして、計算結果を`OUTPUT`テクスチャに置き、すべての命令が終了した後、`OUTPUT`テクスチャを`Ae`に結果として送信します。

## TEMPの役割

`OpenGL`は同じテクスチャを同時に読み書きすることをサポートしていないため、`PixelsWorld`は`TEMP`を提供して、前回の[glsl](FuncList.md#glsl),[shadertoy](FuncList.md#shadertoy)などの関数での描画結果を保存します。シェーダー内で`getColor(PW_TEMP_LAYER,uv);`を使用して`TEMP`の色をサンプリングすることができます。

---

## テクスチャの作成

`newTex(width,height)`を使用してテクスチャを作成し、テクスチャID（ランダムな整数値）を返します。

## テクスチャの削除

`delTex(id)`を使用して指定したテクスチャを削除します。
> 通常、手動で削除する必要はありませんが、`PixelsWorld`は毎フレーム終了時にすべてのテクスチャを削除します。しかし、不要になったテクスチャを事前に解放し、そのメモリを開放することは良い習慣です。

## サイズの取得

`getSize(id)`を使用してテクスチャのサイズを取得します。

```lua:getSize.lua
version3()
mytex = newTex(512,256)
w,h = getSize(mytex)
println("Width of mytex is: " .. w)
println("Height of mytex is: " .. h)
```

![getSizeRes](getSizeRes.png)


## テクスチャの交換

`swapTex(id1,id2)`を使用して`id1`と`id2`が指すテクスチャを交換します。

```lua:swapTex.lua
version3()
tex1 = newTex(128,128)
tex2 = newTex(256,256)
w,h = getSize(tex1)
println("tex1 size: " .. w .. ", ".. h)
swapTex(tex1,tex2)
w,h = getSize(tex1)
println("tex1 size after swapped: " .. w .. ", ".. h)
```

![swapTex](swapTexRes.png)

## 描画先の設定

`drawTo(id)`を使用して描画先テクスチャを変更します。描画先テクスチャはデフォルトで`OUTPUT`です。PixelsWorldは最終的に`OUTPUT`を結果として`Ae`に送信することに注意してください。以下の3つの方法で他のテクスチャの結果を`OUTPUT`に渡すことができます：
1. `drawTo(OUTPUT)`+[`image`](./FuncList.md#image)
2. [`castTex`](#テクスチャの投射)
3. [`swapTex`](#テクスチャの交換)

## テクスチャの投射

`castTex(toTexId,fromTexId)`を使用して、`fromTexId`から`toTexId`にピクセルを投射します。たとえば、パラメーターレイヤー0 `PARAM0`を出力テクスチャ`OUTPUT`に投射できます：

```lua:castTex.lua
version3()
castTex(OUTPUT,PARAM0)
```

また、投射するテクスチャの範囲を指定することができます（テクスチャの左上を原点とします）：
- `castTex(toTexId,fromTexId,to1x,to1y,to2x,to2y)`
- `castTex(toTexId,fromTexId,to1x,to1y,to2x,to2y,from1x,from1y,from2x,from2y)`

> 範囲を省略した場合はテクスチャ全体が使用されます。

![CastTexCoord](castTexCoord.png)


## テクスチャの混合

`blendTex(toTexId,fromTexId,blendRule)`を使用して、混合ルール`blendRule`を使用してテクスチャ`fromTex`をテクスチャ`toTex`に貼り付けます。

1. `blendRule`は`NORMAL,ADD,SUBTRACT,MULTIPLY,DIVIDE,MAX,MIN`のいずれかを指定できます。
1. `blendRule`は文字列にもでき、以下のように指定します：
   - `A`は`toTexId`の入力ピクセルを表します
   - `B`は`fromTexId`の入力ピクセルを表します
   - `C`は`toTexId`の出力ピクセルを表します
たとえば、次のコードを使用して入力テクスチャとパラメーターレイヤー0の画像を加算混合することができます。

```lua:blendRule.lua
version3()
castTex(OUTPUT,INPUT) -- まずINPUTテクスチャをOUTPUTにキャスト。 
blendTex(OUTPUT,PARAM0,"C=A+B") -- PARAM0をOUTPUTに混合。 
```
実際には、ここでの文字列はGLSLコードに処理され、`"C=A+B"`は内部で以下のコードに変換されます：

```glsl:blendRuleGLSL.frag
#version 330 core
out vec4 outColor;
in vec2 uv;
in vec2 uv2;
uniform sampler2D inLayerA;
uniform sampler2D inLayerB;
void main(){
    vec4 A = texture(inLayerA,uv);
    vec4 B = texture(inLayerB,uv2);
    vec4 C = A;
    C=A+B // あなたの混合ルールはこちらに結合されます。 
    ;
    outColor = C;
}
```

`castTex`と同様に、`blendTex`もテクスチャ範囲の指定に対応しています：
- `blendTex(toTexId,fromTexId,blendRule,to1x,to1y,to2x,to2y)`
- `blendTex(toTexId,fromTexId,blendRule,to1x,to1y,to2x,to2y,from1x,from1y,from2x,from2y)`

![CastTexCoord](castTexCoord.png)


## テクスチャのコピー

`copyTex(refTexId)`を使用してテクスチャをコピーし、コピーされた新しいテクスチャを返します。

## 任意の時間におけるレイヤーピクセルの取得

`fetchTex(layerId, time)`を使用して、指定した時間の特定のレイヤーのテクスチャを取得し、取得したテクスチャIDを返します。

- layerId: `PARAM0~PARAM9`のみが入力可能です。
- time: レイヤーの時間（浮動小数点数、単位は秒）

> - 注意: この関数を使用すると、Aeのキャッシュにエラーが発生する可能性があります。定期的にキャッシュをクリアするようにしてください。
> - `v3.4.3+`で新しく追加された関数です。

## テクスチャの読み込みと保存

`savePNG(utf8Path,texId)`,`loadPNG(utf8Path)`を使用して、PNG画像を保存および読み込みます。

`saveEXR(utf8Path,texId)`,`loadEXR(utf8Path)`を使用して、EXR画像を保存および読み込みます。

`saveRAW(utf8Path,texId)`,`loadRAW(utf8Path)`を使用して、MiLaiの未圧縮のオリジナルメモリ画像を保存および読み込みます。

以下は、PixelsWorldがサポートする画像仕様の詳細です：

|形式|使用するライブラリ|サポートされる圧縮方法|画像カラー規格|
|--|--|--|--|
|PNG|[cute_headers](https://github.com/RandyGaul/cute_headers)|DEFLATE準拠デコンプレッサzlib(RFC 1950)|RGBA、各チャネル毎に8ビットの符号なし整数。|
|EXR|[tinyexr](https://github.com/syoyo/tinyexr)|NONE,RLE,ZIP,ZIPS,PIZ,ZFP|RGBA、各チャネル毎にHDR 32ビット浮動小数点。|
|RAW|(なし)|MiLai独自形式。（以下の図参照）|RGBA、各チャネル毎にHDR 32ビット浮動小数点。|

![MiLaiRAWDef](./milaiBinaryDef.png)

シーンにPNG画像を読み込む：

```lua:loadPNG.lua
version3()
local mypng = loadPNG([[d:\test.png]]) -- あなたのパスに置き換えてください。 
castTex(OUTPUT,mypng) -- mypngからOUTPUTにピクセルをキャスト。 
```

PNG画像をローカルに保存する：
```lua:savePNG.lua
version3()

--OUTPUTに何かを描画
move(width/2,height/2)
rotate(time)
triangle()
--描画終了。 

savePNG([[d:\test.png]],OUTPUT) -- OUTPUTをPNGとしてローカルディスクに保存。ここで自分のパスに置き換えてください。 
```

> - `PNG`を`EXR`に変えると、EXR画像の保存と読み込みが可能になります。
> - 一部の場所に保存するには管理者権限が必要です。

## テクスチャの修整

`rotateTex(texId,times)`を使用して`90*times`度テクスチャを回転させます。`rotateTex(texId)`は`rotateTex(texId,1)`と同等です。

`flipTex(texId,flipV)`を使用してテクスチャを反転します。`flipV`はブール値で、`flipV`が`true`の場合は垂直反転、`false`の場合は水平反転です。

`resizeTex(texId,width,height)`を使用してテクスチャを縮小します。

`trimTex(texId,p1x,p1y,p2x,p2y)`を使用してテクスチャをトリミングします。`p1x,p1y,p2x,p2y`はテクスチャ左上を原点とした座標です。