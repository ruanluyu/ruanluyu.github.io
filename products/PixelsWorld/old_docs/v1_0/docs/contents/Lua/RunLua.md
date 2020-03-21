#Run Lua code
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

> - ``` a..b ``` means combine variable a and b as string.
> - ```pw.debug.clear()``` cleans the message showed up in debug window.
> - [```pw.report()```](report.md) reports message to debug window. 
> - [```pw.ch()```](ch.md) fetches the value of a specified parameters.
> - You are allowed to add ```;``` in the end of each line, but it is not indispensable. Lua regards the ```\n```(line break) as the end mark of one section of code. 

If you open the debug window (by checking the **debug** checkbox), you will get some message like this : 

![LuaHelloRes](LuaHelloRes.png)