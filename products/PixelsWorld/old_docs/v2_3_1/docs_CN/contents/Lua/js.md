#pw.js(jsCode)
---

**说明：**

- 运行JavaScript代码。

> 注意：由于渲染线程被Ae分离，这里运行的js代码将无法获得任何关于Ae控件的信息。但你可以做一个自己的窗口、或者利用它来做一些简单的js计算。

**参数：**

- pw.js(jsCode). 
- jsCode : 字符串

**返回：**

- 首先返回 js代码结果。
- 然后返回错误信息。  

**示例：**
```lua:js.lua
pw.js("alert('Hello PixelsWorld!');")
```

