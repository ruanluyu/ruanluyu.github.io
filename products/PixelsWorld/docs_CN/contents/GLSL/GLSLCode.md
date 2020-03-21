#在PixelsWorld运行GLSL 
---
本节中, 我们将快速了解如何在PixelsWorld运行GLSL 

##GLSL是什么?
 GLSL是OpenGL Shader Language的缩写，它是由OpenGL支持的基于GPU的渲染语言。
 主要通过编写像素渲染规则，使用GPU进行计算。

> 关于GLSL语法的更多信息 ,  建议您访问 [shadertoy.com](https://www.shadertoy.com/).  找到一些有趣且简单的效果，来探索它是如何生效的。 

##细节 : 

> **PixelsWorld V2.0** 使用的是 **#version 330 core**. 

- 只需在PixelsWorld书写您需要的  **Fragment shader** 代码即可 。
- 同时，PixelsWorld 会在您的代码运行之前，合并一些额外的代码，为了使其与After Effects平台兼容，我们列出了部分代码供您参考。 

```glsl:extra.shader
#version 330 core
#define platform 0 // If you are on windows platform
#define platform 1 // If you are on mac platform
#define platform -1 // If you are on unknown platform
#define host 0 // If you are on Ae host 
#define gl_Position uv2xy(uv)
#define gl_FragCoord uv2xy(uv)
#define gl_FragColor outColor
#define INPUT_LAYER_INDEX -1
#define OUTPUT_LAYER_INDEX -2
out vec4 outColor;
in vec2 uv;
uniform float slider[10];
uniform float angle[10];
uniform bool checkbox[10];
uniform vec2 point[10];
uniform vec3 point3d[10];
uniform vec4 color[10];
uniform sampler2D layer[10];
uniform vec2 layerResolution[10];
uniform sampler2D inLayer;
uniform sampler2D outLayer;
uniform float time;
uniform vec4 date;
uniform float fps;
uniform float width;
uniform float height;
uniform vec2 origin;
uniform vec2 resolution;


vec4 getColor(int layerId,vec2 coord)
{
	if(layerId==INPUT_LAYER_INDEX) return texture(inLayer,coord);
	if(layerId==OUTPUT_LAYER_INDEX) return texture(outLayer,coord);
	else if(layerId>=0 && layerId<=9) return texture(layer[layerId],coord);
	return vec4(0.0);
}

vec4 getColor(vec2 coord)
{
	return texture(inLayer,coord);
}

vec2 uv2xy(vec2 myuv){
	return myuv*resolution;
}

vec2 xy2uv(vec2 myxy){
	return myxy/resolution;
}

```

