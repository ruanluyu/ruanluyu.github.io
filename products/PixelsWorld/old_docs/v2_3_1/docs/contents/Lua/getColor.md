#pw.getColor(x,y)
---

**Description :**

- Return the pixel data in specific position

**Parameters :**

- pw.getPixel(x,y)
- pw.getPixel(layerId,x,y)
- x,y should be integers. 
- layerId should be an integer, -1 means the input layer, -2 means the output layer, 0~9 means the layer parameter. 
		
**Return :**

- Alpha, Red, Green, Blue. All are floats in range 0~1. (No clamp)

**Sample code :**
- Here is a sample code that calculates the average value of A,R,G,B channels. 
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