#Lua Code
---

The instructions that we wrote in chapter 1 is called **Lua**

>*Lua is a lightweight, high-level, multi-paradigm programming language designed primarily for embedded use in applications.* [——Wiki](https://en.wikipedia.org/wiki/Lua_(programming_language))

**Version : [Lua5.3](https://www.lua.org/manual/5.3/)**

> Note: Beginning `PixelsWorld v3.2.0`, using [`Lua5.4`](https://www.lua.org/manual/5.4/manual.html)

So Lua plays the role that manages the communication between Ae and Users. It is quite similar to Ae script and expression language. Basically, you can draw highly variant scenes by remembering just a few words. For instance, if you want to draw a cube that can interact with Ae camera, just type: 

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
void main(){
    vec3 col = 0.5 + 0.5*cos(time+uv.xyx+vec3(0,2,4));
    outColor = vec4(col,1.0);
}
    ]==])
```

If you want to run code from [shadertoy](shadertoy.md), just type: 

```lua:RunShadertoy.lua
version3()
shadertoy([==[
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    fragColor = vec4(col,1.0);
}
    ]==])
```

In Lua, you can : 
- Get pixels data
- Write pixels data
- Run JavaScript
- Run GLSL
- Get parameters data
- Run outer C library **(COOL!)**
- Load outer lua module

Because of the advanced features, the users who using Lua render mode should have basic programming abilities and have a primary understanding of the Lua language. If you have no idea about Lua, don't worry about it, it is pretty easy to learn. 


## PixelsWorld structure

![PW_Structure](../PW_Structure.png)


