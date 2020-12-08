# 一番重要な関数たち
---

ここで、いくつか一番使われている関数を列挙し、それらを紹介します。

## 初期値コード


```lua:default_code.lua
version3()
in2out()
move(width/2,height/2)

```

- `version3()` は、一番最初に呼ぶべき関数です。これは`pw3.`テーブルにあるすべての関数をグローバル関数にする役割を果たしています（C++の`using namespace pw3`の如く）。
- function must be called in the first line. It put all functions that in the table `pw3` to the global field. If you don't call it, you need to add a `pw3.` prefix to all the function provided by PixelsWorld. For instance, the following demonstrated function `print()` should be `pw3.print()`. On the contrary, If you call the function `version3()` in the first line, the `pw3.` prefix could be omitted. This function is designed for backward compatibility. We recommend calling `version3()` in the first line any time you use Lua render mode. 
- `in2out()` copys the input image to the output. If you don't need input image but a pure color backgroud instead, call `background(r,g,b,a)`(RGBA range: 0~1). If you want your background to be empty, remove the `in2out()` function. 
- `move(x,y)` moves the Paintbrush along vector `(x,y)`. The default location of Paintbrush is `(0,0)`, hence `move(width/2,height/2)` means move the Paintbrush to the middle of your scene. Remove this function if you don't need this moving. 
