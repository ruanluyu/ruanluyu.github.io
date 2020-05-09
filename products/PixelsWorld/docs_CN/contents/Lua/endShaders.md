# pw.endShaders()
---

**说明：**

- 当你有两个或以上的shader代码需要渲染，你可以考虑在前后加上`beginShaders`和`endShaders`来加速。这让两套或多套代码之间的“渲染结果传递”几乎不消耗任何时间。


**参数：**

- 无

**返回：**

- 无

**示例**

```lua:endShaders.lua
pw.beginShaders()
pw.glsl("void main(){outColor = vec4(1);}")
pw.glsl("void main(){outColor = getColor(OUTPUT_LAYER_INDEX,uv)*sin(time)/2.+.5;}")
pw.endShaders()
```

**也请参考**

[pw.beginShaders()](beginShaders.md)
