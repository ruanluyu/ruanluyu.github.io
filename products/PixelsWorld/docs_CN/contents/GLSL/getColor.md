# getColor
---
此函数有两种版本。 **getColor(vec2)** 与 **getColor(int ,vec2)**
## getColor(vec2)
**说明 : **

 - 在指定位置获取 **输入层**的颜色。

**参数**:
-  vec2：uv位置（各维度0~1）

**返回 : **

- vec4 :  RGBA颜色（各维度0~1）

## getColor(int,vec2)
**说明 : **

 - 获取**特定输入层** 指定位置的像素 

**参数 : **

- int : 图层索引, -1 (或者 AE_INPUT_LAYER) 也就是输入层，数字0-9代表着插件面板对应的图层参数0-9(PW_TEMP_LAYER (图层索引-2)  Lua渲染模式下使用)
- vec2 : uv 坐标

**返回 : **

- vec4 : RGBA颜色

>**注意 : **
>
>- 总之, ```getColor(AE_INPUT_LAYER,uv);``` 与```getColor(uv)```效果一致;
>- ```getColor(n,uv);``` 能返回`layer[n]`的像素信息
