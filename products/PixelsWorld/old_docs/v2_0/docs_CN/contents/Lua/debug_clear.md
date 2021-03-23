#pw.debug.clear()
---

**说明：**

- 在调试窗口中删除信息。

**参数：**

- pw.debug.clear()

**返回：**

- 无。

**示例：**

```lua:pw_debug_clear1.lua
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
pw.debug.clear()
```
> - 在示例代码 **pw_debug_clear1.lua**中，所有信息都将被删除，故没有信息保留。
> - 如果想在运行代码前删除旧的调试信息，请使用以下代码：
```lua:pw_debug_clear2.lua
pw.debug.clear()
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
```