# 世界的中心Lua
---

>** Lua是一种轻量级，高级，多范式编程语言，主要用于嵌入式应用程序中.* [——Wiki](https://en.wikipedia.org/wiki/Lua_(programming_language))

**版本 : [Lua5.3](https://www.lua.org/manual/5.3/)**

与GLSL不同，Lua语言运行在CPU上，是像素世界的中心，连接了所有模块。

像素世界的所有渲染指令都可以通过Lua这个中枢发出。比如您想渲染GLSL代码，只需要输入

```lua:RunGlsl.lua
pw.glsl([==[
在这里输入您的代码
    ]==])
```

并在中间输入GLSL代码即可；

如果您想执行[shadertoy](shadertoy.md)的代码，只需要输入
```lua:RunShadertoy.lua
pw.shadertoy([==[
在这里输入您的代码
    ]==])
```
并在中间输入来自shadertoy的代码即可。

我们在这里列出Lua的能力范畴：
- 获取像素数据
- 编写像素数据
- 运行 JavaScript
- 运行 GLSL
- 获取参数数据
- 运行外置C语言库
- 加载Lua模块

同时Lua与JavaScript非常相似，因为JavaScript是非常易学的语言，所以即使您没有编程基础也会在短时间内迅速掌握它。


<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>