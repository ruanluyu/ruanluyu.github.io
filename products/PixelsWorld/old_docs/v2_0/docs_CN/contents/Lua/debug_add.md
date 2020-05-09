#pw.debug.add(message)
---

**说明：**

- 在调试窗口中插入信息。
> 注意： 与[```pw.report()```](report.md)相同

**参数：**

- pw.debug.add()
- pw.debug.add(message)
- message：字符串

> 注意： ```pw.debug.add()``` 在调试窗口不会生效，而 ```pw.debug.add("")``` 则会添加换行符 ("\n"). 

**返回**

- 无。

**示例**

```lua:pw_debug_add.lua
pw.debug.add("Message from time "..time.."\nHello PixelsWorld!\n")
```