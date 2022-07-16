# 滤镜系统
---

> `v3.6.0+`以上のバージョンのPixelsWorldが必要です．

フィルターシステムは四角形シェーダーのカプセル化です．
このシステムを使うことで，画像処理シェーダーを素早く作れます．

この節を通じて，`PixelsWorld`のフィルターシステムをすばやく理解し，使用方法を学ぶことができます．


- [newFilter フィルター新規](#フィルター新規)
- [runFilter フィルター実行](#フィルター実行)
- [delFilter フィルター削除](#フィルター削除)
- [setFilterUniform フィルター設定](#フィルター設定)
- [setFilterDrawto フィルター出力画像設定](#フィルター出力画像設定)
- [newFilterModule フィルターモジュール新規](#フィルターモジュール新規)
- [高級アプリケーション](#高級アプリケーション)


## フィルター新規

`newFilter(glslCode)`でフィルターを新規作成します．
- 戻り値：フィルタープログラムを代表する乱数整数値（フィルターＩＤ）

`glslCode`は次のコンテキストに挿入されます：

```c:glslcode_context.glsl

#version 330 core
in vec2 uv;
out vec4 outColor;

// Your glslCode here!
```

### 例
> ご注意：Lua言語で，二重大かっこう`[[...]]`で複数行文字列を引用します．
```lua:newFilter.lua
version3()
filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])
```



## フィルター実行
`runFilter(filterID)`でフィルターを実行します．

### 例

```lua:runFilter.lua
version3()

filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])

runFilter(filterID)
```

## フィルター削除

`delFilter(filterID)`でフィルターを削除します．

> 通常，ユーザーはフィルターを削除する必要はありません．なぜなら，フィルターは毎フレームの終了時に自動的に削除されるからです．ただし，使用済みのフィルターを手動で削除することをお勧めします．

### 例

```lua:delFilter.lua
version3()
filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])
delFilter(filterID)
```

## フィルター設定

`setFilterUniform(filterID, uniformType, uniformName, data0, data1, data2, ...)`でフィルターの中で定義されている`uniform`データの値を設置します．

- `filterID`: フィルターＩＤ．整数．
- `uniformType`: データタイプを表す文字列．例えば，1次元データ（`"int","float","bool"`），ベクトル（`"vec2","vec3","vec4","ivec2"...`），行列（`"mat2, mat4x3, ..."`），テキスチャー（`"sampler2D"`）
- `uniformName`：データのパラメータ名
- `data0,data1,...`：浮動小数点データ（詳細は次の例へ）

### 例

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

-- Column major, namely mymat[0][0]==1, mymat[0][1]==slider(0), mymat[0][2]==2, mymat[1][0]==3, ...
setFilterUniform(filterID, "mat3x2", "mymat", 1, slider(0), 2, 3, 4, 5)

-- Use INPUT texture as mytex1
setFilterUniform(filterID, "sampler2D", "mytex1", INPUT)

-- ** You can also set the texture you created as mytex1 **
-- myInputTexID = newTex(512,256)
-- setFilterUniform(filterID, "sampler2D", "mytex1", myInputTexID)

runFilter(filterID)

```

## フィルター出力画像設定

`setFilterDrawto(filterID, texID)`でフィルターの出力画像を指定します．`texID`に関しては，[テキスチャーシステム](Texture.md)をご参照ください．

> 出力画像のデフォルトは`OUTPUT`



画像を繰り返しシェーディングすることもできます．

詳細は[高级アプリケーション](#高级アプリケーション)へ



## フィルターモジュール新規

`newFilterModule(glslCode)`でフィルターモジュールを新規作成します．
- 戻り値：フィルターID及び効用関数を持つテーブル．


フィルターモジュールの役割はコードを簡単化するだけです．

フィルターモジュールを用いない場合は，フィルターを次のように作ります．

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

フィルターモジュールを用いるとコードは次のようにになります．

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



## 高級アプリケーション

以下は，チャンネルぼかしエフェクトを実現する例です：

- `slider 0`：ぼかし度合い
- `layer 0`：ぼかしマスクレイヤー

```lua:iterateFilter.lua

version3()

-- Create a temp texture
tempTexID = newTex(width,height)

-- Copy input to temp texture
castTex(tempTexID, INPUT)


-- Blur code
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


-- Combine code
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

-- Set the kernel data of 3x3 gaussian blur 
-- The data can be found at https://en.wikipedia.org/wiki/Kernel_(image_processing)
blurFilter.set("mat3", "kernel", 
    1.0/16, 2.0/16, 1.0/16, -- kernel[0][0], kernel[0][1], kernel[0][2]
    2.0/16, 4.0/16, 2.0/16, -- kernel[1][0], kernel[1][1], kernel[1][2]
    1.0/16, 2.0/16, 1.0/16) -- kernel[2][0], kernel[2][1], kernel[2][2]

blurFilter.set("vec2", "resolution", width, height)

-- Set temp texture as in_tex
blurFilter.set("sampler2D", "in_tex", tempTexID)

-- Set the temp texture as the Drawto
blurFilter.drawto(tempTexID)


middleResultTex = {}
for i=1,3 do
    middleResultTex[i] = newTex(width,height)
end


-- blur power
substep = slider(0)

-- Iterate filter 3*substep times
for i=1,3*substep do
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

combineFilter.set("sampler2D", "masktex",  PARAM0)

combineFilter.drawto(OUTPUT)

combineFilter.run()


```