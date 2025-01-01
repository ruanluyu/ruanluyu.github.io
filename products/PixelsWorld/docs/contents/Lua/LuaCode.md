# The Center of the World: Lua
---

In Chapter 1, we introduced a language called **Lua**

>** Lua is a lightweight, high-level, multi-paradigm programming language, mainly used for embedded applications.* [——Wiki](https://en.wikipedia.org/wiki/Lua_(programming_language))

**Version: [Lua5.3 (Click to view the complete technical documentation in Chinese)](https://cloudwu.github.io/lua53doc/contents.html)**

> Note: From `PixelsWorld v3.2.0`, [`Lua5.4`](https://www.lua.org/manual/5.4/manual.html) is used.

Lua is a language very similar to expressions and Ae scripts, and it is the center of PixelsWorld, connecting all modules. Basically, you just have to remember a few English words for operations, and PixelsWorld will systematically render graphics for you.

All rendering commands in PixelsWorld can be issued through this central hub, Lua. For example, if you want to draw a cube that can interact with Ae's camera, you just need to input:

```lua:DrawCube.lua
version3()
move(width/2,height/2)
dim3()
cube(300)
```

> `dim3()` is a function used for drawing in 3D mode.

If you want to render GLSL code, you only need to input:

```lua:RunGlsl.lua
version3()
glsl([==[
void main(){
    vec3 col = 0.5 + 0.5*cos(time+uv.xyx+vec3(0,2,4));
    outColor = vec4(col,1.0);
}
    ]==])
```

And input the GLSL code in between;

If you want to execute [shadertoy](shadertoy.md) code, you just need to input:

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
And input the code from shadertoy in between.

Here we list the capabilities of Lua:
- Access pixel data
- Write pixel data
- Execute JavaScript
- Execute GLSL
- Access parameter data
- Execute external C language libraries
- Load Lua modules

Additionally, Lua is very similar to JavaScript. Since JavaScript is an easy-to-learn language, you will be able to master it quickly even if you have no programming background.

## PixelsWorld Structure

![PW_Structure](../PW_Structure.png)

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>