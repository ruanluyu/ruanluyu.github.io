# フィルターシステム
---

> `v3.6.0+`のPixelsWorldをお持ちの方のみご利用いただけます

フィルターシステムは、矩形シェーダーのラッピングを行い、画面全体のエフェクトに対する後処理シェーダーを迅速に構築することを可能にします。

この章を通じて、`PixelsWorld`のフィルターシステムを迅速に理解し、使用方法を学ぶことができます。

- [newFilter フィルターを作成](#フィルターを作成)
- [runFilter フィルターを実行](#フィルターを実行)
- [delFilter フィルターを削除](#フィルターを削除)
- [setFilterUniform フィルターを設定](#フィルターを設定)
- [setFilterDrawto 出力画像を設定](#出力画像を設定)
- [newFilterModule フィルターモジュールを作成](#フィルターモジュールを作成)
- [高度な応用](#高度な応用)


## フィルターを作成

`newFilter(glslCode)` を使用してフィルタープログラムを作成します
- 戻り値：フィルタープログラムを表すランダム整数（フィルターID）

`glslCode` は以下のコンテキストに挿入されます：

```c:glslcode_context.glsl

#version 330 core
in vec2 uv;
out vec4 outColor;

// Your glslCode here!
```

### サンプル
> 注意：Luaでは、二重中括弧`[[...]]`を使用して複数行の文字列を表します
```lua:newFilter.lua
version3()
filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])
```



## フィルターを実行
`runFilter(filterID)` を使用してフィルタープログラムを実行します

### サンプル

```lua:runFilter.lua
version3()

filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])

runFilter(filterID)
```

## フィルターを削除

`delFilter(filterID)` を使用してフィルターを削除します。

> 通常、フィルターを削除する必要はありませんが、PixelsWorldは各フレームの終了時にすべてのフィルターを自動的に削除します。ただし、必要がないフィルターは削除することをお勧めします。

### サンプル

```lua:delFilter.lua
version3()
filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])
delFilter(filterID)
```

## フィルターを設定

`setFilterUniform(filterID, uniformType, uniformName, data0, data1, data2, ...)` を使用してフィルター内で定義した `uniform` 属性を設定します。

- `filterID`: フィルターID、整数。
- `uniformType`: 変数タイプを表す文字列。一次元データ（`"int","float","bool"`）やベクトル（`"vec2","vec3","vec4","ivec2"...`）、行列（`"mat2, mat4x3, ..."`）、テクスチャ（`"sampler2D"`）をサポートします。
- `uniformName`：変数名の文字列。
- `data0,data1,...`：浮動小数データ。（サンプル参照）

### サンプル

```lua:setFilterUniform.lua
version3()


filterID = newFilter([[

    uniform float myfloat;
    uniform vec2 myvec;
    uniform mat3x2 mymat;
    uniform sampler2D mytex1;

    void main(){
        outColor = vec4(myfloat,myvec[0],mymat[0][1],1) + texture(mytex1,uv);
    }
]])



setFilterUniform(filterID, "float", "myfloat", math.sin(time)*0.5 + 0.5)

setFilterUniform(filterID, "vec2", "myvec", 1,2)

-- 列単位で、例えば mymat[0][0]==1, mymat[0][1]==slider(0), mymat[0][2]==2, mymat[1][0]==3, ...
setFilterUniform(filterID, "mat3x2", "mymat", 1, slider(0), 2, 3, 4, 5)

-- INPUT テクスチャを mytex1 として使用
setFilterUniform(filterID, "sampler2D", "mytex1", INPUT)

-- ** 生成したテクスチャを mytex1 として設定することも可能です **
-- myInputTexID = newTex(512,256)
-- setFilterUniform(filterID, "sampler2D", "mytex1", myInputTexID)

runFilter(filterID)

```

## 出力画像を設定

`setFilterDrawto(filterID, texID)` を使用してフィルターの結果をどのテクスチャに出力するかを指定します。`texID` については[テクスチャシステム](Texture.md)をご参照ください。

> デフォルトの出力テクスチャは `OUTPUT` です


一枚の画像に対して反復着色を行うこともできます。

詳細は[高度な応用](#高度な応用)をご参照ください。



## フィルターモジュールを作成

`newFilterModule(glslCode)` を使用してフィルターモジュールを作成します。
- 戻り値：フィルターIDといくつかのユーティリティ関数が含まれるテーブル。

フィルターモジュールの役割はコードを簡素化することです。

フィルターモジュールを使用しない場合、通常以下のようにフィルターを書かなければなりません：

```lua:no_module.lua

version3()


filterID = newFilter([[

    uniform float myfloat;

    void main(){
        outColor = vec4(myfloat,0,0,1);
    }
]])

setFilterUniform(filterID, "float", "myfloat", math.sin(time)*0.5 + 0.5)

setFilterDrawto(filterID, OUTPUT)

runFilter(filterID)

delFilter(filterID)

```

フィルターモジュールを使用すると、以下のように書くことができます：

```lua:no_module.lua

version3()


filter = newFilterModule([[

    uniform float myfloat;

    void main(){
        outColor = vec4(myfloat,0,0,1);
    }
]])

filter.set("float", "myfloat", math.sin(time)*0.5 + 0.5)

filter.drawto(OUTPUT)

filter.run()

filter.del()

```
## 高度な応用

以下はチャンネルぼかしのコードサンプルです：

- `slider 0`：ぼかし強度
- `layer 0`：ぼかしマスク

![channel blur preview](channel-blur-preview.png)

```lua:iterateFilter.lua

version3()

-- 一時テクスチャを作成
tempTexID = newTex(width, height)

-- 入力を一時テクスチャにコピー
castTex(tempTexID, INPUT)


-- ぼかしコード
blurGLSLCode = [[
    uniform sampler2D in_tex;
    uniform mat3 kernel;
    uniform vec2 resolution;
    void main()
    {
        vec2 xy = resolution * uv;
        vec4 res = vec4(0,0,0,0);
        for(int x = 0; x < 3; x++)
        {
            for(int y = 0; y < 3; y++)
            {
                vec2 curxy = xy + vec2(x-1,y-1);
                res += texture(in_tex,curxy/resolution) * kernel[x][y];
            }
        }
        outColor = res;
    }
]]


-- 合成コード
combineGLSLCode = [[
    uniform sampler2D images[4];
    uniform sampler2D masktex;
    uniform mat2 uvcoord;
    void main()
    {
        vec2 newuv = floor(uvcoord * uv * 128);
        float maskv = clamp(texture(masktex, uv).r,0,1);
        int maski = int(floor(maskv * images.length()));
        float maskw = fract(maskv * images.length());
        if(maski == images.length) maski--;
        vec4 c1 = texture(images[maski], uv);
        vec4 c2 = c1;
        if(maski+1<images.length) 
            c2 = texture(images[maski+1], uv);

        outColor = mix(c1, c2, maskw);
    }
]]

blurFilter = newFilterModule(blurGLSLCode)

-- 3x3ガウシアンぼかしのカーネルデータを設定
-- データは https://en.wikipedia.org/wiki/Kernel_(image_processing) で参照可能
blurFilter.set("mat3", "kernel", 
    1.0/16, 2.0/16, 1.0/16, -- kernel[0][0], kernel[0][1], kernel[0][2]
    2.0/16, 4.0/16, 2.0/16, -- kernel[1][0], kernel[1][1], kernel[1][2]
    1.0/16, 2.0/16, 1.0/16) -- kernel[2][0], kernel[2][1], kernel[2][2]

blurFilter.set("vec2", "resolution", width, height)

-- 一時テクスチャを in_tex として設定
blurFilter.set("sampler2D", "in_tex", tempTexID)

-- 一時テクスチャを Drawto として設定
blurFilter.drawto(tempTexID)


middleResultTex = {}
for i=1,3 do
    middleResultTex[i] = newTex(width, height)
end


-- ぼかしの強さ
substep = slider(0)

-- フィルターを3*substep 回反復
for i=1, 3*substep do
    blurFilter.run()
    if i % substep == 0 then
        castTex(middleResultTex[i//substep], tempTexID)
    end
end


combineFilter = newFilterModule(combineGLSLCode)

combineFilter.set("sampler2D", "images", 
    INPUT,
    middleResultTex[1],
    middleResultTex[2],
    middleResultTex[3]
    )

combineFilter.set("sampler2D", "masktex", PARAM0)

combineFilter.drawto(OUTPUT)

combineFilter.run()


```