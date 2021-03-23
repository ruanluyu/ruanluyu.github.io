#运行Lua代码
---

切换语言为**Lua ( CPU & GPU )**


![LuaMode](LuaMode.png)


导入代码： 
```lua:hello.lua
a = 5+6
b = "PixelsWorld"
c = "is cool!"
d = time
e = pw.ch("slider",0)
f = "5 + 6 = " .. a .. "\nMessage : " .. b .. " " .. c .. "\nCurrent time is : " .. d .. " (s)\nValue of slider0 is : " .. e
pw.print(f)
```

> - ``` a..b ``` 将变量a与b合并为字符串。
> - [```pw.print()```](report.md) 在屏幕上渲染信息。
> - [```pw.ch()```](ch.md) 获取指定参数值。
> - 您可以在每行的末尾添加 ```;``` 非必须。Lua会将`\ n`（换行符）视为一段代码的结束标记。

