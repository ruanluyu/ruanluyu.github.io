# エラーCouldn't find main entry point for PixelsWorld.aex (48::72)

PixelsWorldを初めてテスト/使用する際に以下のエラーメッセージが表示される場合、次の項目を確認してください。

![Err Info](entrypointerr.png)

1. Creative Cloudを使用してAeを最新バージョンに更新する必要があります（CC2019の場合は`16.1.3+`、2020の場合は`17.5.1+`を推奨）。
2. Windows10を最新バージョンに更新する必要があります（`Windows 10 20H2`以降を推奨）。
3. 最新のグラフィックカードドライバーを持っている必要があります。
4. グラフィックカードが`OpenGL 3.3`以上のバージョンのプロトコルにハードウェアで対応している必要があります（`OpenGL Extensions Viewer`ツールを使用して確認できます）。
5. `C:\Windows\System32`ディレクトリに`OpenCL.dll`が存在する必要があります。