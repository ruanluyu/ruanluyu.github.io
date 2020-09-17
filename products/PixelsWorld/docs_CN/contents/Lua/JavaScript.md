#JavaScript代码
---
在 **Lua (CPU & GPU)** 模式下，像素世界可以通过 ```js``` 执行JavaScript代码。


![LuaMode](LuaMode.png)


```lua:executeJS.lua
version3()
js("alert('Hello PixelsWorld!')");
```
> 注意：由于Ae程序结构问题，我们不推荐您在像素世界中使用js代码（尤其是索取UI控件参数信息）。您可以用js代码做简单的局部变量之间的计算。