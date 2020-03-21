#pw.debug.remain(numToRemain)
---

**说明：**

- 在调试窗口保留信息。

**参数：**

- pw.debug.remain()
- pw.debug.remain(numToRemain)
- numToRemain

> 注意： ```pw.debug.remain()```等同于 ```pw.debug.remain(1)```

**返回：**

- 无。

**示例：**

```lua:pw_debug_remain.lua
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
pw.debug.remain(3)
```