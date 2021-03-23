#输入层像素复制到输出层
---

##用法
###pw.in2out()

- 会把输入层发送到输出层，如果不想修改像素数据，请将其添加到lua代码中。 否则，所有输入的像素将被丢弃。

```lua:in2out.lua
--Do something
pw.in2out()
--Do something
```