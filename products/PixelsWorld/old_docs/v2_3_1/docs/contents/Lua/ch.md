#pw.ch(name,id)
---

**Description :**

- Get value of parameters. 

**Parameters :**

- pw.ch("slider", id).
- pw.ch("angle", id).
- pw.ch("checkbox", id).
- pw.ch("point", id [, dim]).
- pw.ch("3dpoint", id, [, dim]).
- pw.ch("color", id, [, dim]).
- pw.ch("layer",id, x, y).
- id : integer in range 0~9.
- dim : integer start from 0. Its range is based on the params' type. 
- x,y : integers.

**Return :**
- "slider" : returns 1 float.
- "angle" : returns 1 float.
- "checkbox" : returns 1 float , 0.0 or 1.0.
- "point" : returns 2 floats, if dim is specified, returns 1 floats.
- "3dpoint" : returns 3 floats, if dim is specified, returns 1 floats.
- "color" : returns **3 floats**, which  represents R, G, B, if dim is specified, returns 1 floats.
- "layer" : returns 4 floats, which represents A, R, G, B.

**Sample code :**
```lua:ch.lua
pw.report("The blue color of color 7 is " .. pw.ch("color", 7, 2))
```