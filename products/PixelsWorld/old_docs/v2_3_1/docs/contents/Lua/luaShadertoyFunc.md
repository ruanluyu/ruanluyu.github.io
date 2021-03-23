#pw.shadertoy(shadertoyCode)
---

**Description**

- Render code from shadertoy

**Parameters**

- pw.shadertoy(shadertoyCode).
- pw.shadertoy(shadertoyCode,useBuffer).
- shadertoyCode: String
- [useBuffer](RunGLSL.md): Bool

**Return**

- No

**Example**

```lua:shadertoy.lua
pw.shadertoy([==[
void mainImage( out vec4 fragColor, in vec2 fragCoord ){
	fragColor=vec4(vec3(fragCoord.xy/iResolution.xy,sin(iTime)),1);
}
]==])
```