#Run Lua
---

Switch your luange to **Lua ( CPU & GPU )**


![LuaMode](LuaMode.png)


And input the code below : 
```lua:hello.lua
pw.debug.clear()
a = 5+6
b = "PixelsWorld"
c = "is cool!"
d = time
e = pw.ch("slider",0)
f = "5 + 6 = " .. a .. "\nMessage : " .. b .. " " .. c .. "\nCurrent time is : " .. d .. " (s)\nValue of slider0 is : " .. e
pw.report(f)
```
If you open the debug window (by checking the **debug** checkbox), you will get some message like this : 

![LuaHelloRes](LuaHelloRes.png)