# 在本地写代码

如果您不喜欢像素世界自带的编辑器，您可以在本地创建`txt`文档，并用如下代码导入像素世界中。

> 不要把代码文件放在系统盘(`C:\`盘)里。

```lua:loadTxt.lua
version3()
runFile([[d:\mycode.txt]]) -- Replace to your path
```

> - 这里使用`[[d:\mycode.txt]]`而不是`"d:\mycode.txt"`的原因是，后者的`\`会发生转译。
> - 您可以使用任何后缀名(`*.lua, *.code, *.magic`)，只要文件内容是文本即可。

如果您想把代码放到工程文件旁边，可以用如下代码。

```lua:loadTxt.lua
version3()
runFile( projectFolder .. [[mycode.txt]]) -- Replace to your file name
```

> 注意，使用`projectFolder`的前提是你的工程已保存在本地。

## 事情没完！别忘记刷新代码

![RerenderClick](RerenderLOGO.png)

当你在本地敲完代码保存后，像素世界并不会立刻响应到场景中，您需要按住**Ctrl + Alt**，鼠标点击插件面板上的LOGO图片，像素世界就会去读取您写好的新的代码。

> 这里的LOGO图片会按照一定的概率分布随机轮播。为了照顾有收集喜好的艺术家，我们设计了很多精美的LOGO放在这里。