#Render GLSL code with PixelsWorld
---
In this chapter, we will have a quick look of how to make PixelsWorld run GLSL code. 

##But what is GLSL?
GLSL is abbreviation of **OpenGL Shader Language**, it is a GPU based render language powered by OpenGL. 
The main idea of GLSL is that you write the rules of **how pixels render themselves**, then the GPU can hire lots of *"workers"* to do the calculation for you.  
> If you want to learn more about the grammar of GLSL, we recommand you having a look at [shadertoy.com](https://www.shadertoy.com/). Find some interesting but simple effects and figure out why this works. 



##Message for VETERAN : 
> **PixelsWorld V1.0** uses **#version 330 core**. 
 
- Only the **Fragment shader** you need to write in PixelsWorld. 
- PixelsWorld will combine some extra code behind your code to link with After Effects platform. We list the code here for your reference. 

```glsl:extra.shader
#define gl_Position uv2xy(uv)
#define gl_FragCoord uv2xy(uv)
#define gl_FragColor outColor
out vec4 outColor;
in vec2 uv;
uniform float slider[10];
uniform float angle[10];
uniform bool checkbox[10];
uniform vec2 point[10];
uniform vec3 point3d[10];
uniform vec4 color[10];
uniform sampler2D layer[10];
uniform sampler2D inLayer;
uniform float time;
uniform float width;
uniform float height;
uniform vec2 origin;
uniform vec2 resolution;
uniform vec2 reverseUV;

vec4 getColor(int layerId,vec2 coord)
{
	vec2 one = vec2(1.0);
	if(layerId==-1) return texture2D(inLayer,(one-reverseUV) * coord + reverseUV * (one-coord));
	else if(layerId>=0 && layerId<=9) return texture2D(layer[layerId],(one-reverseUV) * coord + reverseUV * (one-coord));
	return vec4(0.0);
}
vec4 getColor(vec2 coord)
{
	vec2 one = vec2(1.0);
	return texture2D(inLayer,(one-reverseUV) * coord + reverseUV * (one-coord));
}
vec2 uv2xy(vec2 myuv){
	return myuv*resolution;
}
vec2 xy2uv(vec2 myxy){
	return myxy/resolution;
}

// Your glsl code will show up here. 
```

