


## Shader code? 
Shader is like *The Function of Microsoft Excel*. You write a function, it will handle the form-data for you. 

If we treat the data in the form as input pixels, the calculated form as output pixels, **Codes in PixelsWorld is the function in Microsoft Excel**

## E.g. Make picture brighter

To make a picture brighter, the simplest approach is just to add the R, G, B by a number. If in Excel, we need to do something like this: 

![Calculate the form](ExcelCalculate.png)

Then we have made all pixels data "brighter"! 

Here is what we need to write in PixelsWorld: 

```glsl:bright_describe.shader
outColor=getColor(uv)+vec4(0.2);
```

It means: Get the input pixels (*getColor*) in current location (*uv*), and add the 4D vector RGBA by (0.2,0.2,0.2,0.2) (*+vec4(0.2)*). Finally, send (*=*) the result to the output pixel(*outColor*). 

But if we only write this single line, PixelsWorld cannot work fine. We need to add this line inside a "shell" to make it work. The complete version is this: 

```glsl:bright.shader
void main(){
    outColor=getColor(uv)+vec4(0.2);
}
```
### How to input codes

![How to input codes](OperateTip.png)

### Input picture (Right-click to save)

![Input picture](FlowerRing.png)

([Source artist](https://www.pixiv.net/artworks/75891619))

### Result

![Result](EffectDemo1.png)


### Add more controls! 

Mostly we don't just add 0.2 to the picture. We want it to be more controllable. So we can replace the `0.2` with `slider[0]`. In this way, we can change the value in the Parameters panel to change the brightness of your picture. 

```glsl:bright_control.shader
void main(){
    outColor=getColor(uv)+vec4(slider[0]);
}
```

![brightness](ControlBright.gif)

But you can find that, if the value is negative, the picture will be transparent, we don't want this to happen. Namely, we need to avoid modifying the Alpha channel of the picture. 

```glsl:bright_control.shader
void main(){
    vec4 inColor = getColor(uv);
    inColor.rgb = inColor.rgb + vec3(slider[0]);
    outColor = inColor;
}
```
> It means: Save the input pixel into a temporary variable `inColor`, Add the value of `slider[0]` to the RGB of inColor, then send the inColor to the outColor. 


![Advanced brightness](ControlBright2.gif)

### Add label to the parameter

![Add label to the parameter](ControlBright3.gif)


### Save to preset

Finally, we can save the code as a preset for the next use. Go to the [Preset management](../Editor/SavePresets.md) to learn more details. 


## Congratulations! 

You have already mastered most of PixelsWorld! 

In addition to writing codes by yourself, you can go to the [shadertoy](https://www.shadertoy.com/), find some interesting code, and run it in PixelsWorld. See [this](contents/GLSL/shadertoy.md) to learn how to use code from shadertoy. 





<br>
<br>
<br>
<br>
<br>
<br>
<br>