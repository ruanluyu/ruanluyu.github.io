#uv2xy,xy2uv
---
This two functions can translate a vec2 between **UV Coordinate** and **XY Coordinate**.
It just do some multiplication and division for you. 
##uv2xy(vec2)
**Description : **
 - Calculate the xy position for a given uv position. 

**Parameters : **
- vec2 : uv position.

**Return : **
- vec2 : xy position.

> **NOTE : **
>  If your layer size is 1280 x 720. The ```uv2xy(vec2(0.1,0.5));``` will return ```vec2(128.0,360.0);```

##xy2uv(vec2)
**Description : **
 - Calculate the uv position for a given xy position. 

**Parameters : **
- vec2 : xy position.

**Return : **
- vec2 : uv position.

> **NOTE : **
>  If your layer size is 1920 x 1080. The ```xy2uv(vec2(192,108));``` will return ```vec2(0.1,0.1);```
