#Run Lua code
---

Switch your language to **Lua ( CPU & GPU )**


![LuaMode](LuaMode.png)


And input the code below : 
```lua:hello.lua
version3()
a = 5+6
b = "PixelsWorld"
c = "is cool!"
d = time
e = slider(0)
f = "5 + 6 = " .. a .. "\nMessage : " .. b .. " " .. c .. "\nCurrent time is : " .. d .. " (s)\nValue of slider0 is : " .. e
print(f)
```

> - ` a..b ` means combine variable a and b as string.
> - [`print()`](FuncList.md#print) reports message to your screen. 
> - [`slider()`](LinkParameters.md) fetches the value of a specified parameters.
> - You are allowed to add `;` at the end of each line, but it is not indispensable. Lua regards the `\n`(line break) as the end mark of one section of code. 

A message will show up in the left top corner of your screen. 

<br><br><br><br><br><br><br><br><br><br>