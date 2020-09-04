#在lua中运行GLSL
---

##用法
```lua:glsl.lua
version3()
glsl(Your_code_string_here)
```
注意，我们推荐使用`[==[Your_code_string_here]==]`符号把字符串括起来，这样不会产生任何转译问题。即：一般您的代码需要写成下面这种形式：

```lua:glsl2.lua
version3()
glsl([==[
void main(){
    outColor = vec4(uv,sin(time*10)/2+.5,1)；
}
]==])
```

使用下面的代码可以渲染来自`shadertoy.com`的代码
```lua:shadertoy.lua
version3()
shadertoy(Your_shadertoy_code_here)
```
<br><br><br><br><br><br>