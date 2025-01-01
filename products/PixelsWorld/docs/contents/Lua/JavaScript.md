# JavaScript Code
---
In **Lua (CPU & GPU)** mode, the pixel world can execute JavaScript code using ```js```.

![LuaMode](LuaMode.png)

```lua:executeJS.lua
version3()
js("alert('Hello PixelsWorld!')");
```
> Note: Due to the structure of the Ae program, we do not recommend using js code in the pixel world (especially for retrieving UI control parameter information). You can use js code for simple computations between local variables.