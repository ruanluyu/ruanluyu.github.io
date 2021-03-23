# pw.endShaders()
---

**Description**

- If there are two or more shader code need to be run. Add `beginShaders` and `endShaders` to speed it up. It promises there is not time wasted on swapping buffers. 

**Parameters**

- None

**Return**

- None

**Example**

```lua:endShaders.lua
pw.beginShaders()
pw.glsl("void main(){outColor = vec4(1);}")
pw.glsl("void main(){outColor = getColor(OUTPUT_LAYER_INDEX,uv)*sin(time)/2.+.5;}")
pw.endShaders()
```

**See also**

[pw.beginShaders()](beginShaders.md)
