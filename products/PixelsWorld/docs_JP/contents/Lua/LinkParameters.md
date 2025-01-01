# リンクパラメータ
---

以下の関数を使用して、プラグインパネルのパラメータを呼び出します。

```lua:parameters.lua
slider(id)  -- 1つのdoubleを返す
angle(id)  -- 1つのdoubleを返す
point(id)  -- 2つのdoubleを返す
point3d(id) -- 3つのdoubleを返す
checkbox(id) -- 1つのbooleanを返す
color(id) -- 3つのdoubleを返す
layer(id,x,y) -- 4つのdoubleを返す
```

複数の値を返す場合、複数の変数を宣言して受ける必要があります。例えば、`point()`関数です。

```lua:point.lua
version3()
x,y = point(0)
println('x is ' .. x)
println('y is ' .. y)
```

![実行結果](linkPoint.png)