#パラメーター　リンク
---


```lua:parameters.lua
slider(id)  -- 戻り値： 1 double
angle(id)  -- 戻り値： 1 double
point(id)  -- 戻り値： 2 double
point3d(id) -- 戻り値： 3 double
checkbox(id) -- 戻り値： 1 boolean
color(id) -- 戻り値： 3 double
layer(id,x,y) -- 戻り値： 4 double
```

二つ以上の戻り値がある場合は、二つ以上の変数で受け取る必要があります。例えば、`point()`関数は次のように戻り値を処理します。

```lua:point.lua
version3()
x,y = point(0) -- Declear two variables x and y
println('x is ' .. x)
println('y is ' .. y)
```

![Result](linkPoint.png)