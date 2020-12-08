#Run GLSL Code
---
- Make sure you are in **GLSL(GPU)** mode; 
<br>
![GLSL Mode](GLSLMode.png)
- Then edit the **World rule**; 
- You will see there is already some code in the showed up panel; 
```glsl:default.shader
void main(){
	outColor = getColor(uv);
}
```
>This code is just send the input pixels to the output. 

- You can change the ``` getColor(uv) ``` to ```vec4(uv,0.0,1.0)``` for geting a beautiful uv color pattern; 
```glsl:uvcolor.shader
void main(){
	outColor = vec4(uv,0.0,1.0);
}
```
- Then, press the **"Ok"** button. 
- If everything is right, you will get something in the scene like this:
<br>
![UV color pattern](UVColor.png)