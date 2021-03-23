#pw.full_glsl(full_glslCode)
---

**说明：**

- 运行GLSL代码。

**参数：**

- pw.full_glsl(full_glslCode).
- pw.full_glsl(full_glslCode,useBuffer).
- full_glslCode : 字符串(见示例)
- [useBuffer](RunGLSL.md) : 布尔值。

**返回：**

- 无

**错误：**

- 来自渲染GLSL的错误信息将被忽视。

**示例：**

- 此代码的效果与 [pw.glsl](glsl.md)中的示例代码效果相同。区别在于您需要自己编写代码的前缀。
```lua:full_glsl.lua
pw.full_glsl([==[
    #version 330 core
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
    uniform float fps;
    uniform float width;
    uniform float height;
    uniform vec2 origin;
    uniform vec2 resolution;

    void main(){
        outColor = vec4(uv,mod(time,1),1);
    }
]==])
```

