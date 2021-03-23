#高级设置
---
本节介绍效果面板中的高级选项设置。

##Wrap U/V sampler
当采样的像素超出图像边界时，此参数会影响 ```getColor()``` 的结果

**测试代码(在素材上应用PixelsWorld): **

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*10);
}
```
---

##Magnify/Minify sampler
当采样器要对周围像素进行插值采样时，此参数会影响 ```getColor()``` 的行为

**测试代码 (在素材上应用PixelsWorld): **

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*0.1);
}
```

> 如果想构建相同的像素样式效果， 请把此选项设置为 **Nearest pixel**（最近像素）