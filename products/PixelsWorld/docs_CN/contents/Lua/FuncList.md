# 函数列表
--- 

以下是定义在PixelsWorld中Lua模式的所有函数。

**必须声明函数**

[version3](#version3)

**获取参数函数**

[slider](LinkParameters.md),
[angle](LinkParameters.md),
[point](LinkParameters.md),
[point3d](LinkParameters.md),
[checkbox](LinkParameters.md),
[color](LinkParameters.md),
[layer](LinkParameters.md)

**输出信息函数**

[print](#print),
[println](#println),
[alert](#alert),

**变换函数**

[move](#move),
[scale](#scale),
[rotate](#rotate),
[rotateX](#rotatex),
[rotateY](#rotatey),
[rotateZ](#rotatez),
[twirl](#twirl)

[beginGroup](#begingroup),
[endGroup](#endgroup),
[beginGlobal](#beginglobal),
[endGlobal](#endglobal)  

**绘制函数**

> 图元

[tri](#tri),
[quad](#quad),
[rect](#rect),
[circle](#circle),
[ellipse](#ellipse),
[line](#line)

[cube](#cube),
[tet](#tet),
[cone](#cone),
[ball](#ball),
[tube](#tube)

[image](#image),
[line](#line),
[par](#par),
[coord](#coord),
[grid](#grid)

[poly](#poly),
[setPoly](#setpoly)

[background](#background),
[in2out](#in2out) 

> 绘制属性控制

[dim2](#dim2),
[dim3](#dim3)

[perspective](#perspective),
[noPerspective](#noperspective)

[fill](#fill),
[noFill](#nofill),
[stroke](#stroke),
[noStroke](#nostroke),
[dot](#dot),
[noDot](#nodot)

[wireframe](#wireframe),
[noWireframe](#nowireframe)

[blendAlpha](#blendalpha),
[noBlendAlpha](#noblendalpha)

[back](#back),
[noBack](#noback)

[pure](#pure),
[phong](#phong),
[anime](#anime)

[color](#color),
[depth](#depth),
[normal](#normal)

[setDepth](#setdepth)

> 灯光

[ambientLight](#ambientlight),
[pointLight](#pointlight),
[parallelLight](#parallellight)

[clearLight](#clearlight),
[getLight](#getlight)  

> 摄像机

[aeCamera](#aecamera),
[lookAt](#lookat),
[viewSpace](#viewspace)  

> 描边细节

[strokeWidth](#strokewidth),
[strokeDivision](#strokedivision),
[strokeGlobal](#strokeglobal),
[strokeLocal](#strokelocal)  

> 点渲染细节

[dotRadius](#dotradius),
[dotDivision](#dotdivision),
[dotGlobal](#dotglobal),
[dotLocal](#dotlocal) 

> 输出细节

[smooth](#smooth),
[noSmooth](#nosmooth) 

**工具**

[r2d](#r2d),
[d2r](#d2r)

[utf8ToLocal](#utf8tolocal),
[localToUtf8](#localtoutf8)

[getGLInfo](#getglinfo),
[getDrawRecord](#getdrawrecord),
[getStatus](#getstatus)

[getAudio](#getaudio)  

**读写像素函数**

[getColor](#getcolor),
[setColor](#setcolor),
[getSize](#getsize),


**执行代码函数**

[shadertoy](#shadertoy),
[glsl](#glsl),
[cmd](#cmd),
[lua](#lua),
[runFile](#runfile),
[txt](#txt)  

---
<br><br><br><br><br>
# 详细介绍

## version3

`version3()` 函数是Lua模式必须在第一行声明的函数。它的作用是把`pw3`这个表下的所有函数放到全局域中，如果没有这一行，您需要把所有PixelsWorld提供的函数前面加入`pw3.`前缀，比如之后会介绍的`println()`函数则需要写成`pw3.println()`。相反，如果您在第一行调用了`version3()`函数，则不需要写`pw3.`前缀。这是为了让您的代码能向后兼容而设计的函数。我们推荐（Lua渲染模式下的）任何情况下都在第一行加入`version3()`的调用。

```lua:version3.lua
version3()
println("Hello PixelsWorld! ")
```

```lua:without_version3.lua
pw3.println("Hello PixelsWorld! ")
```

## print

`print(str)`,`print(str,r,g,b,a)`是在屏幕左上角输出信息的函数。

```lua:print.lua
version3()
print("Hello PixelsWorld! ")
str = "Hello, I am colorful PixelsWorld! "
for i=1,#str do
local c = str:sub(i,i)
local phase = math.sin(i/#str*TPI + time*10) / 2 + .5
print(c,phase,1-phase,1,1)
end
```

## println

`println(str)`,`println(str,r,g,b,a)`是在屏幕左上角输出信息的函数。并在每次输出信息后换行。

```lua:println.lua
version3()
println("Hello PixelsWorld! ")
str = "Hello, I am colorful PixelsWorld! "
for i=1,#str do
local c = str:sub(i,i)
local phase = math.sin(i/#str*TPI + time*10) / 2 + .5
-- println(c,phase,1-phase,1,1)
print(c,phase,1-phase,1,1)
end
```

## alert

`alert(str)`是在屏幕左上角输出**警示信息**的函数。它目前等价于`println(str,1,1,0,1)`

```lua:alert.lua
version3()
alert("Warning: Write your message here! ")
```

## move

`move(x,y)`,`move(x,y,z)`是平移画笔坐标的函数。

> 所有变换都是以当前画笔坐标为基准进行的。

例如下面这个例子：
```lua:move.md
version3()
coord() -- 显示变换前的画笔位置
move(100,0)
coord() -- 显示第1次变换后的画笔位置
move(0,100)
coord() -- 显示第2次变换后的画笔位置
```
最终画笔会在`(100,100,0)`位置处。

## scale

`scale(ratio)`,`scale(x,y)`,`scale(x,y,z)`是缩放画笔坐标的函数。
> 所有变换都是以当前画笔坐标为基准进行的。


## rotate
## rotateX
## rotateY
## rotateZ

`rotate(theta)`是把画笔坐标旋转`theta`弧度的函数，`rotateX(theta)`则是把画笔坐标沿着其X轴旋转的函数，`rotate(theta)`本质等价于`rotateZ(theta)`。
> - 所有变换都是以当前画笔坐标为基准进行的。
> - 如果您不熟悉弧度，可以用函数`d2r(degree)`来把角度转成弧度。例如：`rotate(d2r(90))`则是旋转九十度。

## twirl
`twirl(x,y,z,theta)`是沿着`(x,y,z)`轴旋转`theta`弧度画笔的函数。比如，上面的`rotateX(theta)`则等价于这里的`twirl(1,0,0,theta)`。
> - 所有变换都是以当前画笔坐标为基准进行的。
> - `twirl`是对四元数旋转的一种矩阵实现。


## beginGroup
## endGroup
`beginGroup()`,`endGroup()`是创建父子级关系的函数。`beginGroup()`到`endGroup()`之间的变换(`move,scale,rotate,twirl`)在`endGroup()`之后会被撤销掉。
> 它等价于Processing中的`pushMatrix()`和`popMatrix()`

例如：下面两块代码是等价的
```lua:group.lua
version3()
for i = 1,10 do
beginGroup()
move(i*100,i*100)
rotate(d2r(45*i))
rect(50)
endGroup()
end
```

```lua:without_group.lua
version3()
for i = 1,10 do
move(i*100,i*100)
rotate(d2r(45*i))
rect(50)
rotate(d2r(-45*i))
move(-i*100,-i*100)
end
```

## beginGlobal
## endGlobal
夹在`beginGlobal`,`endGlobal`之间的绘图函数
将暂时以全局坐标系绘制

```lua:beginGlobal.lua
version3()
move(100,100)
fill(0,1,0) -- green
rect(50) -- Dran on (100,100,0)
beginGlobal()
fill(1,0,0) -- red
rect(50) -- Draw on (0,0,0)
endGlobal()
move(100,100)
fill(0,0,1) -- blue
rect(50) -- Draw on (200,200,0)
```

## tri
1. `tri(radius)`以半径为`radius`的圆做一个内接正三角形，并指向画笔坐标y轴正方向。
1. `tri()`等价于`tri(100)`
1. `tri(w,h)`以底边为`w`高为`h`做一个等边三角形。
1. `tri(p1x,p1y,p2x,p2y,p3x,p3y)`以`p1,p2,p3`2个二维点为顶点做三角形
1. `tri(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z)`以`p1,p2,p3`3个三维点为顶点做三角形

> - 如果想要观察三维三角形，请在`version3()`函数后加入`dim3()`，并在Ae图层中建立摄像机观测。
> - 前3种方式构造的三角形的法线默认为画笔坐标z轴负方向，后2种方式构造的三角形则以`cross(p1-p2,p3-p2)`定几何法线。

```lua:tri1.lua
version3()
move(width/2,height/2)
tri(100)
```
```lua:tri5.lua
version3()
dim3()
move(width/2,height/2)
tri(0,0,100,50,0,0,0,50,0)
```

## quad
1. `quad(p1x,p1y,p2x,p2y,p3x,p3y,p4x,p4y)`
1. `quad(p1x,p1y,p1z,p2x,p2y,p2z,p3x,p3y,p3z,p4x,p4y,p4z)`

> - 以`p1,p2,p3`的顺序绘制第一个三角形，以`p1,p3,p4`的顺序绘制第二个三角形。


## rect

1. `rect(size)`绘制size尺寸的正方形
2. `rect()`等价于`rect(100)`
3. `rect(width,height)`绘制长`width`高`height`的长方形

> - 长方形将以画笔坐标中心为对角线交点生成。

## circle

1. `circle(size)`绘制一个半径为`size`的圆
2. `circle()`等价于`circle(100)`
3. `circle(size, div)`绘制一个半径为`size`，分段数为`div`的圆。

> 默认分段为128

## ellipse
1. `ellipse(width,height)`绘制一个长`width`宽`height`的椭圆
2. `ellipse()`等价于`ellipse(100,100)`
3. `ellipse(width,height,div)`绘制一个长`width`宽`height`分段`div`的椭圆

> 默认分段为128

## line
1. `line(p1x,p1y,p2x,p2y)`绘制一条线段
1. `line(p1x,p1y,p1z,p2x,p2y,p2z)`绘制一条三维线段
1. `line()`等价于`line(0,0,0,100,100,100)`

