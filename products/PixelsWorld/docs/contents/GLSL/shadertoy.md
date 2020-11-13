# Template Zone shadertoy
---
## Usage
On shadertoy mode, you can run codes from [shadertoy.com](https://shadertoy.com). 

![shadertoyMode](shadertoyMode.png)

> **Note** <br/> It doesn't mean all code from shadertoy can be support perfectly in PixelsWorld. Some like "VR", "Loop buffer reference" are not support. 

![loopRef](loopbuffer.png)

##Details

Add **`_PixelsWorld_`** prefix to use variables that exist in GLSL mode. 


> E.g. `slider[0]` on GLSL mode =  `_PixelsWorld_slider[0]` on shadertoy mode. 


It is not recommended to define your own **`_PixelsWorld_`** prefixed variables. 