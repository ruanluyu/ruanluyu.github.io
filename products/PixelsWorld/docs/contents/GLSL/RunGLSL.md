# Running GLSL Code
---
- GLSL code should be executed in **GLSL(GPU)** mode;
<br>
![GLSL Mode](GLSLMode.png)
- Click "**Edit**" in the "**World rule**" section;
- At this point, some code will be displayed on the panel.
```glsl:default.shader
void main(){
	outColor = getColor(uv);
}
```
>This code will send the input pixel to the output pixel.

- You can change ```getColor(uv)``` to ```vec4(uv,0.0,1.0)``` to create a visually appealing UV color pattern;
```glsl:uvcolor.shader
void main(){
	outColor = vec4(uv,0.0,1.0);
}
```
- Then, simply click **"Ok"**.
- Normally, you should see the following effect:
<br>
![UV color pattern](UVColor.png)