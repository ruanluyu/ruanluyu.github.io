#getColor
---
此函数有两种版本。 **getColor(vec2)** 与 **getColor(int ,vec2)**
##getColor(vec2)
**说明 : **

 - 在指定位置获取 **输入层**的颜色。

**参数**:
-  vec2：uv位置（各维度0~1）

**返回 : **

- vec4 :  RGBA颜色（各维度0~1）

>**注意 : **
> 我们强烈建议使用 ```getColor(uv);``` 来获取像素，若使用 ```texture2d``` 不能确保返回正确的像素值

##getColor(int,vec2)
**说明 : **

 - 获取**特定输入层** 指定位置的像素 

**参数 : **

- int : 图层索引, -1 (或者 INPUT_LAYER_INDEX) 也就是输入层，数字0-9代表着插件面板对应的图层参数0-9(OUTPUT_LAYER_INDEX (图层索引-2)  Lua渲染模式下使用)
- vec2 : uv 坐标

**返回 : **

- vec4 : RGBA颜色

>**注意 : **
>
>- 总之, ```getColor(-1,uv);``` 与```getColor(uv)```效果一致;
>- ```getColor(n,uv);``` 能返回 layer[n]的像素信息
