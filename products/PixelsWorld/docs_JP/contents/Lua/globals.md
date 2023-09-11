# Globals

## グローバル定数

PixelsWorldのグローバル定数は次のように定義されています。

```lua:const.lua
PI  -- 円周率
TPI -- 円周率二倍
HPI -- 円周率半分
QPI -- 円周率四分の一
E   -- 自然数
PHI -- 黄金比
R2  -- ルート２
R3  -- ルート３
R5  -- ルート５
R7  -- ルート７
INPUT -- インプットテクスチャID -1
TEMP -- 一時のテクスチャID -2
OUTPUT -- アウトプットテクスチャID -3
PARAM0 -- レイヤパラメーターテクスチャ 0
PARAM1 -- レイヤパラメーターテクスチャ 1
PARAM2 -- レイヤパラメーターテクスチャ 2
PARAM3 -- レイヤパラメーターテクスチャ 3
PARAM4 -- レイヤパラメーターテクスチャ 4
PARAM5 -- レイヤパラメーターテクスチャ 5
PARAM6 -- レイヤパラメーターテクスチャ 6
PARAM7 -- レイヤパラメーターテクスチャ 7
PARAM8 -- レイヤパラメーターテクスチャ 8
PARAM9 -- レイヤパラメーターテクスチャ 9
platform -- Windows == 0, ほかのプラットホームはまだ無し 
host -- Ae == 0, ほかのホストはまだ無し
```

## グローバル変数

グローバル変数は次のように定義されています。

> Variables marked with `[cached]` means re-render will not be triggered unless you purge the memory. 

```lua:globalvars.lua
depth -- Dpc: 8,16,32
width -- 画像の幅
height -- 画像の縦
time -- レイヤーの時間
duration -- レイヤーの長さ [cached]
inpoint -- レイヤーのインポイント [cached]
compTime -- Compの時間(s)
pluginFolder -- プラグインのフォルダー(utf8)
projectName -- プロジェクトの名前(utf8)
projectPath -- プロジェクトファイルのパス(utf8)
projectFolder -- プロジェクトファイルのフォルダー位置(utf8)
ds_width -- ダウンサンプリング時の画像の幅
ds_height -- ダウンサンプリング時の画像の縦
origin_x -- 入力画像の左上の原点のレイヤー座標系における相対X座標．
origin_y -- 入力画像の左上の原点のレイヤー座標系における相対Y座標．
layerName -- レイヤーの名前 (v3.6.4+) [cached]
layerSourceName -- ソースの名前 (v3.6.4+) [cached]
compName -- Compの名前 (v3.6.4+) [cached]
fps -- フレームレート
```

## グローバル変数を全部プリント

次のコードを用いてグローバル変数をシーンにプリントします。

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