#パラメーター　リンク
---


`Parameters`の中のパラメーターを生かしてアニメを作ることができます。

![Parameters](parameters.png)

上の図に示すように、七種のパラメーターがあります。

- Sliders
- Angles
- Points
- 3D Points
- Checkboxes
- Colors
- Layers

各種にまた10個のパラメーターが入っています。

**使用例 :**

```glsl:link_slider.shader
 void main(){
    outColor = vec4(uv,slider[0],1.0);
}
```
 
![uvslider](uvslider.gif)
 


## 詳細

パラメーター変数は次のように定義されています。

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
> **注意: **
> - **"inLayer"** は入力テクスチャです。
> - **sampler2D**　の使い方について、 ["getColor"](getColor.md)セクションをご覧ください。
> - **"uniform"** はグローバル変数であることを宣言する修飾子です。