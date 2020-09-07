#链接参数
---
通过使用外部参数，可以进行动画设置。
<br>
![Parameters](parameters.png)

当前拥有7种类型参数可用于动画
- Sliders
- Angles
- Points
- 3D Points
- Checkboxes
- Colors
- Layers

且每组参数都有10个控制器可供调配

**示例 :**

```glsl:link_slider.shader
 void main(){
    outColor = vec4(uv,slider[0],1.0);
}
```
 比如改变slider 0，预览界面颜色将会变化。
<br>
![uvslider](uvslider.gif)



##详情
在PixelsWorld参数声明方式如下所示： 

```glsl:parameters.shader
uniform float slider[10];
uniform float angle[10];
uniform bool checkbox[10];
uniform vec2 point[10];
uniform vec3 point3d[10];
uniform vec4 color[10];
uniform sampler2D layer[10];
uniform sampler2D inLayer;
```
> 注意
> -  **"inLayer"** 代表输入层。 
> - **sampler2D** 是一种由 GLSL提供的变量类型，不用理解该变量类型。如果你想了解图层参数，请参考  ["getColor"](getColor.md) 
> - **"uniform"** 代表全局变量。