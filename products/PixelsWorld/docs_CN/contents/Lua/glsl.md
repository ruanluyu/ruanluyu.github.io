#pw.glsl(glslCode)
---

**说明：**

- 渲染glsl代码。 

**参数：**

- pw.glsl(glslCode).
- pw.glsl(glslCode,useBuffer).
- glslCode：字符串
- [useBuffer](RunGLSL.md) ：布尔值

**返回：**

- 无。

**错误： **

- 来自渲染GLSL的错误信息将被忽视。 

**示例：**

```lua:glsl.lua
pw.glsl("void main(){\
outColor = vec4(uv,mod(time,1),1);\
}")
```