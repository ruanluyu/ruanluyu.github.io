#Debug module
---

```pw.debug``` is a box( or module ) that contains tools to display user message into debug window.  This feature is **only provided in Lua** render mode since the GLSL render core does't support string operation. 

> Note that the debug window display messages in a direction that opposite to the regular cmd window. New message is always displayed on the top of the window. 

Here is a list of what pw.debug contains : 
- pc.debug.add(message)
- pc.debug.sub(numToSub)
- pc.debug.remain(numToRemain)
- pc.debug.clear()