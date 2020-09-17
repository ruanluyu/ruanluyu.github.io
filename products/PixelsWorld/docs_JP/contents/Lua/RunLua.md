# Luaの実装
---

まず、**Lua ( CPU & GPU )**　モードに切り替えてください。


![LuaMode](LuaMode.png)

次のコードをエディターに入力してください。

```lua:hello.lua
version3()
a = 5+6
b = "PixelsWorld"
c = "is cool!"
d = time
e = slider(0)
f = "5 + 6 = " .. a .. "\nMessage : " .. b .. " " .. c .. "\nCurrent time is : " .. d .. " (s)\nValue of slider0 is : " .. e
print(f)
```

> - ` a..b ` は文字列`a`と`b`を連結する操作です。
> - [`print()`](FuncList.md#print)：文字列を出力する関数
> - [`slider()`](LinkParameters.md)：スライダーの値を読み取る関数
> - Lua言語では`;`を行の最後につけることが可能ですが、必須ではありません。

結果として、画面の左上に文字が出力されます。