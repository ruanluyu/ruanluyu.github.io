#pw.setColor(x,y,A,R,G,B)
---

**说明：**

- 在指定位置设置像素数据。

**参数：**

- pw.setColor(x,y,A,R,G,B)
- x,y : 整数。
- A,R,G,B : 0~1的浮点数 (在32位下不包含首尾)		

**返回：**

- 无。

**示例：**

- 以下代码会根据时间渲染一个漂亮的uv颜色图案
```lua:setColor.lua
for y=0,height do
	for x=0,width do
		pw.setColor(x,y,1,x/width,y/height,math.sin(time*10)/2+.5)
	end
end
```