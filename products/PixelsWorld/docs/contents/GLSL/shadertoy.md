# Template Zone Sahdertoy
---
## Usage
On the Shadertoy mode, you can run codes from [shadertoy.com](https://shadertoy.com). 

![shadertoyMode](shadertoyMode.png)

> **Note** <br/> It doesn't mean all code from the Shadertoy can be seamlessly transferred into PixelsWorld. Some like "VR", "Loop buffer reference" are not supported. 

![loopRef](loopbuffer.png)

##Details

Add **`_PixelsWorld_`** prefix to use variables that exist in GLSL mode. 


> E.g. `slider[0]` on GLSL mode =  `_PixelsWorld_slider[0]` on shadertoy mode. 

Refer to [this page](./predefined.md#shadertoy-mode) to learn more global definitions in the Shadertoy mode. 

It is not recommended to define your own **`_PixelsWorld_`** prefixed variables. 