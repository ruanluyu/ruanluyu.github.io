# 全局变量

## 全局常量

PixelsWorld提供以下几个全局常量供用户使用：


```lua:const.lua
PI  -- 圆周率 pi
TPI -- 二倍圆周率 two pi
HPI -- 圆周率一半 half pi
QPI -- 圆周率四分之一 quarter pi
E   -- 自然数 e
PHI -- 黄金分割数 phi
R2  -- 根号2 root 2
R3  -- 根号3 root 3
R5  -- 根号5 root 5
R7  -- 根号7 root 7
INPUT -- 输入材质编号 -1
TEMP -- 缓存材质编号 -2
OUTPUT -- 输出材质编号 -3
PARAM0 -- 第0号图层材质 0
PARAM1 -- 第1号图层材质 1
PARAM2 -- 第2号图层材质 2
PARAM3 -- 第3号图层材质 3
PARAM4 -- 第4号图层材质 4
PARAM5 -- 第5号图层材质 5
PARAM6 -- 第6号图层材质 6
PARAM7 -- 第7号图层材质 7
PARAM8 -- 第8号图层材质 8
PARAM9 -- 第9号图层材质 9
platform -- 平台：Windows 0 目前不支持其它平台
host -- 宿主程序：Ae 0，目前不支持其它宿主
```

## 全局变量

PixelsWorld提供以下几个Ae中获取的变量供用户使用：

```lua:globals.lua
depth -- 颜色深度，8，16，32
width -- 合成宽度
height -- 合成高度
time -- 当前时间(s)
duration -- 所在图层持续时间(s)
inpoint -- 所在图层入点时间(s)
compTime -- 合成时间
pluginFolder -- 插件所在目录(utf8)
projectName -- 工程名(utf8)
projectPath -- 工程路径(utf8)
projectFolder -- 工程所在文件夹的路径(utf8)
ds_width -- 降采样后合成宽度
ds_height -- 降采样后合成高度
```

## 打印全局变量

在Lua模式运行下面的代码来打印全局变量（包括全局函数）


```lua:globals.lua
version3()
in2out()
for k, v in pairs(_G) do
    print(k)
    print(" " .. type(v) , .5,.5,.5)
    print(" ".. tostring(_G[k]),0,1,1)
    println("")
end
```