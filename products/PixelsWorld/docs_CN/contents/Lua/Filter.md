# 滤镜系统
---

> 请确保您拥有`v3.6.0+`的PixelsWorld

滤镜系统是对矩形着色器的封装，允许您快速建立对画面整体效果的后期处理着色器。

通过这一章，您能快速了解并学习使用`PixelsWorld`的滤镜系统。

- [newFilter 创建滤镜](#创建滤镜)
- [runFilter 运行滤镜](#运行滤镜)
- [delFilter 删除滤镜](#删除滤镜)
- [setFilterUniform 设置滤镜](#设置滤镜)
- [setFilterDrawto 设置输出图像](#设置输出图像)
- [newFilterModule 创建滤镜模组](#创建滤镜模组)
- [高级应用](#高级应用)


## 创建滤镜

使用`newFilter(glslCode)`来创建一个滤镜程序
- 返回：一个代表滤镜程序的随机整数（滤镜ID）

`glslCode`将被插入下面的上下文中：

```c:glslcode_context.glsl

#version 330 core
in vec2 uv;
out vec4 outColor;

// Your glslCode here!
```

### 样例
> 注意：在Lua中，我们使用双重中括号`[[...]]`来表示分行字符串
```lua:newFilter.lua
version3()
filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])
```



## 运行滤镜
使用`runFilter(filterID)`来运行一个滤镜程序

### 样例

```lua:runFilter.lua
version3()

filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])

runFilter(filterID)
```

## 删除滤镜

使用`delFilter(filterID)`来删除一个滤镜。

> 通常您不需要删除滤镜，在每帧结束时PixelsWorld会自动删除所有滤镜。但在不需要一个滤镜的时候删除它仍然是一个很好的习惯。

### 样例

```lua:delFilter.lua
version3()
filterID = newFilter([[
    void main(){
        outColor = vec4(uv,0,1);
    }
]])
delFilter(filterID)
```

## 设置滤镜

使用`setFilterUniform(filterID, uniformType, uniformName, data0, data1, data2, ...)`来设置滤镜中您定义的`uniform`属性。

- `filterID`: 滤镜ID，整数。
- `uniformType`: 代表变量类型的字符串。支持一维数据（`"int","float","bool"`）、向量（`"vec2","vec3","vec4","ivec2"...`）、矩阵（`"mat2, mat4x3, ..."`）、贴图（`"sampler2D"`）
- `uniformName`：变量名称字符串。
- `data0,data1,...`：浮点数据。（详见样例）

### 样例

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

## 设置输出图像

使用`setFilterDrawto(filterID, texID)`来指定滤镜的结果要放在哪张贴图上。关于`texID`请参见[贴图系统](Texture.md)

> 默认的输出贴图为`OUTPUT`


您甚至可以对一张图像进行迭代着色。

详情见[高级应用](#高级应用)



## 创建滤镜模组

使用`newFilterModule(glslCode)`来创建一个滤镜模组。
- 返回：含有滤镜ID和一些效用函数的表。

滤镜模组的作用是简化您的代码。

如果您不使用滤镜模组，通常需要这么写一个滤镜：

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

使用滤镜模组后，您可以这么写：

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



## 高级应用

下面是通道模糊的代码样例：

- `slider 0`：模糊力度
- `layer 0`：模糊遮罩

![channel blur preview](channel-blur-preview.png)

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