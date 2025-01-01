# uv2xy, xy2uv
---
These two functions are used for conversion between **UV coordinates** and **XY coordinates** by performing simple multiplication and division.

## uv2xy(vec2)
**Description:**

- Calculate xy values from given uv values.

**Parameter:**

- vec2 : uv position value.

**Returns:**

- vec2 : xy position value.

> **Note:**
> If the layer dimensions are 1280 x 720, `uv2xy(vec2(0.1,0.5));` returns `vec2(128.0,360.0);`

## xy2uv(vec2)
**Description:**

- Calculate uv values from given xy values.

**Parameter:**

- vec2 : xy position value.

**Returns:**

- vec2 : uv position value.

> **Note:**
> If the layer dimensions are 1920 x 1080, `xy2uv(vec2(192,108));` returns `vec2(0.1,0.1);`