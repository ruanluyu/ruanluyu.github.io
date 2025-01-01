# リンクパラメータ
---
外部パラメータを使用することで、アニメーション設定が可能です。
<br>
![パラメータ](parameters.png)

現在、アニメーションに使用できる7種類のパラメータがあります。
- スライダー
- 角度
- ポイント
- 3D ポイント
- チェックボックス
- カラー
- レイヤー

そして、各パラメータセットには10個のコントローラが利用可能です。

**例 :**

```glsl:link_slider.shader
 void main(){
    outColor = vec4(uv,slider[0],1.0);
}
```
 例えば、スライダー0を変更すると、プレビュー画面の色が変わります。
<br>
![uvslider](uvslider.gif)

## 詳細
PixelsWorldでのパラメータの宣言方法は以下の通りです：

```glsl:parameters.shader
uniform float slider[10];
uniform float angle[10];
uniform bool checkbox[10];
uniform vec2 point[10];
uniform vec3 point3d[10];
uniform vec4 color[10];
uniform sampler2D layer[10];
uniform sampler2D inLayer;
```
> 注目
> - **"inLayer"** は入力レイヤーを表します。
> - **sampler2D** はGLSLで提供されている変数タイプで、その変数タイプを理解する必要はありません。レイヤーパラメータについて知りたい場合は、["getColor"](getColor.md)を参照してください。
> - **"uniform"** はグローバル変数を表します。