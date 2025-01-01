# Link Parameters
---
Using external parameters, animations can be set up.
<br>
![Parameters](parameters.png)

There are currently 7 types of parameters available for animations:
- Sliders
- Angles
- Points
- 3D Points
- Checkboxes
- Colors
- Layers

And each group of parameters has 10 controllers for manipulation.

**Example:**

```glsl:link_slider.shader
void main(){
    outColor = vec4(uv, slider[0], 1.0);
}
```
For instance, changing slider 0 will alter the color in the preview window.
<br>
![uvslider](uvslider.gif)

## Details
In PixelsWorld, parameters are declared as follows:

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
> Note
> - **"inLayer"** represents the input layer.
> - **sampler2D** is a variable type provided by GLSL; you don't need to understand this type. If you want to know about layer parameters, please refer to ["getColor"](getColor.md).
> - **"uniform"** denotes a global variable.