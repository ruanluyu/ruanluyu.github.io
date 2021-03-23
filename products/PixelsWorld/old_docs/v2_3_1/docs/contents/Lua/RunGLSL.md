#Run GLSL in Lua
---

##Usage
###pw.glsl(GLSLcode[, useBuffer])
- GLSLcode: string, the source fragment code. If your input code can be run in **GLSL Render Mode**, it can be directly used in here. (Codes from shadertoy.com is not supported here.)
- useBuffer : bool, optional, by default, this is set to false. If this is true, PixelsWorld will generate a temp memory to store your render result. When the GLSL render done, these data in temp memory will override the output layer's pixels data. 
<br/><br/>
Case you should set **useBuffer** to true: 
1. You want to re-read pixels from out layer. (Namely, there is ```getColor(OUTPUT_LAYER_INDEX,uv)``` in your glsl code)
2. You want to make render slow. 
> If you render glsl only one time each frame, you can totally ignore this option. 


Here are some code to describe the useBuffer : 
> Tips:<br/>
> Use `[==[` and `]==]` to enclose the multi-line code.

```lua:useBuffer_on.lua
pw.glsl(
    [==[
        void main(){
            outColor = vec4(uv,0,1);
        }
    ]==]
);

pw.glsl(
    [==[
        void main(){
            vec3 outlayerColor = getColor(OUTPUT_LAYER_INDEX,uv).rgb;
            outColor = vec4(vec3(1)-outlayerColor,1);
        }
    ]==],true
);
```

```lua:useBuffer_off.lua
pw.glsl(
    [==[
        void main(){
            outColor = vec4(uv,0,1);
        }
    ]==]
);

pw.glsl(
    [==[
        void main(){
            vec3 outlayerColor = getColor(OUTPUT_LAYER_INDEX,uv).rgb;
            outColor = vec4(vec3(1)-outlayerColor,1);
        }
    ]==],false
);
```

![useBuffer](useBuffer.gif)


## Speed it up

The efficiency of the approach mentioned above is pretty **LOW**. 

That is because once we run the code, PixelsWorld returns the result to Ae. Then the next shader function need to read it back to perform the second shading. **That's inefficiency**

Unless you want to read pixels to do some CPU calculation between this two shader, the most case is we want the PixelsWorld returns the result in the end, not in every shading. 

Then you need to write it this way: 

```lua
pw.beginShaders()
pw.glsl(First glsl code)
pw.glsl(Second glsl code)
...
pw.glsl(Nth glsl code)
pw.endShaders()
```

We quote shaders by `pw.beginShaders()` and `pw.endShaders()`. Then the PixelsWorld only report result to Ae when `pw.endShaders` is called. 

This is **very efficient**! The algorithm of it is to create a "Game Loop" between `beginShaders` and `endShaders`. 

> Tip: You can only write `pw.beginShaders`, PixelsWorld can add the `pw.endShaders` at the end automatically. 

`pw.shadertoy` and `pw.full_glsl` are also support. 

```lua
pw.beginShaders()
pw.glsl(glsl code)
pw.glsl(glsl code)
pw.shadertoy(shadertoy code)
pw.glsl(glsl code)
pw.full_glsl(full_glsl code)
pw.endShaders()
```

> Note: All shaders between `beginShaders` and `endShaders` can read the result of last shaders. Use `getColor(-2,uv)` or `getColor(OUTPUT_LAYER_INDEX,uv)` or `texture(outLayer,uv)` or (in shadertoy mode) `texture(_PixelsWorld_outLayer,_PixelsWorld_uv)`

### Flow chart

![flow-chart](https://world.milai.tech/images/PixelsWorld/Lua/beginshader_workflow.svg)