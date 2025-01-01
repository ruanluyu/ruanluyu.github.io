# Graphics Warrior GLSL
---
In this section, we will quickly learn how to run GLSL in the world of pixels.

## What is GLSL?
 
> GLSL stands for OpenGL Shader Language, which is a GPU-based rendering language supported by OpenGL.
> It's mainly used to write pixel rendering rules and utilize the GPU for computation.

## How to learn?

We recommend [The Book of Shaders](https://thebookofshaders.com/), which is available for free online reading.

### Advantages of Graphics Language

If we compare the *Central Processing Unit (CPU)* on the motherboard to the *Graphics Processing Unit (GPU)* on the graphics card, the CPU is like a super sports car, while the GPU is like a large bus.

![Analogy](bus_vs_car.png)

For transporting a small number of people over a certain distance, a super sports car performs extraordinarily well.

However, if you want to perform highly repetitive tasks—such as computing an image—where you can imagine moving hundreds or thousands of people, then choosing a large bus is clearly the wise choice.

The programming languages we usually learn, such as C/C++, Java, and Python, mostly run directly on the CPU.

Whereas languages like GLSL are designed to run on the GPU.

When processing an image, the GPU can deploy many *"workers"* simultaneously to carry out highly repetitive tasks, with the specific work content defined by GLSL.

> For more information on GLSL syntax, it is recommended to visit [shadertoy.com](https://www.shadertoy.com/). Find some interesting and simple effects to explore how they work.

## Details:

Before running GLSL, we predefine many variables and functions. If you are a beginner, you can temporarily ignore this part.

- **PixelsWorld V3.0.0** uses **#version 330 core**.

[Click here](predefined.md) to view additional predefined code.