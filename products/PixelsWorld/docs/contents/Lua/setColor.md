# pw.setColor(x,y,A,R,G,B)
---

**Description:**

- Sets the pixel data at a specified position.

**Parameters:**

- pw.setColor(x,y,A,R,G,B)
- x, y: Integers.
- A, R, G, B: Floating-point numbers in the range 0~1 (in 32-bit excluding endpoints)

**Returns:**

- None.

**Example:**

- The following code will render a beautiful uv color pattern based on time
```lua:setColor.lua
for y=0,height do
	for x=0,width do
		pw.setColor(x,y,1,x/width,y/height,math.sin(time*10)/2+.5)
	end
end
```