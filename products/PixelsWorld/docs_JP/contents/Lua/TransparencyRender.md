# 透明オブジェレンダー法
---
普通、**透明な**キューブ列をレンダーしようとしたら次の結果を得ます。


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

実際この結果は正しくありません。なぜなら、透明なオブジェなのに、我々の望むようにスケスケのキューブに見えないからです。

正しい結果を得るために、透明な物体をカメラから遠い順でレンダーしなければならない。（すべての物体が透明でない場合はこれを拘りません）。よって、レンダーする前に物体の並び替えが必要です。

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
local x,y,z = global2screen(local2global(0,0,0)) -- Get camera distance
sortarr[i] = {z,getTransformMatrix()} -- {distance, transform status} pairs
end
endGroup()

table.sort(sortarr,function(a,b) -- Sort by z distance
return a[1] > b[1]
end)

for i = 1,10 do
beginGroup(sortarr[i][2]) -- Apply transform status
cube()
endGroup()
end
```