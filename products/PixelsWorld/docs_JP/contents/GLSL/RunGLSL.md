#GLSLの実装
---
- **GLSL(GPU)** モードになっていることをまず確認しましょう。


![GLSL Mode](GLSLMode.png)

次のコードを入力してください。

```glsl:default.shader
void main(){
	outColor = getColor(uv);
}
```
>このコードはただ入力された画像をそのまま出力するコードです。

- ``` getColor(uv) ``` を ```vec4(uv,0.0,1.0)```　に変えてきれいなUVパターンをレンダーすることができます。

```glsl:uvcolor.shader
void main(){
	outColor = vec4(uv,0.0,1.0);
}
```

![UV color pattern](UVColor.png)