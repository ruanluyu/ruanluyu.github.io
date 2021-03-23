# 预定义代码

shader代码在运行前，前后会被接上我们预先设定的环境代码来支持不同的特性。
- GLSL模式只含有前置代码。
- shadertoy模式有前置代码和后置代码。


## GLSL模式

### 前置代码：

```glsl:pre_frag_shader_glsl.frag
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
uniform float inpoint;
uniform float duration;
uniform float comp_time;
uniform vec4 date;
uniform float fps;
uniform float width;
uniform float height;
uniform vec2 origin;
uniform vec2 resolution;
uniform vec2 downsample;

uniform mat4 camera_matrix;
uniform vec4 camera_info; // x,y: resolution, z: distance to plane, w: distance to focus. 
uniform bool camera_perspective;

uniform sampler1D inWaveL;
uniform sampler1D inWaveR;
uniform float inWaveN;
uniform float inWaveS;
uniform sampler1D inSpecL;
uniform sampler1D inSpecR;
uniform float inSpecN;

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
return myuv*resolution.xy;
}

vec2 xy2uv(vec2 myxy){
return myxy/resolution.xy;
}

vec3 lookat(vec3 globalxyz){
return transpose(mat3(camera_matrix)) * (globalxyz - camera_matrix[3].xyz);
}

vec3 xyz2uvw(vec3 globalxyz){
vec3 eyepos = lookat(globalxyz);
vec3 myuvw;
if(camera_perspective)
{
myuvw.x = eyepos.x * camera_info.w / (camera_info.x * eyepos.z) + .5;
myuvw.y = -eyepos.y * camera_info.w / (camera_info.y * eyepos.z) + .5;
myuvw.z = eyepos.z / camera_info.w; 
}
else
{
myuvw.x = eyepos.x / (camera_info.x * 2.) + .5;
myuvw.y = -eyepos.y / (camera_info.y * 2.) + .5;
myuvw.z = eyepos.z / camera_info.w; 
}
return myuvw;
}

vec2 rawpoint(int id)
{
return (point[id] - vec2(0,1)) * vec2(1,-1) * resolution.xy;
}

vec3 rawpoint3d(int id)
{
return (point3d[id] - vec3(0,1,0)) * vec3(1,-1,1) * vec3(resolution.xy,1);
}

```

## shadertoy 代码

### 前置代码

```glsl:pre_frag_shader_shadertoy.frag

#define gl_Position (_PixelsWorld_uv * iResolution.xy)
#define gl_FragCoord (_PixelsWorld_uv * iResolution.xy)
#define gl_FragColor _PixelsWorld_outColor
uniform vec3 iResolution;
uniform float iTime;
uniform float iTimeDelta;
uniform int iFrame;
// uniform float iChannelTime[4];
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
uniform float _PixelsWorld_inpoint;
uniform float _PixelsWorld_duration;
uniform float _PixelsWorld_comp_time;
uniform vec4 _PixelsWorld_date;
uniform float _PixelsWorld_fps;
uniform float _PixelsWorld_width;
uniform float _PixelsWorld_height;
uniform vec2 _PixelsWorld_origin;
uniform vec2 _PixelsWorld_resolution;
uniform vec2 _PixelsWorld_downsample;

uniform mat4 _PixelsWorld_camera_matrix;
uniform vec4 _PixelsWorld_camera_info;
uniform bool _PixelsWorld_camera_perspective;

uniform sampler1D _PixelsWorld_inWaveL;
uniform sampler1D _PixelsWorld_inWaveR;
uniform float _PixelsWorld_inWaveN;
uniform float _PixelsWorld_inWaveS;
uniform sampler1D _PixelsWorld_inSpecL;
uniform sampler1D _PixelsWorld_inSpecR;
uniform float _PixelsWorld_inSpecN;

in vec2 _PixelsWorld_uv;
out vec4 _PixelsWorld_outColor;
```

### 后置代码

```glsl:post_frag_shader_shadertoy.frag
void main(){
    mainImage(_PixelsWorld_outColor, _PixelsWorld_uv * iResolution.xy);
}
```