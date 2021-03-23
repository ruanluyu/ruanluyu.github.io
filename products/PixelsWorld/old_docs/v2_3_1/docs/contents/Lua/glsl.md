#pw.glsl(glslCode)
---

**Description :**

- Render glsl code. 

**Parameters :**

- pw.glsl(glslCode).
- pw.glsl(glslCode,useBuffer).
- glslCode : string
- [useBuffer](RunGLSL.md) : bool

**Return :**
- No return. 

**Error : **
- Error message from GLSL render machine will be thrown. 

**Sample code :**
```lua:glsl.lua
pw.glsl([==[
    void main(){
        outColor = vec4(uv,mod(time,1),1);
    }
]==])
``` 