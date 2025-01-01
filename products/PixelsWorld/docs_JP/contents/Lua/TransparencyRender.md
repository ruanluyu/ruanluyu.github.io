# 透明な形状のレンダリング
---
半透明の立方体を一列にレンダリングすると、次のような結果になります。

![TenCubes](TenCubes.png)


```lua:normalCubes.lua
version3()
in2out()

dim3()
fill(1,.5)

move(width/2, height/2)

for i = 1,10 do
    move(20,0,200)
    cube()
end
```

しかし、この結果は正しくありません。透明な立方体の後ろの部分が見えません。

カメラから遠い順にこれらの立方体をレンダリングすることで、正しい重ね合わせを行う必要があります：

![TenCubesSorted](TenCubesSorted.png)

```lua:sortCubes.lua
version3()
in2out()

dim3()
fill(1,.5)

sortarr = {}

beginGroup()
move(width/2, height/2)
for i = 1,10 do
    move(20,0,200)
    local x,y,z = global2screen(local2global(0,0,0)) -- カメラの距離を取得
    sortarr[i] = {z,getTransformMatrix()} -- {距離, 変換状態} のペア
end
endGroup()

table.sort(
    sortarr,
    function(a,b) return a[1] > b[1] end -- z距離でソート
)

for i = 1,10 do
    beginGroup(sortarr[i][2]) -- 変換状態を適用
    cube()
    endGroup()
end

```