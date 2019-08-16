#Render GLSL code with PixelsWorld
---
In this chapter, we will have a quick look of how to make PixelsWorld run GLSL code. 

##But what is GLSL?
GLSL is abbreviation of **OpenGL Shader Language**, it is a GPU based render language powered by OpenGL. 
The main idea of GLSL is that you write the rules of **how pixels render themselves**, then the GPU can hire lots of *"worker"* to do the calculation for you.  
> If you want to learn more about the grammar of GLSL, we recommand you having a look at [shadertoy.com](https://www.shadertoy.com/). Find some interesting but simple effects and figure out why this works. 



##Message for veteran : 
> **PixelsWorld V1.0** uses **#version 330 core**. 
 
 Only the **Fragment shader** you need to write in PixelsWorld. 


