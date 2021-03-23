# GPU Berserker GLSL
---

In this section, we will have a quick look at how the GLSL works in PixelsWorld. 

## What is GLSL? 
 
> GLSL is an abbreviation of OpenGL Shader Language, which is supported by OpenGL, run on GPU. 

### In short
GLSL is what we used in [section one](../../README.md), it can run on GPU. 

### Advantage of GPU render

If we treat CPU as a supercar, the GPU should be more like a bus. 

![Metaphor](bus_vs_car.png)

In the case we transport little people, like one or three, the supercar would be nice. (Handle single complicated calculation)

But when there are thousands of people need to be transported, it seems that the bus should be the right option. (Render thousands of data symultaneously)

The language we are learning, like C/C++, Java, Python, almost are running on CPU.

Languages like GLSL, is designed for GPU. 

When we are about to render a picture. GPU can distribute one repetitive task to a number of "workers". 


> If you want to learn more about GLSL, we recommand you to go to [shadertoy.com](https://www.shadertoy.com/), find some interesting arts and make out why this works. 

## Details

Before the GLSL is sent to OpenGL, PixelsWorld will combine pre-defined and post-defined codes to support features of Ae. If you are beginner, you can ignore this section for the moment. 


- **PixelsWorld V2.0** use **#version 330 core**. 

[Here](predefined.md) are pre-defined and post-defined codes. 

<br><br><br><br><br><br><br>