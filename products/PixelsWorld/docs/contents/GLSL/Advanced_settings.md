#Advanced settings
---
There are several advanced settings in the effect panel.

##Language 
It controls which compiler to be used. 


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

> If you want to build the same pixel style effect. Swith this option to **Nearest pixel**