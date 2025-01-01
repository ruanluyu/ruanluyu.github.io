# JavaScriptコード
---
**Lua (CPU & GPU)** モードでは、ピクセルワールドで```js```を使用してJavaScriptコードを実行できます。

![LuaMode](LuaMode.png)

```lua:executeJS.lua
version3()
js("alert('Hello PixelsWorld!')");
```
> 注：Aeプログラムの構造上の問題から、ピクセルワールドでjsコード（特にUIコントロールのパラメータ情報を要求するもの）の使用は推奨しません。jsコードを使って簡単なローカル変数間の計算を行うことができます。