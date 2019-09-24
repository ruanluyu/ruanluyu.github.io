#pw.debug.remain(numToRemain)
---

**Description :**

- Remain messages in debug window. 


**Parameters :**

- pw.debug.remain()
- pw.debug.remain(numToRemain)
- numToRemain

**Return :**
- No return.

**Sample code :**
```lua:pw_debug_remain.lua
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
pw.debug.remain(3)
``` 