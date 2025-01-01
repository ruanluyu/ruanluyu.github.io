# Running Lua Code
---

Switch the language to **Lua (CPU & GPU)**

![LuaMode](LuaMode.png)

Import the code:
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

> - `a..b` concatenates variables `a` and `b` into a string.
> - [`print()`](FuncList.md#print) renders the information on the screen.
> - [`slider()`](LinkParameters.md) retrieves the value of the specified parameter.
> - You can add `;` at the end of each line, although it's not necessary. Lua considers `\n` (newline character) as the end marker of a block of code.

Eventually, you will see the output information displayed at the top left corner of the screen.

<br><br><br><br><br><br><br><br><br><br>
