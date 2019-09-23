#pw.setColor(x,y,A,R,G,B)
---

**Description :**

- Set the pixel data in specific position

**Parameters :**

- pw.setColor(x,y,A,R,G,B)
- x,y : integer
- A,R,G,B : floats in range 0-1 (No clamp in 32 bpc)		

**Return :**
- No return

**Sample code :**
- Here is a sample code that renders a beautiful time-dependent uv color pattern. 
```lua:setColor.lua
for y=0,height do
	for x=0,width do
		pw.setColor(x,y,1,x/width,y/height,math.sin(time*10)/2+.5)
	end
end
```