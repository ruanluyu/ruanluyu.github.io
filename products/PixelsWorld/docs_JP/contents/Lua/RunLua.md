# Luaコードの実行

---

**Lua (CPU & GPU)** 言語に切り替える

![LuaMode](LuaMode.png)

コードのインポート： 
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

> - ` a..b ` は変数aとbを文字列として結合します。
> - [`print()`](FuncList.md#print) 画面にメッセージをレンダリングします。
> - [`slider()`](LinkParameters.md) 指定されたパラメータの値を取得します。
> - 各行の最後に `;` を追加することができますが、必須ではありません。Luaは `\n`（改行文字）を一行の終わりとして判断します。

最終的に画面の左上に出力情報が表示されます。