#pw.ch(name,id)
---

**说明：**

- 获得参数的值。 

**参数：**

- pw.ch("slider", id).
- pw.ch("angle", id).
- pw.ch("checkbox", id).
- pw.ch("point", id [, dim]).
- pw.ch("3dpoint", id, [, dim]).
- pw.ch("color", id, [, dim]).
- pw.ch("layer",id, x, y).
- id : 0~9的整数
- dim :始于0的整数。参数范围取决于参数类型。 
- x,y ：整数。

**返回：**

- "slider"：返回一个浮点数。
- "angle"：返回一个浮点数。
- "checkbox" ：返回一个浮点数。 0.0 或1.0
- "point"：返回两个浮点数。如果dim指定，则返回一个浮点数。
- "3dpoint"：返回三个浮点数，如果dim指定，则返回一个浮点数。
- "color"：返回三个浮点数， 即R, G, B。如果dim指定，则返回一个浮点数。
- "layer" ：返回四个浮点数，即A, R, G, B

**示例**

```lua:ch.lua
pw.report("The blue color of color 7 is " .. pw.ch("color", 7, 2))
```