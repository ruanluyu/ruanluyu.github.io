#pw.shadertoy(shadertoyCode)
---

**说明：**

- 渲染来自shadertoy的代码。 

**参数：**

- pw.shadertoy(shadertoyCode).
- pw.shadertoy(shadertoyCode,useBuffer).
- shadertoyCode：字符串
- [useBuffer](RunGLSL.md) ：布尔值

**返回：**

- 无。

**错误： **

- 来自渲染的错误信息将被忽视。 

**示例：**

```lua:shadertoy.lua
pw.shadertoy([==[
void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	fragColor=vec4(vec3(fragCoord.xy/iResolution.xy,sin(iTime)),1);
}
]==])
```