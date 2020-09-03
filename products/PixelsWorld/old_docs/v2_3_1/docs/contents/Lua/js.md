#pw.js(jsCode)
---

**Description :**

- Run JavaScript code. 

> Note: Since 2015, the render thread has been seperated by Ae, you cannot obtain any Object of Ae, but you can use this to create your own windows. 

**Parameters :**

- pw.js(jsCode). 
- jsCode : string

**Return :**
- Its first return is the resault of js code. 
- Its second return is the error message.  

**Sample code :**
```lua:js.lua
pw.js("alert('Hello PixelsWorld!');")
``` 

