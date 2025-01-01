# Advanced Settings

This section introduces the advanced options settings available in the effects panel.

## Wrap U/V Sampler

This parameter affects the result of ```getColor()``` when the sampled pixels exceed the image boundaries.

**Test Code (Apply on material using PixelsWorld):**

```glsl:wrap_uv_sampler.shader
void main() {
    outColor = getColor(uv*10);
}
```
---

## Magnify/Minify Sampler

This parameter affects the behavior of ```getColor()``` when the sampler performs interpolated sampling around neighboring pixels.

**Test Code (Apply on material using PixelsWorld):**

```glsl:wrap_uv_sampler.shader
void main() {
    outColor = getColor(uv*0.1);
}
```

> If you want to achieve a similar pixel style effect, set this option to **Nearest pixel**.

## Mipmap

Allows you to specify the color-picking method when the texture is minimized.

```glsl:wrap_uv_sampler.shader
void main() {
    outColor = getColor(uv*10);
}
```