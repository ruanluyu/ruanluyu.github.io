#Debug 模块
---

```pw.debug``` 为一个工具箱( 或模块 ) ，可以将用户信息在调试窗口显示。本函数仅在**Lua模式**下生效，因为GLSL渲染核心不支持字符串操作。

> 注意： 调试窗口显示信息与常规CMD窗口信息对立，新信息始终在窗口顶部显示。

以下为pw.debug包含的内容：
- pc.debug.add(message)
- pc.debug.sub(numToSub)
- pc.debug.remain(numToRemain)
- pc.debug.clear()