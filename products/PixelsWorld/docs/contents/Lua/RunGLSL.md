# Running GLSL in Lua
---

## Usage

```lua:glsl.lua
version3()
glsl(Your_code_string_here)
```

Note that we recommend using `[==[Your_code_string_here]==]` to enclose the string to avoid any escaping issues. For example, your code should generally be written in the following form:

```lua:glsl2.lua
version3()
glsl([==[
void main(){
    outColor = vec4(uv,sin(time*10)/2+.5,1);
}
]==])
```

The following code can be used to render code from `shadertoy.com`:

```lua:shadertoy.lua
version3()
shadertoy(Your_shadertoy_code_here)
```
<br><br><br><br><br><br>