#pw.debug.sub(numToSub)
---

**Description :**

- Delete messages in debug window. 


**Parameters :**

- pw.debug.sub()
- pw.debug.sub(numToSub)
- numToSub : int, define the number of lines to be deleted.  

**Return :**
- No return.

**Sample code :**
```lua:pw_debug_sub.lua
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
pw.debug.sub(3)
``` 