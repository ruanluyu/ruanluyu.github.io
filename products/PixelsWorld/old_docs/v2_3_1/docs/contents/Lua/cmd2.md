#pw.cmd(cmdCode)
---

**Description :**

- Run CMD code. 

**Parameters :**

- pw.cmd(cmdCode). 
- cmdCode : string

**Return :**
- Its first result is **true** if the command terminated successfully, or **nil** otherwise. 
- The second return value are as follows : 
- **"exit"**: the command terminated normally; the following number is the **exit status** of the command.
- **"signal"**: the command was terminated by a signal; the following number is the **signal** that terminated the command.

**Sample code :**
```lua:cmd.lua
pw.cmd("echo Hello PixelsWorld! & Pause ")
``` 
> NOTE : **NEVER** use commands like ```read``` on Mac OS. It will block the render thread and never render again. If you are blocked, delete the ```read``` command, save your project, close the Ae forcedly, then re-open. 

