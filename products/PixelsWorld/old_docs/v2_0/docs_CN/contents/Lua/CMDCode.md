#CMD代码
---
在 **Lua (CPU & GPU)** 模式下，像素世界可以通过 ```pw.cmd``` 执行CMD命令。



![LuaMode](LuaMode.png)


```lua:executeCMD.lua
--Works on Windows platform
pw.cmd("echo Hello PixelsWorld! & pause");
```
