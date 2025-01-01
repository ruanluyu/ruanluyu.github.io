# グローバル変数

## グローバル定数

PixelsWorldはユーザーが使用できる以下のグローバル定数を提供しています：

```lua:const.lua
PI  -- 円周率 pi
TPI -- 二倍円周率 two pi
HPI -- 円周率の半分 half pi
QPI -- 円周率の四分の一 quarter pi
E   -- 自然数 e
PHI -- 黄金分割数 phi
R2  -- ルート2 root 2
R3  -- ルート3 root 3
R5  -- ルート5 root 5
R7  -- ルート7 root 7
INPUT -- 入力マテリアル番号 -1
TEMP -- キャッシュマテリアル番号 -2
OUTPUT -- 出力マテリアル番号 -3
PARAM0 -- 第0層マテリアル 0
PARAM1 -- 第1層マテリアル 1
PARAM2 -- 第2層マテリアル 2
PARAM3 -- 第3層マテリアル 3
PARAM4 -- 第4層マテリアル 4
PARAM5 -- 第5層マテリアル 5
PARAM6 -- 第6層マテリアル 6
PARAM7 -- 第7層マテリアル 7
PARAM8 -- 第8層マテリアル 8
PARAM9 -- 第9層マテリアル 9
platform -- プラットフォーム：Windows10: 0 他のプラットフォームは現在サポートされていません
host -- ホストプログラム：Ae: 0 現在他のホストはサポートされていません
```

## グローバル変数

PixelsWorldは以下のいくつかのAeで取得された変数をユーザーに提供しています：

> `[cached]`とマークされたものはメモリがクリアされない限り再レンダリングを引き起こさないグローバル変数です。

```lua:globalvars.lua
depth -- カラーデプス，8，16，32
width -- 入力レイヤーの幅
height -- 入力レイヤーの高さ
time -- 現在の時間(s)
duration -- 所在レイヤーの持続時間(s) [cached]
inpoint -- 所在レイヤーのインポイント時間(s) [cached]
compTime -- 合成時間(s)
pluginFolder -- プラグイン所在ディレクトリ(utf8)
projectName -- プロジェクト名(utf8)
projectPath -- プロジェクトパス(utf8)
projectFolder -- プロジェクト所在フォルダのパス(utf8)
ds_width -- ダウンサンプル後の合成幅
ds_height -- ダウンサンプル後の合成高
origin_x -- 入力レイヤーの左上がレイヤー座標系のX座標
origin_y -- 入力レイヤーの左上がレイヤー座標系のY座標
layerName -- 現在のレイヤーのレイヤー名，レイヤー名が設定されていない場合は空 (v3.6.4+) [cached]
layerSourceName -- 現在のレイヤーのソース名、通常は空でない (v3.6.4+) [cached]
compName -- 現在の合成名 (v3.6.4+) [cached]
fps -- フレームレート
```

## グローバル変数の印刷

以下のコードをLuaモードで実行してグローバル変数（グローバル関数を含む）を印刷します。

```lua:printGlobals.lua
version3()
in2out()
for k, v in pairs(_G) do
    print(k)
    print(" " .. type(v) , .5,.5,.5)
    print(" ".. tostring(_G[k]),0,1,1)
    println("")
end
```