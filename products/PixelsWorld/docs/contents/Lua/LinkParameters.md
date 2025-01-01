# Link Parameters
---

Use the following functions to call parameters on the plugin panel.

```lua:parameters.lua
slider(id)  -- Returns 1 double
angle(id)  -- Returns 1 double
point(id)  -- Returns 2 doubles
point3d(id) -- Returns 3 doubles
checkbox(id) -- Returns 1 boolean
color(id) -- Returns 3 doubles
layer(id, x, y) -- Returns 4 doubles
```

When multiple variables are returned, you need to declare multiple variables to catch the return values, for example with the `point()` function.

```lua:point.lua
version3()
x, y = point(0)
println('x is ' .. x)
println('y is ' .. y)
```

![Execution Result](linkPoint.png)