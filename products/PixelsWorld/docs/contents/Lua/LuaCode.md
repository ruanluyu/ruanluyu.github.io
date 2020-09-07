#Lua Code
---

The instructions that we wrote in chapter 1 is called **Lua**

>*Lua is a lightweight, high-level, multi-paradigm programming language designed primarily for embedded use in applications.* [——Wiki](https://en.wikipedia.org/wiki/Lua_(programming_language))

**Version : [Lua5.3](https://www.lua.org/manual/5.3/)**



So Lua plays the roll that manages the communication between Ae and Users. It is quite similar to Ae script and expression language. Basically you can draw highly variant scene by remembering just a little words. For instance, if you want to draw a cube that can interact with Ae camera, just type: 

```lua:DrawCube.lua
version3()
move(width/2,height/2)
dim3()
cube(300)
```

> `dim3()` means draw shapes in 3 **dim**ension. 

If you want to run GLSL code, just type: 

```lua:RunGlsl.lua
version3()
glsl([==[
Your GLSL code here
    ]==])
```

If you want to run code from [shadertoy](shadertoy.md), just type: 

```lua:RunShadertoy.lua
version3()
pw.shadertoy([==[
The shadertoy code here
    ]==])
```

In Lua, you can : 
- Get pixels data
- Write pixels data
- Run JavaScript
- Run GLSL
- Get paramters data
- Run outer C library **(COOL!)**
- Load outer lua module

Because of the advanced features, the users who using Lua render mode should have basic programming abilities and have a primary understanding about Lua language. If you have no idea about Lua, don't warry about it, it is pretty easy to learn. 