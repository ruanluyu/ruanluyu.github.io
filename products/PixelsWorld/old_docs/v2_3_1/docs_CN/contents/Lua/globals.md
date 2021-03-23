# 全局变量

在Lua模式运行下面的代码来打印全局变量

```lua:globals.md
pw.in2out()
for k, v in pairs(_G) do
    pw.print(k)
    pw.print(" " .. type(v) , 1,.5,.5,.5)
    pw.print(" ".. tostring(_G[k]),1,0,1,1)
    pw.println("")
end
```