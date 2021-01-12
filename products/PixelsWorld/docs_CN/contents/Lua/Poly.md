# 创世神启示录——Poly函数

`poly(obj)`函数将解析obj并绘制物体。

> 由于本篇较晦涩难懂，我们极力推荐您在观看[官方Poly函数视频教程](https://www.bilibili.com/video/BV1vr4y1c7Hm)的同时阅读本章节内容。

## 使用例

> 如果您用过Houdini，`obj`的构造过程类似于填一张Houdini中的SpreadSheet

下面这个例子是构造一个奇特三角形的`obj`

![结果](poly_test1.png)

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


## 支持的图元即名称

以下以`pref={1,2,3,4,5,6}`为例子做说明。

> - `pref`意思是`point reference`，即参考点的序号，图元会按照送入序号的顺序绘制。
> - 分号（`;`）为结束一次图元的绘制。

| 标准名称(type name) | 对应图元 |绘制顺序 | 全称 |
|---|---|---|---|
|points|点|`1;2;3;4;5;6;`|points|
|pointd|平面点|`1;2;3;4;5;6;`|point disc|
|pointb|球点|`1;2;3;4;5;6;`|point ball|
|line|一根线|`123456;`|single line|
|linef|一根平面线|`123456;`|line flat|
|linec|一根立体线|`123456;`|line capsule|
|linel|循环线|`1234561;`|line loop|
|linelf|循环平面线|`1234561;`|line loop flat|
|linelc|循环立体线|`1234561;`|line loop capsule|
|lines|多根线|`12;34;56;`|lines|
|linesf|多根平面线|`12;34;56;`|lines flat|
|linesc|多根立体线|`12;34;56;`|lines capsule|
|triangles|三角面|`123;456;`|triangles|
|triangleb|桥构造三角面|`123;324;345;546;`|triangle bridge|
|triangler|放射构造三角面|`123;134;145;156;`|triangle radial|




## obj的构造

我们这里按照下面的顺序定义obj的细节。

- `obj`是一个表。
- `obj`可含有四个键：`point`,`vertex`,`prim`,`detail`。
- `obj`的四个键对应的值分别为四张表，称作`pointArray`,`vertexArray`,`primArray`,`detailList`。
- `pointArray`必须存在。
- `vertexArray`是可选的。
- `primArray`必须存在。
- `detailList`是可选的。
- 上述带`Array`后缀的表可以装有N个子表，N可以自由定义大小。
- `pointArray`的第k个子表叫做`point[k]`或“第k个点”。
- `vertexArray`的第k个子表叫做`vertex[k]`或“第k个子点”。
- `primArray`的第k个子表叫做`prim[k]`或“第k个图元”。
- `detailList`及上述的点、子点和图元，装着若干不可再细分的单位：键值对。这些键值对的键暂时称为`K`,值称为`V`。
- `K`推荐只含有英文数字和下划线，且不是纯数字。
- `V`有一维、二维、三维、四维、字符串、材质编号和索引组共7种。
- 对于任意浮点数`x,y,z,w`
- `x`或`{x}`称作一维`V`。
- `{x,y}`称作二维`V`。
- `{x,y,z}`称作三维`V`。
- `{x,y,z,w}`称作四维`V`。
- `"Hello! PixelsWorld!"`称作字符串`V`。
- (`K`的末尾四个字符`"_tex"`)且(`V`是整数且对应材质存在)时，称作材质编号`V`。
- 对于整数数列`a1,...,an`,`{a1,a2,a3,...,an}`称作索引组`V`。
- 对于每个点`point[k]`，都必须存在名称为`"p"`的`K`来表示点位置。否则为无效点。
- 对于每个子点`vertex[k]`，都必须存在名称为`"pref"`的`K`和一维`V`表示参照点id。否则为无效子点。
- 对于每个图元`prim[k]`，都必须存在`"type"`的`K`和字符串`V`来表示图元类型，同时必须存在`"vref"`或`"pref"`的`K`和索引组`V`来表示图元的绘制点顺序。

## 覆盖优先级

对于一个同名的`K`，我们定义如下的覆盖优先级：

> 和`Houdini`相同

1. vertex
2. point
3. prim
4. detail

使用例：

下面这个`obj`的`prim`含有颜色信息（红色），所以最终会出来一个纯红色的三角形。

![PrimColor](polyPrimColor.png)

```lua:PrimColor.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
obj={
    point={
        {p={0,0,0}},
        {p={100,0,0}},
        {p={0,100,0}},
    },
    prim={
        {type="triangle",pref={1,2,3},color={1,0,0}},
    },
}
poly(obj)
```

---

而下面这个`obj`的`prim`和`point`都具有`color`，因为`point`的优先级比较高，所以三角形采用了`point`提供的数据，最终出现一个彩色的三角形。

![PointColor](polyPointColor.png)
```lua:PointColor.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
obj={
    point={
        {p={0,0,0},color={0,1,1}},
        {p={100,0,0},color={1,1,0}},
        {p={0,100,0},color={1,0,1}},
    },
    prim={
        {type="triangle",pref={1,2,3},color={1,0,0}},
    },
}
poly(obj)
```

## Vertex的用法

Vertex（子点）可以继承Point（点）的信息。

![Vertex](polyVertexTest.png)

```lua:VertexColor.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
obj={
    point={
        {p={0,0,0}},
        {p={100,0,0}},
        {p={0,100,0}},
        {p={100,100,0}},
    },
    vertex={
        {pref=1,color={1,0,0}},
        {pref=2,color={1,0,0}},
        {pref=3,color={1,0,0}},
        {pref=2,color={0,1,0}},
        {pref=3,color={0,1,0}},
        {pref=4,color={0,1,0}},
    },
    prim={
        {type="triangle",vref={1,2,3,4,5,6}},
    },
}
poly(obj)
```

> - `pref`用来指明当前vertex参考的是哪个point，`pref`全称为`Point reference`。
> - `prim`中的`vref`是`Vertex reference`的全称。
> - 注意：Lua中的表，第一个元素的序号为1不是0。

---

如果不用Vertex，情况就会变成下面这样：

![NoVertexRes](polyNoVertexTest.png)

```lua:NoVertex.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
obj={
    point={
        {p={0,0,0},color={1,0,0}},
        {p={100,0,0},color={1,0,0}},
        {p={0,100,0},color={1,0,0}},
        {p={100,100,0},color={0,1,0}},
    },
    prim={
        {type="triangle",pref={1,2,3,2,3,4}},
    },
}
poly(obj)
```


## 附带shader

您甚至可以在Poly里面使用shader语言。

![FragColorRes](polyVertexFragTest.png)

```lua:FragColor.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
obj={
    point={
        {p={0,0,0},myattribute={1,0}},
        {p={100,0,0},myattribute={0,1}},
        {p={0,100,0},myattribute={0,0}},
        {p={100,100,0},myattribute={1,1}},
    },
    prim={
        {
            type="triangle",
            pref={1,2,3,2,3,4},
            frag=[==[
                #define t ]==] .. tostring(time) .. [==[

                void main(){
                    outColor = vec4(mod(myattribute*10+vec2(t),1),0,1);
                }
            ]==],
        },
    },
}
poly(obj)
```

## 使用UV材质

> - 下面的obj将使用输入层做材质输出到场景中。
> - 当某整数属性值的键名称后缀带有`_tex`时，该属性将被视为材质id. 
> - 使用自定义shader可以同时在一个prim中使用多个材质。

```lua:UVTex.lua
version3()
background(0.95)
move(width/2,height/2)
dim3()
obj={
    point={
        {p={0,0,0},uv={0,0}},
        {p={100,0,0},uv={1,0}},
        {p={0,100,0},uv={0,1}},
        {p={100,100,0},uv={1,1}},
    },
    prim={
        {
            type="triangler",
            pref={1,2,4,3},
            my_tex=INPUT,
        },
    },
}
poly(obj)
```
