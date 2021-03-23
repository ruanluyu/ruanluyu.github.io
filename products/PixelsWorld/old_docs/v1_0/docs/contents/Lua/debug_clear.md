#pw.debug.clear()
---

**Description :**

- Clear messages in debug window. 


**Parameters :**

- pw.debug.clear()

**Return :**
- No return.

**Sample code :**

```lua:pw_debug_clear1.lua
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
pw.debug.clear()
``` 
> - In sample code **pw_debug_clear1.lua**, all message will be deleted, so as a result, nothing remains. 
> - If you want to clear the old debug message before running codes, you can write things like this : 
```lua:pw_debug_clear2.lua
pw.debug.clear()
for i = 0,10 do
	pw.debug.add("This is the message #"..i)
end
``` 