# 材质系统
---

> 请确保您拥有`v3.3.0+`的PixelsWorld

通过这一章，您能快速了解并学习使用`PixelsWorld`的材质系统。

- [newTex](#创建材质)
- [delTex](#删除材质)
- [getSize](#获取尺寸)
- [swapTex](#交换材质)
- [drawTo](#设定绘制材质)
- [castTex](#投射材质)
- [blendTex](#混合材质)
- [copyTex](#拷贝材质)
- [savePNG,loadPNG,saveEXR,loadEXR](#读取和保存材质)
- [rotateTex,flipTex,resizeTex,trimTex](#修整材质)


## 材质id

在`PixelsWorld`中，材质是用一个整数（材质id）来表示的。`PixelsWorld`提供的基础材质id如下：

|材质id|Lua模式全局常量|GLSL模式全局常量|Shadertoy模式全局常量|描述|
|--|--|--|--|--|
|`-3`|`OUTPUT`|不可访问|不可访问|输出材质|
|`-2`|`TEMP`|`PW_TEMP_LAYER`|`_PixelsWorld_PW_TEMP_LAYER`|缓冲材质|
|`-1`|`INPUT`|`AE_INPUT_LAYER`|`_PixelsWorld_AE_INPUT_LAYER`|输入材质|
|`0`|`PARAM0`|`0`|`0`|参数层0|
|`1`|`PARAM1`|`1`|`1`|参数层1|
|`...`|`PARAM...`|`...`|`...`|...|
|`9`|`PARAM9`|`9`|`9`|参数层9|

> 您还可以自己创建材质id，方法后述

## 基本流程

通常`Ae`送给`PixelsWorld`一张图片，`PixelsWorld`先把图片放在`INPUT`中，进行计算后，把结果放在`OUTPUT`材质中。当一切指令结束后会把`OUTPUT`材质送给Ae当作结果。


## TEMP的作用

因为`OpenGL`不支持同时读取和写入同一个材质，所以`PixelsWorld`提供了`TEMP`用来存储上一次[glsl](FuncList.md#glsl),[shadertoy](FuncList.md#shadertoy),等函数绘制的结果。你可以在着色器中使用`getColor(PW_TEMP_LAYER,uv);`来采样`TEMP`的颜色。

---

## 创建材质

使用`newTex(width,height)`来创建材质，将返回材质id（一个随机整数值）。

## 删除材质

使用`delTex(id)`来删除指定材质。
> 通常您无需手动删除，PixelsWorld会在每一帧结束时删除所有材质。但在不需要一个材质的时候提前释放其占用的显存仍然是个很好的习惯。

## 获取尺寸

使用`getSize(id)`来获取材质尺寸。

```lua:getSize.lua
version3()
mytex = newTex(512,256)
w,h = getSize(mytex)
println("Width of mytex is: " .. w)
println("Height of mytex is: " .. h)
```

![getSizeRes](getSizeRes.png)


## 交换材质

使用`swapTex(id1,id2)`来交换`id1`和`id2`代表的材质。

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

## 设定绘制材质

使用`drawTo(id)`来更改绘制材质。绘制材质默认为`OUTPUT`，注意PixelsWorld最后只会把`OUTPUT`当作结果送给Ae，下面三种方法可以输送其它材质的结果至`OUTPUT`：
1. `drawTo(OUTPUT)`+[`image`](./FuncList.md#image)
2. [`castTex`](#投射材质)
3. [`swapTex`](#交换材质)

## 投射材质

使用`castTex(toTexId,fromTexId)`来把像素从`fromTexId`投射到`toTexId`，例如您可以把参数层0`PARAM0`投射到输出材质`OUTPUT`上：

```lua:castTex.lua
version3()
castTex(OUTPUT,PARAM0)
```


您还可以指定投射材质的范围（以材质左上角为原点）：
- `castTex(toTexId,fromTexId,to1x,to1y,to2x,to2y)`
- `castTex(toTexId,fromTexId,to1x,to1y,to2x,to2y,from1x,from1y,from2x,from2y)`

> 省略范围时默认使用整个材质

![CastTexCoord](castTexCoord.png)


## 混合材质

使用`blendTex(toTexId,fromTexId,blendRule)`来使用混合规则`blendRule`把材质`fromTex`贴到材质`toTex`上。

1. `blendRule`可以为`NORMAL,ADD,SUBTRACT,MULTIPLY,DIVIDE,MAX,MIN`中的任意一个。
1. `blendRule`可以为字符串，规则如下：
   - `A`代表`toTexId`输入像素
   - `B`代表`fromTexId`输入像素
   - `C`代表`toTexId`输出像素
例如：您可以使用下面的代码来把输入材质和参数层0的图片用加法混合。

```lua:blendRule.lua
version3()
castTex(OUTPUT,INPUT) -- Cast INPUT texture to OUTPUT firstly. 
blendTex(OUTPUT,PARAM0,"C=A+B") -- Blend PARAM0 to OUTPUT. 
```
实际上这里的字符串会被处理成GLSL代码，`"C=A+B"`在内部将变成下面的代码：

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
    C=A+B // Your blend rule is combined here. 
    ;
}
```

跟`castTex`一样，`blendTex`也支持材质范围指定的混色：
- `blendTex(toTexId,fromTexId,blendRule,to1x,to1y,to2x,to2y)`
- `blendTex(toTexId,fromTexId,blendRule,to1x,to1y,to2x,to2y,from1x,from1y,from2x,from2y)`


![CastTexCoord](castTexCoord.png)


## 拷贝材质

使用`copyTex(refTexId)`来拷贝材质，返回被拷贝的新材质。

## 读取和保存材质

使用`savePNG(utf8Path,texId)`,`loadPNG(utf8Path)`来保存、读取PNG图片，使用`saveEXR(utf8Path,texId)`,`loadEXR(utf8Path)`来保存、读取EXR图片。以下是受PixelsWorld支持的图片规格细节：

|格式|使用的库|支持的压缩方式|图片颜色规格|
|--|--|--|--|
|PNG|[cute_headers](https://github.com/RandyGaul/cute_headers)|DEFLATE compliant decompressor zlib(RFC 1950)|RGBA,clamped 8bit unsigned integer per channel. |
|EXR|[tinyexr](https://github.com/syoyo/tinyexr)|NONE,RLE,ZIP,ZIPS,PIZ,ZFP|RGBA,HDR 32bit floating point per channel. (Clamped for Alpha) |

读取PNG图片到场景：

```lua:loadPNG.lua
version3()
local mypng = loadPNG([[d:\test.png]]) -- Replace to your path. 
castTex(OUTPUT,mypng) -- Cast pixels from mypng to OUTPUT. 
```

保存PNG图片到本地：
```lua:loadPNG.lua
version3()

--Draw something to OUTPUT
move(width/2,height/2)
rotate(time)
triangle()
--End drawing. 

savePNG([[d:\test.png]],OUTPUT) -- Save OUTPUT as PNG to local disc. Replace to your path here. 
```

> - 把`PNG`换成`EXR`即可保存、读取EXR图片。
> - 保存到某些位置需要管理员权限。

## 修整材质

使用`rotateTex(texId,times)`来旋转`90*times`度材质，`rotateTex(texId)`等价于`rotateTex(texId,1)`

使用`flipTex(texId,flipV)`来镜像翻转材质，其中`flipV`为布尔值，`flipV`为`true`时垂直镜像，`false`时水平镜像。

使用`resizeTex(texId,width,height)`来缩放材质。

使用`trimTex(texId,p1x,p1y,p2x,p2y)`来裁剪材质。`p1x,p1y,p2x,p2y`是以材质左上角为原点的坐标。