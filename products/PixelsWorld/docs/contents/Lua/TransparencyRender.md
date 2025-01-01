# Rendering Transparent Shapes

---

When rendering a series of semi-transparent cubes, here's the result you might typically get:

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

However, this result is incorrect as we cannot see the parts of the transparent cubes behind.

To achieve the correct blending of colors, we need to render these cubes from the farthest to the nearest relative to the camera:

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

table.sort(
    sortarr,
    function(a,b) return a[1] > b[1] end -- Sort by z distance
)

for i = 1,10 do
    beginGroup(sortarr[i][2]) -- Apply transform status
    cube()
    endGroup()
end

```