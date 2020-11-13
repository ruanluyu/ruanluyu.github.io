# テンプレート聖域shadertoy
---
## 使い方

shadertoyモードでは、[shadertoy.com](https://shadertoy.com)でのコードを直接PixelsWorldに実装することができます。

![shadertoyMode](shadertoyMode.png)

> **注意：** すべてのshadertoyのコードがサポートされているというわけではないです。VRの使ったコードやループの入ったBufferを使ったコードはサポートされていません。

![loopRef](loopbuffer.png)

## 詳細

PixelsWorldの変数をこのモードで使いたいならば、**`_PixelsWorld_`**を変数名の前につけてください。


> 例えば、GLSLモードの`slider[0]`　は　`_PixelsWorld_slider[0]`　になります。


**`_PixelsWorld_`**の付いた変数名の宣言はお勧めしません。