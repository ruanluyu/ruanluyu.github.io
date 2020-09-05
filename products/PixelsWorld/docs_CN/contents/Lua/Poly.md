# 创世神启示录——Poly函数

`poly(obj)`函数将解析obj并绘制物体。



## obj的构造

> 如果您用过Houdini，`obj`的构造过程类似于填一张Houdini中的SpreadSheet

下面这个构造是绘制一个奇特三角形的obj

```lua:PolyTest1.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
dotRadius(5)
obj={
    point={
        {p={0,0,0},color={0,1,1}},
        {p={100,0,0},color={1,1,0}},
        {p={0,100,0},color={1,0,1}},
        {p={100,100,0},color={1,0,0}},
    },
    prim={
        {type="triangle",pref={1,2,3}},
        {type="line",pref={2,3,3,4,4,2}},
        {type="point",pref={2,4}},
    }
}
poly(obj)
```
![结果](poly_test1.png)


我们这里按照下面的顺序定义obj的细节。

- `obj`是一个表。
- `obj`可含有四个键：`point`,`vertex`,`prim`,`detail`。
- `obj`的四个键对应的值分别为四张表，暂时称作。`pointArray`,`vertexArray`,`primArray`,`detailList`。
- `pointArray`必须存在。
- `vertexArray`是可选的。
- `primArray`必须存在。
- `detailList`是可选的。
- 上述带`Array`后缀的表可以装有N个子表，N可以自由定义大小。
- `pointArray`的第k个子表暂时叫做`point[k]`或“第k个点”。
- `vertexArray`的第k个子表暂时叫做`vertex[k]`或“第k个子点”。
- `primArray`的第k个子表暂时叫做`prim[k]`或“第k个图元”。
- `detailList`和上述三种子表，里面装着若干不可再细分的单位：键值对。这些键值对的键暂时称为`K`,值暂时称为`V`。
- `K`推荐只含有英文数字和下划线，且不是纯数字。
- `V`有一维、二维、三维、四维、字符串、材质编号和索引组共7种。
- 对于任意浮点数`x,y,z,w`
- `x`或`{x}`是一个一维`V`。
- `{x,y}`是一个二维`V`。
- `{x,y,z}`是一个三维`V`。
- `{x,y,z,w}`是一个四维`V`。
- `"Hello! PixelsWorld!"`是一个字符串`V`。
- 当`K`的末尾四个字符`"_tex"`或`K`等于`"texture"`时，且当`V`是整数且对应材质存在时，这个`V`是一个材质编号。
- 对于整数数列`a1,...,an`,`{a1,a2,a3,...,an}`是索引组`V`。
- 对于每个点`point[k]`，都必须存在名称为`"p"`的`K`来表示点位置。否则为无效点。
- 对于每个子点`vertex[k]`，都必须存在名称为`"pref"`的`K`和一维`V`表示参照点id。否则为无效子点。
- 对于每个图元`prim[k]`，都必须存在`"type"`的`K`和字符串`V`来表示图元类型、必须存在`"vref"`或`"pref"`的`K`和索引组`V`来表示图元。

