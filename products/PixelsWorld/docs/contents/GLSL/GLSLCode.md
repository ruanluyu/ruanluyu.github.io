# GPU Berserker GLSL
---

In this section, we will have a quick look at how the GLSL works in PixelsWorld. 

## What is GLSL? 
 
> GLSL is an abbreviation of OpenGL Shader Language, which is supported by OpenGL, run on GPU. 

## How to learn it? 

We recommend [The book of shaders](https://thebookofshaders.com/)

### Advantage of GPU render

If we treat the CPU as a supercar, the GPU should be more like a bus. 

![Metaphor](bus_vs_car.png)

In the case we transport a few people, one or three, a supercar is adequate. (Handle single complicated calculation)

When it comes to thousands of people, a bus could be helpful. (Render thousands of data simultaneously)

Languages like C/C++, Java, Python, etc., are almost designed to run on CPU.

Languages like GLSL are designed for GPU. 

When we want to render a picture. 
GPU distributes your code to many "workers" to repetitively calculate the result for each pixel. 


> If you want to learn more about GLSL, we recommend you to go to [shadertoy.com](https://www.shadertoy.com/), find some interesting arts, and make out why this works. 

## Details

Before the GLSL is sent to OpenGL, PixelsWorld will combine pre-defined and post-defined codes to support features of Ae. If you are a beginner, you can ignore this section for the moment. 


- **PixelsWorld V3.0.0** use **#version 330 core**. 

[Here](predefined.md) are pre-defined and post-defined codes. 

<br><br><br><br><br><br><br>