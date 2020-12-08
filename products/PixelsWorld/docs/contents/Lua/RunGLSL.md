# Run GLSL in Lua
---

## Usage

```lua:glsl.lua
version3()
glsl(Your_code_string_here)
```

Note: We recommend using `[==[Your_code_string_here]==]` to quote your string on account of avoiding escape characters. Namely, your code should be like: 

```lua:glsl2.lua
version3()
glsl([==[
void main(){
    outColor = vec4(uv,sin(time*10)/2+.5,1);
}
]==])
```

The following function can run the code from `shadertoy.com`. 

```lua:shadertoy.lua
version3()
shadertoy(Your_shadertoy_code_here)
```