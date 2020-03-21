#Copy input pixels to output
---

##Usage
###pw.in2out()
- Just send the input layer to output. Add this into your lua code if you don't want to modify the pixels data. Otherwise, all input pixels will be dropped. 

```lua:in2out.lua
--Do something
pw.in2out()
--Do something
```