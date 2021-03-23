# Template Zone shadertoy
---
## Usage
On shadertoy mode, you can run codes from [shadertoy.com](https://shadertoy.com). 

![shadertoyMode](shadertoyMode.png)

> **Note** <br/> It doesn't mean all code from shadertoy can be support perfectly in PixelsWorld. Some like codes containing VR are not support. 

##Details

Beginning v2.0.0, we use a new algorithm to support code from shadertoy, if you want to use variable that exists in GLSL mode, you need to add the **`_PixelsWorld_`** prefix. 


> E.g. `slider[0]` on GLSL mode =  `_PixelsWorld_slider[0]` on shadertoy mode. 


And we don't recommand define your own **`_PixelsWorld_`** prefixed variables. 