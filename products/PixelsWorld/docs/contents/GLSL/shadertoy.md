#shadertoy.com Code
---
##Usage
In this mode, you can directly use the code from [shadertoy.com](https://shadertoy.com). Switch the Language to **shadertoy.com** if you want to render shadertoy's codes. 
![shadertoyMode](shadertoyMode.png)
> **NOTE** <br/>
> We <span style="color:red">**DO NOT**</span>  promise all code in shadertoy.com will work perfectly in PixelsWorld. (Codes that are not supported almost because there are audio inputs or **VR** renders codes integrated)


##Details
When customer inputted shader code from [shadertoy.com](https://shadertoy.com), PixelsWorld will do the **grammatical analysis** (Translate code from protocol of shadertoy.com to protocol of PixelsWorld) and **change the input code**.  This means the next time you open the edit window may get different text with the code you inputted last time (This do happen when the variable's names **comflicted** with PixelsWorld's inner variables ). 

For example :  If you inputted codes like this
```glsl:InputShadertoy.shader
void mainImage( out vec4 fragColor, in vec2 fragCoord ){
vec2 uv = fragCoord/iResolution.xy;
fragColor = vec4(uv,0,1);
}
```
which would give you a beautiful uv color pattern. 

When you open the editer again, you will get codes like this:
```glsl:LaterShadertoy.shader
void mainImage( out vec4 fragColor, in vec2 fragCoord ){
vec2 pw_user_uv = fragCoord/iResolution.xy;
fragColor = vec4(pw_user_uv,0,1);
}
```
It is not hard to notice that the ```uv``` variable becomes ```pw_user_uv```.

This because the uv variable already exists in PixelsWorld. We add the ```pw_user_``` prefix to abvoid the name confliction. 

Here is a list of variables that will be modified:
- uv
- outColor
- getColor
- uv2xy
- xy2uv
- slider
- angle
- checkbox
- point
- point3d
- color
- layer
- layerResolution
- inLayer
- time
- fps
- width
- height
- origin
- resolution
- reverseUV
- INPUT_LAYER_INDEX
- OUTPUT_LAYER_INDEX