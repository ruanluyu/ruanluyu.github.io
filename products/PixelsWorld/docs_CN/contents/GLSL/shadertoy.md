# 模板圣域shadertoy
---
##用法
在此模式下，你可以直接使用来自 [shadertoy.com](https://shadertoy.com)的代码。

![shadertoyMode](shadertoyMode.png)

> **注意** <br/>并非所有来自 shadertoy.com的代码均可在PixelsWorld下完美运行 (比如带有音频输入、需要VR支持和含有循环Buffer引用的代码)

![loopRef](loopbuffer.png)

##细节
如果您想在shadertoy模式下自有调用参数面板，请把所有GLSL模式下的变量加上**`_PixelsWorld_`**前缀即可使用。


> 比如在GLSL模式下的`slider[0]`将变成`_PixelsWorld_slider[0]`

参考[这里](./predefined.md#shadertoy-mode)来了解所有全局变量的定义。

当然在shadertoy模式下我们不推荐您自己定义带有**`_PixelsWorld_`**前缀的变量。