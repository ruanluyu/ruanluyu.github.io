# ローカルコードの読み取り

PixelsWorldは、`txt`形式のファイルを読み取れる為、ローカルでユーザーが好きなエディターでコードを書くことが可能です。

> システムディスク（通常`C:\`）でないほかのディスクで`txt`ファイルを作成してください。

```lua:loadTxt.lua
version3()
runFile([[d:\mycode.txt]]) -- Replace to your path
```

> - ここで、`"d:\mycode.txt"`ではなく、`[[d:\mycode.txt]]`を使う理由は`\`が制御文字として扱われることを避けるからです。
> - 実際、仕様がテキストファイルでさえあれば、拡張子は任意です(`*.lua, *.code, *.magic`)。

次のコードを使ってAeプロジェクトファイル周辺に置かれているコードファイルを読み取れます。

```lua:loadTxt.lua
version3()
runFile( projectFolder .. [[mycode.txt]]) -- Replace to your file name
```

> 注意：`projectFolder`を使うには、Aeプロジェクトの保存が必須です。さもなければ、`projectFolder`は空文字列になってしまいます。

## まだおわってない！

![RerenderClick](RerenderLOGO.png)

ローカルでファイルの書き込みが終わって保存しても、PixelsWorldは直ぐにコードをシーンに反映できません。PixelsWorldにコードをロードさせるために、**Ctrl + Alt**を押しながら、プラグインパネルにあるロゴ画像をクリックしてください。これでPixelsWorldはローカルファイルを読み取ってくれます。


> コレクション好きなお客様のために、高確率でよく出てくるロゴ画像もありながら、ウルトラ激レアの画像も用意してあります。