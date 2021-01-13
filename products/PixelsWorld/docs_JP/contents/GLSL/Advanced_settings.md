#　高級設定
---


##　Wrap U/V sampler

テクスチャの縁での色の取り方を指定する設定です。

次のコードを実装してこの設定をいじってみてください。

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*10);
}
```

##　Magnify/Minify sampler

テクスチャを拡大・縮小するときの色の取り方を指定する設定です。

次のコードを実装してこの設定をいじってみてください。

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*0.1);
}
```

## Mipmap 

テクスチャを縮小するときの色の取り方を指定する設定です。

次のコードを実装してこの設定をいじってみてください。

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*10);
}
```