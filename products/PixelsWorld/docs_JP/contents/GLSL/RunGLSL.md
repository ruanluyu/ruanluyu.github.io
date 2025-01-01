# GLSLコードの実行
---
- GLSLコードは**GLSL(GPU)**モードで実行してください。
<br>
![GLSLモード](GLSLMode.png)
- "**World rule**"で"**Edit**"をクリックします。
- この時、一部のコードがパネルに表示されます。
```glsl:default.shader
void main(){
	outColor = getColor(uv);
}
```
> このコードは入力ピクセルを出力ピクセルに送信します。

- ```getColor(uv)```を```vec4(uv,0.0,1.0)```に変更することで、きれいなuvカラーパターンを得ることができます。
```glsl:uvcolor.shader
void main(){
	outColor = vec4(uv,0.0,1.0);
}
```
- 次に、**"Ok"**をクリックすれば完了です。
- 通常、次のような結果が得られるはずです：
<br>
![UVカラーパターン](UVColor.png)