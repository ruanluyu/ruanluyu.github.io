# Texture system
---

> Make sure your PixelsWorld version is `v3.3.0+`

This section gives a detailed introduction of Texture system in PixelsWorld. 

 <!-- no toc -->
- [newTex](#create-texture)
- [delTex](#delete-texture)
- [getSize](#size-of-texture)
- [swapTex](#swap-textures)
- [drawTo](#set-drawto)
- [castTex](#cast-texture)
- [blendTex](#blend-textures)
- [copyTex](#copy-texture)
- [fetchTex](#fetch-texture-at-any-time)
- [savePNG,loadPNG,saveEXR,loadEXR,saveRAW,loadRAW](#texture-io)
- [rotateTex,flipTex,resizeTex,trimTex](#edit-texture)

## Texture id

In PixelsWorld, every texture is represented as an integer. It is called `texId`. The basic texIds provided by PixelsWorld are as followed. 


|texId|Globals in Lua|Globals in GLSL|Globals Shadertoy|Description|
|--|--|--|--|--|
|`-3`|`OUTPUT`|Inaccessible|Inaccessible|Output texture|
|`-2`|`TEMP`|`PW_TEMP_LAYER`|`_PixelsWorld_PW_TEMP_LAYER`|Cache texture|
|`-1`|`INPUT`|`AE_INPUT_LAYER`|`_PixelsWorld_AE_INPUT_LAYER`|Input texture|
|`0`|`PARAM0`|`0`|`0`|Layer parameter 0 texture|
|`1`|`PARAM1`|`1`|`1`|Layer parameter 1 texture|
|`...`|`PARAM...`|`...`|`...`|...|
|`9`|`PARAM9`|`9`|`9`|Layer parameter 9 texture|

> You can also create your texId. The method will be covered below. 

## How they work

Normally, Ae sends a picture to PixelsWorld to process. PixelsWorld loads it to the `INPUT` texId, writes the result to `OUTPUT` texId. Finally blits all pixels to Ae. 


## What is TEMP texId

Because `OpenGL` doesn't support read and write to the same texture at the same time. PixelsWorld provides TEMP texId to hold the last shading results (Means the TEMP texId only makes sense in Lua mode and you called glsl function twice or more). You can use `getColor(PW_TEMP_LAYER,uv);` in glsl code to sample colors in TEMP texId. 


---

## Create texture

Use `newTex(width,height)` to create a texture. Returns a texId. (a random integer)

## Delete texture

Use `delTex(id)` to delete a texture. 
> In most cases, you don't have to delete texture by yourself. PixelsWorld will release all texture memory at the end of each frame. 


## Size of texture

Use `getSize(id)` to get the size of a texture. 

```lua:getSize.lua
version3()
mytex = newTex(512,256)
w,h = getSize(mytex)
println("Width of mytex is: " .. w)
println("Height of mytex is: " .. h)
```

![getSizeRes](getSizeRes.png)


## Swap textures

Use `swapTex(id1,id2)` to swap the pixels data of `id1` and `id2`. 

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

## Set drawTo

Use `drawTo(id)` to set the texture the objs would be drawn. The default drawTo texId is `OUTPUT`. Note that PixelsWorld only blits pixels in `OUTPUT` to Ae, no matter what the drawTo texId is. Here are 3 approaches you can send pixels in other texId to `OUTPUT`:  

1. `drawTo(OUTPUT)`+[`image`](./FuncList.md#image)
2. [`castTex`](#cast-texture)
3. [`swapTex`](#swap-textures)

## Cast texture

Use `castTex(toTexId,fromTexId)` to cast pixels data from `fromTexId` to `toTexId`. E.g. You can cast pixels in `PARAM0` to `OUTPUT`. 


```lua:castTex.lua
version3()
castTex(OUTPUT,PARAM0)
```

You can also specify the cast range. (The origin is left top corner)

- `castTex(toTexId,fromTexId,to1x,to1y,to2x,to2y)`
- `castTex(toTexId,fromTexId,to1x,to1y,to2x,to2y,from1x,from1y,from2x,from2y)`

> Cast all pixels by default. 

![CastTexCoord](castTexCoord.png)


## Blend textures

Use `blendTex(toTexId,fromTexId,blendRule)` to blend `fromTex` to `toTex` by rule `blendRule`

1. `blendRule` can be one of `NORMAL,ADD,SUBTRACT,MULTIPLY,DIVIDE,MAX,MIN`. 
2. `blendRule` can be blend rule(string).
   - `A` menas input pixels of `toTexId`
   - `B` means input pixels of `fromTexId`
   - `C` means output pixels of `toTexId`
E.g. you can specify your rule to blend `PARAM0` and `INPUT`. 

```lua:blendRule.lua
version3()
castTex(OUTPUT,INPUT) -- Cast INPUT texture to OUTPUT firstly. 
blendTex(OUTPUT,PARAM0,"C=A+B") -- Blend PARAM0 to OUTPUT. 
```
Indeed, the `"C=A+B"` will be processed to the following code inside PixelsWorld. 

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
    outColor = C;
}
```

Same with `castTex`, `blendTex` also supports range specifying: 

- `blendTex(toTexId,fromTexId,blendRule,to1x,to1y,to2x,to2y)`
- `blendTex(toTexId,fromTexId,blendRule,to1x,to1y,to2x,to2y,from1x,from1y,from2x,from2y)`


![CastTexCoord](castTexCoord.png)


## Copy texture

Use `copyTex(refTexId)` to copy texture. Returns new texId. 

## Fetch texture at any time

Use `fetchTex(layerId, time)` to obtain the specified layer pixels at the specified time. It returns a random texture ID.

- layerId: Only `PARAM0~PARAM9` are accepted. 
- time: The double layer time in seconds. 

> - Note: Use of this function would cause wrong caching. Please purge the chache while you are using this function. 
> - New in `v3.4.3+`. 

## Texture IO

Use `savePNG(utf8Path,texId)`,`loadPNG(utf8Path)` to save or load PNG image. 

Use `saveEXR(utf8Path,texId)`,`loadEXR(utf8Path)` to save or load EXR image. 

Use `saveRAW(utf8Path,texId)`,`loadRAW(utf8Path)` to save or load MiLai original raw memory image. 

Supported image specifications are listed below. 

|Format|Library|Supported compression algorithms|Color format|
|--|--|--|--|
|PNG|[cute_headers](https://github.com/RandyGaul/cute_headers)|DEFLATE compliant decompressor zlib(RFC 1950)|RGBA,clamped 8bit unsigned integer per channel. |
|EXR|[tinyexr](https://github.com/syoyo/tinyexr)|NONE,RLE,ZIP,ZIPS,PIZ,ZFP|RGBA,HDR 32bit floating point per channel. |
|RAW|(None)|MiLai original format. (See figure below)|RGBA, HDR 32bit floating-point per channel. |

![MiLaiRAWDef](./milaiBinaryDef.png)

Load PNG image to scene: 

```lua:loadPNG.lua
version3()
local mypng = loadPNG([[d:\test.png]]) -- Replace to your path. 
castTex(OUTPUT,mypng) -- Cast pixels from mypng to OUTPUT. 
```

Save `OUTPUT` texId to local: 
```lua:savePNG.lua
version3()

--Draw something to OUTPUT
move(width/2,height/2)
rotate(time)
triangle()
--End drawing. 

savePNG([[d:\test.png]],OUTPUT) -- Save OUTPUT as PNG to local disc. Replace to your path here. 
```

> - Change `PNG` to `EXR` to read/write EXR file. 
> - Some local paths might need running Ae under the Administrator mode. 

## Edit texture

Use `rotateTex(texId,times)` to rotate texture `90*times`degrees, `rotateTex(texId)` equals to `rotateTex(texId,1)`

Use `flipTex(texId,flipV)` to mirror flip a image. `flipV` is a boolean. When `flipV` is `true`, flip the image vertically, and horizontally otherwise. 

Use `resizeTex(texId,width,height)` to resize texture. 

Use `trimTex(texId,p1x,p1y,p2x,p2y)` to trim texture. The origin of `p1x,p1y,p2x,p2y` is left top corner. 