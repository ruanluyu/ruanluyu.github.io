# pw.print()
---

**说明：**

- 在屏幕上生成一串信息(仅支持ASCII字符)。


**参数：**

- pw.print(str)
- pw.print(str,alpha,red,green,blue)
- str: 输出信息
- alpha: 字体透明度
- red: 字体红色数值
- green: 字体绿色数值
- blue: 字体蓝色数值

**返回：**

- 无

**示例**

```lua:print.lua
pw.print("Hello!");
pw.print("Hello!",1,0.5,0.5,1);
```

**也请参考**

[pw.println()](println.md)
