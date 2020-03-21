#pw.debug.sub(numToSub)
---

**说明：**

- 在调试窗口中删除信息。

**参数：**

- pw.debug.sub()
- pw.debug.sub(numToSub)
- numToSub : 整数，要删除的行数。  

> 注意：: ```pw.debug.sub()``` 等同于```pw.debug.sub(1)```

**返回：**

- 无。

**示例：**

```lua:pw_debug_sub.lua
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
pw.debug.sub(3)
```