# エラー: Couldn't find main entry point for PixelsWorld.aex (48::72)

次のエラーが出た時、以下の各事項をチェックしてください。

![Err Info](entrypointerr.png)

1. Creative Cloudを通じてAeを最新版に更新すること（CC2019の場合`16.1.3+`、2020の場合`17.5.1+`がお勧めです）
2. Windows10 は最新版であること(`Windows 10 20H2` 以降のバージョンがお勧めです)
3. グラフィックカードドライバーは最新版であること
4. グラフィックカードは`OpenGL 3.3`以降のプロトコルをサポートしていること(`OpenGL Extensions Viewer`ツールを用いて確認可能です) 
5. `OpenCL.dll`は`C:\Windows\System32`というパスに入っていること。

