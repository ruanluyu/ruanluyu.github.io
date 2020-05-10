# GPU Berserker GLSL
---

In this section, we will have a quick look at how the GLSL works in PixelsWorld. 

## What is GLSL? 
 
> GLSL is an abbreviation of OpenGL Shader Language, which is supported by OpenGL, run on GPU. 

### In short
GLSL is what we used in [section one](../../README.md), it can run on GPU. 

### Advantage of GPU render

If we treat CPU as a supercar, the GPU should be more like a bus. 

![Metaphor](bus_vs_car.png)

In the case we transport little people, like one or three, the supercar would be nice. (Handle single complicated calculation)

But when there are thousands of people need to be transported, it seems that the bus should be the right option. (Render thousands of data symultaneously)

The language we are learning, like C/C++, Java, Python, almost are running on CPU.

Languages like GLSL, is designed for GPU. 

When we are about to render a picture. GPU can distribute one repetitive task to a number of "workers". 


> If you want to learn more about GLSL, we recommand you to go to [shadertoy.com](https://www.shadertoy.com/), find some interesting arts and make out why this works. 

## Details

Before the GLSL is sent to OpenGL, PixelsWorld will combine pre-defined and post-defined codes to support features of Ae. If you are beginner, you can ignore this section for the moment. 


- **PixelsWorld V2.0** use **#version 330 core**. 

Here are pre-defined and post-defined codes. 

### Predefined codes on the GLSL mode

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

### No post-defined codes on the GLSL mode

### Pre-defined codes on the shadertoy mode


```glsl:extra_shadertoy_front.shader

#define gl_Position (_PixelsWorld_uv * iResolution.xy)
#define gl_FragCoord (_PixelsWorld_uv * iResolution.xy)
#define gl_FragColor _PixelsWorld_outColor
uniform vec3 iResolution;
uniform float iTime;
uniform float iTimeDelta;
uniform int iFrame;
uniform vec4 iMouse;
uniform vec4 iDate;
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;
uniform vec3 iChannelResolution[4];

#define INPUT_LAYER_INDEX -1
#define OUTPUT_LAYER_INDEX -2

uniform float _PixelsWorld_slider[10];
uniform float _PixelsWorld_angle[10];
uniform bool _PixelsWorld_checkbox[10];
uniform vec2 _PixelsWorld_point[10];
uniform vec3 _PixelsWorld_point3d[10];
uniform vec4 _PixelsWorld_color[10];
uniform sampler2D _PixelsWorld_layer[10];
uniform vec2 _PixelsWorld_layerResolution[10];
uniform sampler2D _PixelsWorld_inLayer;
uniform sampler2D _PixelsWorld_outLayer;
uniform float _PixelsWorld_time;
uniform vec4 _PixelsWorld_date;
uniform float _PixelsWorld_fps;
uniform float _PixelsWorld_width;
uniform float _PixelsWorld_height;
uniform vec2 _PixelsWorld_origin;
uniform vec2 _PixelsWorld_resolution;

in vec2 _PixelsWorld_uv;
out vec4 _PixelsWorld_outColor;

```

### Post-defined codes on the shadertoy mode


```glsl:extra_shadertoy_back.shader
void main(){
	mainImage(_PixelsWorld_outColor, _PixelsWorld_uv * iResolution.xy);
}
```

<br><br><br><br><br><br><br>