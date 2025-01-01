# pw.setColor(x,y,A,R,G,B)
---

**説明：**

- 指定した位置にピクセルデータを設定します。

**パラメータ：**

- pw.setColor(x,y,A,R,G,B)
- x, y : 整数。
- A, R, G, B : 0~1の浮動小数点数 (32ビット時には前後を含まない)

**戻り値：**

- なし。

**例：**

- 次のコードは、時間に基づいて美しいuvカラーパターンをレンダリングします。
```lua:setColor.lua
for y=0,height do
	for x=0,width do
		pw.setColor(x,y,1,x/width,y/height,math.sin(time*10)/2+.5)
	end
end
```