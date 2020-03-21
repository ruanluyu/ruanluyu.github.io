#pw.debug.add(message)
---

**Description :**

- Insert a message into the debug window. 
> Note : this is exactly same with [```pw.report()```](report.md)


**Parameters :**

- pw.debug.add()
- pw.debug.add(message)
- message : string

> Note : ```pw.debug.add()``` will do nothing with debug window, while ```pw.debug.add("")``` will add a line break ("\n"). 

**Return :**
- No return.

**Sample code :**
```lua:pw_debug_add.lua
pw.debug.add("Message from time "..time.."\nHello PixelsWorld!\n")
``` 