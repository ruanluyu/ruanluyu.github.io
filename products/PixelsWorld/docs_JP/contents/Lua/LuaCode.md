# 世界の中心Lua
---

第1章で紹介するのは、**Lua**という言語です。

>** Luaは軽量で、高級、多パラダイムのプログラミング言語で、主に組込みアプリケーションで使用されます。* [——Wiki](https://en.wikipedia.org/wiki/Lua_(programming_language))

**バージョン : [Lua5.3（完全な技術ドキュメントはこちら）](https://cloudwu.github.io/lua53doc/contents.html)**

> 注意：`PixelsWorld v3.2.0`より[`Lua5.4`](https://www.lua.org/manual/5.4/manual.html)を使用しています。

Luaは、式やAeスクリプトに非常に似た言語で、ピクセルワールドの中心としてすべてのモジュールをつなぐ役割を果たします。基本的な命令を数個覚えるだけで、ピクセルワールドが順番に図形を描画するように指示できます。

ピクセルワールドにおけるすべてのレンダリング命令は、この中枢であるLuaを通じて発行できます。例えば、Aeカメラとインタラクティブな立方体を描画したい場合、次のように入力します。

```lua:DrawCube.lua
version3()
move(width/2,height/2)
dim3()
cube(300)
```

> `dim3()`は3次元モードで描画を行うための関数です。

GLSLコードをレンダリングしたい場合、次のように入力します。

```lua:RunGlsl.lua
version3()
glsl([==[
void main(){
    vec3 col = 0.5 + 0.5*cos(time+uv.xyx+vec3(0,2,4));
    outColor = vec4(col,1.0);
}
    ]==])
```

間にGLSLコードを記述するだけで実行可能です。

shadertoyのコードを実行したい場合、次のように入力します。
```lua:RunShadertoy.lua
version3()
shadertoy([==[
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    fragColor = vec4(col,1.0);
}
    ]==])
```
間にshadertoyのコードを記述するだけで実行可能です。

ここではLuaの能力範囲を示します：
- ピクセルデータの取得
- ピクセルデータの記述
- JavaScriptの実行
- GLSLの実行
- パラメータデータの取得
- 外部C言語ライブラリの実行
- Luaモジュールのロード

また、LuaはJavaScriptに非常に似ており、JavaScriptは学びやすい言語であるため、プログラミングの基礎がなくても短時間で習得できます。


## PixelsWorldの構造

![PW_Structure](../PW_Structure.png)

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>