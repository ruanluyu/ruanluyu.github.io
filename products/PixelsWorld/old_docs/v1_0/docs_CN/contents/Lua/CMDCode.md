#CMD代码
---
CMD命令可以通过 ```pw.cmd("你的CMD命令")``` 在 **Lua (CPU & GPU)** 模式下执行。



![LuaMode](LuaMode.png)


```lua:executeCMD.lua
--Works on Windows platform
pw.cmd("echo Hello PixelsWorld! & pause");
```
