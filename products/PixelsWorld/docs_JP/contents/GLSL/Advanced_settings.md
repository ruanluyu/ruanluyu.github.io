# 高度な設定
---
このセクションでは、エフェクトパネルの高度なオプション設定について説明します。

## Wrap U/V サンプラー
サンプリングしたピクセルが画像の境界を超えた場合、このパラメータは```getColor()```の結果に影響します。

**テストコード（素材にPixelsWorldを適用）: **

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*10);
}
```
---

## 拡大/縮小サンプラー
サンプラーが周囲のピクセルを補間サンプリングする際に、このパラメータは```getColor()```の動作に影響します。

**テストコード（素材にPixelsWorldを適用）: **

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*0.1);
}
```

> 同じピクセルスタイルの効果を構築したい場合、このオプションを**最近接ピクセル**に設定してください。

## ミップマップ 

縮小時の材質のカラーサンプリング方法を指定することができます。

```glsl:wrap_uv_sampler.shader
void main(){
	outColor = getColor(uv*10);
}
```