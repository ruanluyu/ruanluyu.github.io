# 链接参数
---

使用下面的函数调用插件面板上的参数。

```lua:parameters.lua
slider(id)  -- 返回1个double
angle(id)  -- 返回1个double
point(id)  -- 返回2个double
point3d(id) -- 返回3个double
checkbox(id) -- 返回1个boolean
color(id) -- 返回3个double
layer(id,x,y) -- 返回4个double
```

当有多个变量返回的时候，您需要声明多个变量来接住返回值，例如`point()`函数

```lua:point.lua
version3()
x,y = point(0)
println('x is ' .. x)
println('y is ' .. y)
```

![运行结果](linkPoint.png)
