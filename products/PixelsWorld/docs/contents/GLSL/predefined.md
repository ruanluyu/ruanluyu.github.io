# Predifined code

Before run shader code, PixelsWorld conbine your input with some predifined code to support some features. 

- GLSL mode only has pre-define code. 
- shadertoy mode has both pre-define and post-define code. 


## GLSL mode

### Pre-define code

```glsl:pre_frag_shader_glsl.frag
#define gl_Position uv2xy(uv)
#define gl_FragCoord uv2xy(uv)
#define gl_FragColor outColor
#define INPUT_LAYER_INDEX -1
#define OUTPUT_LAYER_INDEX -2
#define AE_INPUT_LAYER -1
#define PW_TEMP_LAYER -2
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
uniform vec4 date; // vec4(year,month,day,hour*3600 + minute*60 + second + millisecond/1000.)
uniform float fps;
uniform float width;
uniform float height;
uniform vec2 origin;
uniform vec2 resolution;
uniform vec2 downsample;

uniform mat4 camera_matrix;
uniform vec4 camera_info; // x,y: resolution, z: distance to plane, w: distance to focus. 
uniform bool camera_perspective;

uniform sampler1D inWaveL; // Left wave samples
uniform sampler1D inWaveR; // Right wave samples
uniform float inWaveN; // Wave sample number
uniform float inWaveS; // Sample rate, settings in plugin panel. Default: 44100.
uniform vec2 inWaveT; // vec2(sampleStartTime, sampleEndTime), unit: second. New in v3.4.0
uniform sampler1D inSpecL; // Left spectrum samples
uniform sampler1D inSpecR; // Right spectrum samples
uniform float inSpecN; // Spectrum sample number
uniform vec2 inSpecF; // vec2(spectrumStartFrequency, spectrumEndFrequency), unit: hz. New in v3.4.0

vec4 getColor(int layerId,vec2 coord)
{
if(layerId==AE_INPUT_LAYER) return texture(inLayer,coord);
if(layerId==PW_TEMP_LAYER) return texture(outLayer,coord);
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

```

## shadertoy mode

### Pre-define code

```glsl:pre_frag_shader_shadertoy.frag
#define gl_Position (_PixelsWorld_uv * iResolution.xy)
#define gl_FragCoord (_PixelsWorld_uv * iResolution.xy)
#define gl_FragColor _PixelsWorld_outColor
#define _PixelsWorld_INPUT_LAYER_INDEX -1
#define _PixelsWorld_OUTPUT_LAYER_INDEX -2
#define _PixelsWorld_AE_INPUT_LAYER -1
#define _PixelsWorld_PW_TEMP_LAYER -2
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
uniform vec2 _PixelsWorld_inWaveT;
uniform sampler1D _PixelsWorld_inSpecL;
uniform sampler1D _PixelsWorld_inSpecR;
uniform float _PixelsWorld_inSpecN;
uniform vec2 _PixelsWorld_inSpecF;

in vec2 _PixelsWorld_uv;
out vec4 _PixelsWorld_outColor;

vec4 _PixelsWorld_getColor(int layerId,vec2 coord)
{
if(layerId==_PixelsWorld_AE_INPUT_LAYER) return texture(_PixelsWorld_inLayer,coord);
if(layerId==_PixelsWorld_PW_TEMP_LAYER) return texture(_PixelsWorld_outLayer,coord);
else if(layerId>=0 && layerId<=9) return texture(_PixelsWorld_layer[layerId],coord);
return vec4(0.0);
}

vec4 _PixelsWorld_getColor(vec2 coord)
{
return texture(_PixelsWorld_inLayer,coord);
}

vec2 _PixelsWorld_uv2xy(vec2 myuv){
return myuv*_PixelsWorld_resolution.xy;
}

vec2 _PixelsWorld_xy2uv(vec2 myxy){
return myxy/_PixelsWorld_resolution.xy;
}



```

### Post-define code

```glsl:post_frag_shader_shadertoy.frag
void main(){
    mainImage(_PixelsWorld_outColor, _PixelsWorld_uv * iResolution.xy);
}
```