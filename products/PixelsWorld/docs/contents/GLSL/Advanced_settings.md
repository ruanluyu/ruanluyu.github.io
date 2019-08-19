#Advanced settings
---
There are several advanced settings in the effect panel.

##Language

It controls which compiler to be used. 
---
##Reverse U/V
This will change the inner value ```uniform vec2 uv```. But it will not change the orientation of the inLayer or layer parameters. 

If you uncheck the **reverse u** and **reverse v**. The UV coordinate will be placed on the left top cornerr of your layer. 

By default the **reverse v** is checked. Because almost all the shader code is built on the left bottom coordinate. 

To quickly understand this option. You can use the bottom shader code to test:
```glsl:reverse_test.shader
void main(){
	outColor = getColor(uv) + vec4(uv,0,0);
}
```
---

##Wrap U/V sampler
This will affect the result of ```getColor()``` when sampler the pixels which is outside the boundary of image.

**Test code (Apply PixelsWorld to a footage.): **
```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*10);
}
```
---

##Magnify/Minify sampler
This will affect the behavior of ```getColor()``` when sampler want to do the interpolation of surrounding pixels.

**Test code (Apply PixelsWorld to a footage.): **

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*0.1);
}
```

> If you want to built same pixel style effect. Swith this option to **Nearest pixel**