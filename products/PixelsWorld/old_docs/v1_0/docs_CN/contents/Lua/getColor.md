#pw.getColor(x,y)
---

**说明：**

- 返回指定位置的像素数据。

**参数：**

- pw.getPixel(x,y)
- pw.getPixel(layerId,x,y)
- x,y必须为整数。 
- layerId 必须为整数, -1 代表输入图层, -2 代表输出图层, 0~9 代表图层参数（AE效果面板的图层设置参数） 
		

**返回：**

- Alpha, Red, Green, Blue.返回 0~1的浮点数(不包括)

**示例**

- 以下代码用于计算A、R、G、B通道的平均值。
```lua:getColor.lua
pw.in2out()
local sumA, sumR,sumG,sumB
sumA = 0
sumR = 0
sumG = 0
sumB = 0
local A,R,G,B 
local total = width * height
for y=0,height do
	for x=0,width do
		A,R,G,B = pw.getColor(x,y)
		sumA = sumA + A
		sumR = sumR + R
		sumG = sumG + G
		sumB = sumB + B
	end
end
pw.report("Average alpha value is : " .. (sumA/total) .."\nAverage red value is : " .. (sumR/total).."\nAverage green value is : " .. (sumG/total).."\nAverage blue value is : " .. (sumB/total))
```