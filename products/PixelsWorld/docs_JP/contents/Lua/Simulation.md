# 物理シミュレーション
---

> 以下の画像は、[nimitzによって制作されたChimera's Breath](https://www.shadertoy.com/view/4tGfDW)がPixelsWorldで実行された結果です。[完全なビデオを見る](https://www.bilibili.com/video/BV1854y1p7Rv/)

![fluidSingleFrame](./FluidSimSingleFrame.png)

この章では、PixelsWorldでデータをキャッシュする方法を紹介します。

<span style="color:red">注意：Aeの機能が制限されているため、このマニュアルに定められた規範に厳密に従ってキャッシュを行ってください。</span>

> - PixelsWorldの`v3.3.3+`バージョンをお持ちであることを確認してください
> - この文章は、読者がある程度のAe操作とPixelsWorldコードの熟練度を有していることを前提としています。PixelsWorldの使用法に不慣れな場合は、前の章を学習してください。
> - Aeのマルチコアレンダリング機能をオフにすることをお勧めします。

<!-- no toc --> 
- [物理シミュレーション](#物理シミュレーション)
  - [データキャッシュ](#データキャッシュ)
  - [テクスチャキャッシュ](#テクスチャキャッシュ)
  - [データキャッシュ実践――三体問題シミュレーション](#データキャッシュ実践――三体問題シミュレーション)
  - [テクスチャキャッシュ実践――コンウェイのライフゲーム](#テクスチャキャッシュ実践――コンウェイのライフゲーム)
  - [テクスチャキャッシュ実践――流体シミュレーション](#テクスチャキャッシュ実践――流体シミュレーション)

## データキャッシュ

PixelsWorldでデータをキャッシュするには、以下のステップに従います：

コードロジック：
1. キャッシュ位置とキャッシュファイル名を設定
2. `frameId=time*fps`を計算
3. `lastFrameId=frameId-1`を計算
4. `lastFrameId`が0未満の場合は5へ、そうでない場合は6へ
5. データを初期化し、7へ
6. ローカルに保存された前フレームのシミュレーションデータファイルを読み取り、ファイルが存在しない場合はエラーを報告、そうでない場合は7へ
7. 今回のフレームのシミュレーションデータを計算
8. 今回のフレームのシミュレーションデータをローカルに保存

操作ロジック：
1. 上記ロジックに従うコードをPixelsWorldに書き込む
2. 時間インジケータを現在のレイヤーの最初の位置に移動する
3. Aeのすべてのキャッシュをクリアする（`Edit->Purge->All Memory & Disk Cache...` 下図）
4. `Ctrl+Alt`を押し、プラグインパネルのLOGOをクリックする（このステップはオプション）
5. スペースキーを押してレンダリングを開始する（**飛ばしてレンダリングしないでください**）

> 注意：不安を感じる場合（エラー、画面がフラッシュするなど）は、必ず2〜5のステップを再実行してください

![Purge](purge.png)

## テクスチャキャッシュ

コードロジック：
1. ダウンサンプリング（1/2、1/4モード）の場合、エラーを報告
2. キャッシュ位置とキャッシュファイル名を設定
3. `frameId=time*fps`を計算
4. `lastFrameId=frameId-1`を計算
5. `lastFrameId`が0未満の場合は5へ、そうでない場合は6へ
6. データを初期化し、7へ
7. ローカルに保存された前フレームのテクスチャファイルを読み取り、ファイルが存在しない場合はエラーを報告、そうでない場合は7へ
8. 今回のフレームのテクスチャファイルを計算
9. 今回のフレームのテクスチャファイルをローカルに保存

> テクスチャの操作については、[テクスチャ](./Texture.md)の章をご覧ください

操作ロジック：
1. 上記ロジックに従うコードをPixelsWorldに書き込む
2. プラグインパネルの設立`Advanced->Internal texture format`を`Floating point 32bit x RGBA (HDR)`に設定する
3. 時間インジケータを現在のレイヤーの最初の位置に移動する
4. Aeのすべてのキャッシュをクリアする（`Edit->Purge->All Memory & Disk Cache...`）
5. `Ctrl+Alt`を押し、プラグインパネルのLOGOをクリックする（このステップはオプション）
6. スペースキーを押してレンダリングを開始する（**飛ばしてレンダリングしないでください**）

## データキャッシュ実践――三体問題シミュレーション

![TheThreeBodyProblemResult](TheThreeBody.gif)

```lua:the_three_body_problem.lua
version3()

-- ベクトルライブラリをインポート
require("veclib") 

-- キャッシュファイル名を設定
local cacheFileName = "A" 

-- ファイルが存在するか確認する関数を宣言（関数はhttps://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-luaより）
function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end

-- 現在のフレーム番号を計算し四捨五入
local frameId = math.floor(time * fps + .5)

-- 前のフレーム番号を計算
local lastFrameId = frameId -1

-- 現在のフレーム番号が非負であることを確認し、負の場合はエラーを報告
assert(frameId >= 0, "FrameId not support")
-- 現在のフレーム番号を表示（この行は削除可能）
println("Frame ID: " .. frameId)

-- キャッシュフォルダを設定（ここではaepプロジェクトの隣にあるcacheフォルダをディレクトリとして使用、projectFolderを使用する前にプロジェクトを保存する必要があります）
local cachePath = projectFolder .. "cache\\"
-- 現在の出力フォルダを表示（この行は削除可能）
println("Cache path: " .. cachePath)

-- 本フレーム番号が0の場合（つまり前のフレームが0未満）
if(lastFrameId < 0) then
    -- 3つの物体の位置と速度を初期化
    p1 = vec3(100,0,0)
    v1 = vec3(-0.1,-0.1,-0.5)
    p2 = vec3(0,-100,0)
    v2 = vec3(0,0.1,0)
    p3 = vec3(-100,0,-95)
    v3 = vec3(0.1,0,0.5)
else
    -- 前のフレームのキャッシュファイルが存在するか確認
    if(file_exists(cachePath .. cacheFileName .. "_" .. tostring(lastFrameId) .. ".txt")) then
        -- ローカルに保存された前フレームのデータを読み取る
        lua(loadString(cachePath .. cacheFileName .. "_" .. tostring(lastFrameId) .. ".txt"))
    else 
        -- 存在しない場合はエラーを報告
        error("Please go back to frame 0 to re-cache your comp")
    end
end

-- 物理シミュレーションを開始
center = vec3(width/2,height/2,0)

f1,f2,f3 = vec3(0),vec3(0),vec3(0)
r = 15

m1=8
m2=10
m3=5

dp12,dp13,dp23 = p1-p2,p1-p3,p2-p3

f1 = f1 + m1*m2/math.max(dot(dp12,dp12),1e-1) * (-dp12)
f2 = f2 + m1*m2/math.max(dot(dp12,dp12),1e-1) * (dp12)

f1 = f1 + m1*m3/math.max(dot(dp13,dp13),1e-1) * (-dp13)
f3 = f3 + m1*m3/math.max(dot(dp13,dp13),1e-1) * (dp13)

f2 = f2 + m3*m2/math.max(dot(dp23,dp23),1e-1) * (-dp23)
f3 = f3 + m3*m2/math.max(dot(dp23,dp23),1e-1) * (dp23)

v1 = v1 + f1*(1/m1)
p1 = p1 + v1

v2 = v2 + f2*(1/m2)
p2 = p2 + v2

v3 = v3 + f3*(1/m3)
p3 = p3 + v3

-- 物理シミュレーション終了

-- 3つの物体の位置と速度データをローカルに保存
saveString(
    cachePath .. cacheFileName .. "_" .. tostring(frameId) .. ".txt",
    string.format([==[
        p1=vec3(%f,%f,%f);v1=vec3(%f,%f,%f);
        p2=vec3(%f,%f,%f);v2=vec3(%f,%f,%f);
        p3=vec3(%f,%f,%f);v3=vec3(%f,%f,%f);
        ]==],
        p1.x,p1.y,p1.z,v1.x,v1.y,v1.z,
        p2.x,p2.y,p2.z,v2.x,v2.y,v2.z,
        p3.x,p3.y,p3.z,v3.x,v3.y,v3.z
    )
)

-- 現在のフレームシミュレーションデータを使用して3つの惑星を描画
dim3()

move(center.x,center.y,center.z)

-- 座標系とグリッドを描画
coord()
grid()

-- 第一の惑星
beginGroup()
move(p1.x,p1.y,p1.z)
fill(1,0,1)
ball(r)
endGroup()

-- 第二の惑星
beginGroup()
fill(1,1,0)
move(p2.x,p2.y,p2.z)
ball(r)
endGroup()

-- 第三の惑星
beginGroup()
fill(0,1,1)
move(p3.x,p3.y,p3.z)
ball(r)
endGroup()
```
## テクスチャキャッシュ実践――コンウェイのライフゲーム

![GameOfLifeResult](GameOfLife.gif)

```lua:game_of_life.lua
version3()

-- ダウンサンプリングをチェック
assert(width == ds_width and height == ds_height , "Downsample not support" )

-- ファイルが存在するか確認する関数を宣言（関数はhttps://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-luaより）
function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end

-- 現在のフレーム番号を計算し四捨五入
local frameId = math.floor(time * fps + .5)

-- 前のフレーム番号を計算
local lastFrameId = frameId -1

-- 現在のフレーム番号が非負であることを確認し、負の場合はエラーを報告
assert(frameId >= 0, "FrameId not support")
-- 現在のフレーム番号を表示（この行は削除可能）
println("Frame ID: " .. frameId)

-- キャッシュパスを設定
local cachePath = projectFolder .. "cache\\"
println("Cache path: " .. cachePath)

-- 最初のフレームかどうかを確認
if(lastFrameId < 0) then
    -- テクスチャを初期化
    lastTexA = newTex(width,height)
else
    -- 前のフレームが存在するか確認
    if(file_exists(cachePath .. "A_" .. tostring(lastFrameId) .. ".raw")) then
        -- 前のフレームのテクスチャをインポート
        lastTexA = loadRAW(cachePath .. "A_" .. tostring(lastFrameId) .. ".raw")
    else 
        error("Please go back to frame 0 to cache your comp")
    end
end

-- レンダリングコードを設定
local fragCode = [==[
// 定義：https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
// MITライセンス（学習とビジネス目的のために無料）
// コード: ZzStarSound

const int dx[8] = int[](-1,0,1,1,1,0,-1,-1);
const int dy[8] = int[](1,1,1,0,-1,-1,-1,0);

bool fetchStatus(int ox, int oy)
{
    ivec2 iuv = ivec2(floor(uv*resolution.xy)) + ivec2(ox,oy);
    ivec2 res = ivec2(floor(resolution.xy));
    if(iuv.x >= res.x || iuv.x < 0 || iuv.y >=res.y || iuv.y<0) return false;
    return texelFetch(layer[0],iuv,0).x>.5;
}

// 出典 https://thebookofshaders.com/10/
float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

void main(){
    if(time == 0.)
    {
        outColor = vec4(random(uv)>.5);
    }else{
        bool curstatus = fetchStatus(0,0);
        int roundCount = 0;
        for(int i = 0;i<8;i++){
            if(fetchStatus(dx[i],dy[i])) roundCount ++ ;
        }
        if(curstatus)
        {
            if(roundCount < 2 || roundCount > 3) outColor = vec4(0);
            else outColor = vec4(curstatus);
        }
        else
        {
            if(roundCount == 3) outColor = vec4(1);
            else outColor = vec4(0);
        }
    }
}
]==]

-- 前のフレーム画像をPARAM0位置に配置し、glslがlayer[0]で前のフレームのテクスチャを読み取れるようにする
swapTex(PARAM0,lastTexA)

--レンダリングコード
glsl(fragCode)

-- 前のフレーム画像を自分の位置に戻す
swapTex(PARAM0,lastTexA)

-- 今回のフレームのテクスチャをローカルに保存
saveRAW(cachePath .. "A_" .. tostring(frameId) .. ".raw",OUTPUT)
```
## テクスチャキャッシュ実践――流体シミュレーション

![fluidDual](fluidDual.gif)

> - 注意：[原作者](https://www.shadertoy.com/view/4tGfDW)のコードライセンスにより、以下のコードは学習交流のみに使用し、商用利用しないでください。
> - プラグインパネルの`Internal texture format`を`Floating point 32 bit x RGBA (HDR)`に変更することを忘れないでください。
> - <span style="color:red">シミュレーションを始める前に、必ず前提の操作説明をお読みください！</span> [読みに行く>>>](#データキャッシュ)
> - `Mipmap filter`を`NONE`に設定すると速度が向上します。

```lua:fluid_simulation.lua
version3()

assert(width == ds_width and height == ds_height , "Downsample not support" )

function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end

local frameId = math.floor(time * fps + .5)
local lastFrameId = frameId -1

assert(frameId >= 0, "FrameId not support")
println("Frame ID: " .. frameId)
local cachepath = projectFolder .. "cache\\"
println("Cache path: " .. cachepath)

if(lastFrameId < 0) then
    lastTexC = newTex(width,height)
    lastTexD = newTex(width,height)
    drawTo(lastTexC)
    background(0,0,0,1)
    drawTo(lastTexD)
    background(0,0,0,1)
    drawTo(OUTPUT)
else
    path_c = cachepath .. "C_" .. tostring(lastFrameId) ..".raw"
    path_d = cachepath .. "D_" .. tostring(lastFrameId) ..".raw"
    if(file_exists(path_c) and file_exists(path_d) ) then
        lastTexC = loadRAW(path_c)
        lastTexD = loadRAW(path_d)
    else 
        error("Please go back to frame 0 to cache your comp")
    end
end

local commonCode = [==[
//Chimera's Breath
//by nimitz 2018 (twitter: @stormoid)
/*
    ここでの主な関心は、渦度の閉じ込めをシミュレーションテクスチャの
    アルファチャンネルに保存することで、その結果、信じられるほどの
    低粘度の流体のシミュレーションが可能になることです。
    渦度の閉じ込めなしでは、シミュレーション可能な流体は、
    より厚いオイルに似たものになります。
    
    基本的なシミュレーションは2011年の論文「Simple and fast fluids」に基づいています。
    （Martin Guay, Fabrice Colin, Richard Egli）
    （https://hal.inria.fr/inria-00596050/document）

    実際のシミュレーションには1つのパスしか必要ありません。Buffer A, B, C は
    互いのコピーで、シミュレーション速度を上げています（1フレームに3つの
    シミュレーションパス）。
    Buffer D はシミュレーションされた流体に色を描画しています。
    （実際のシナリオでは粒子を使うことができます）
*/

#define dt 0.15
#define USE_VORTICITY_CONFINEMENT
//#define MOUSE_ONLY

//お薦め値は0.03～0.2間
//高い値は低粘度の流体をシミュレートします（煙のような動きを想像してください）
#define VORTICITY_AMOUNT 0.11

float mag2(vec2 p){return dot(p,p);}
vec2 point1(float t) {
    t *= 0.62;
    return vec2(0.12,0.5 + sin(t)*0.2);
}
vec2 point2(float t) {
    t *= 0.62;
    return vec2(0.88,0.5 + cos(t + 1.5708)*0.2);
}

vec4 solveFluid(sampler2D smp, vec2 uv, vec2 w, float time)
{
    const float K = 0.2;
    const float v = 0.55;
    
    vec4 data = textureLod(smp, uv, 0.0);
    vec4 tr = textureLod(smp, uv + vec2(w.x , 0), 0.0);
    vec4 tl = textureLod(smp, uv - vec2(w.x , 0), 0.0);
    vec4 tu = textureLod(smp, uv + vec2(0 , w.y), 0.0);
    vec4 td = textureLod(smp, uv - vec2(0 , w.y), 0.0);
    
    vec3 dx = (tr.xyz - tl.xyz)*0.5;
    vec3 dy = (tu.xyz - td.xyz)*0.5;
    vec2 densDif = vec2(dx.z ,dy.z);
    
    data.z -= dt*dot(vec3(densDif, dx.x + dy.y) ,data.xyz); //density
    vec2 laplacian = tu.xy + td.xy + tr.xy + tl.xy - 4.0*data.xy;
    vec2 viscForce = vec2(v)*laplacian;
    data.xyw = textureLod(smp, uv - dt*data.xy*w, 0.).xyw; //advection
    
    vec2 newForce = vec2(0);

    newForce.xy += 0.75*vec2(.0003, 0.00015)/(mag2(uv-point1(time))+0.0001);
    newForce.xy -= 0.75*vec2(.0003, 0.00015)/(mag2(uv-point2(time))+0.0001);
    
    
    data.xy += dt*(viscForce.xy - K/dt*densDif + newForce); //update velocity
    data.xy = max(vec2(0), abs(data.xy)-1e-4)*sign(data.xy); //linear velocity decay
    
    #ifdef USE_VORTICITY_CONFINEMENT
    data.w = (tr.y - tl.y - tu.x + td.x);
    vec2 vort = vec2(abs(tu.w) - abs(td.w), abs(tl.w) - abs(tr.w));
    vort *= VORTICITY_AMOUNT/length(vort + 1e-9)*data.w;
    data.xy += vort;
    #endif
    
    data.y *= smoothstep(.5,.48,abs(uv.y-0.5)); //Boundaries
    
    data = clamp(data, vec4(vec2(-10), 0.5 , -10.), vec4(vec2(10), 3.0 , 10.));
    
    return data;
}
]==]

local bufferACode = [==[

    float length2(vec2 p){return dot(p,p);}
    mat2 mm2(in float a){float c = cos(a), s = sin(a);return mat2(c,s,-s,c);}
    
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        vec2 uv = fragCoord.xy/iResolution.xy;
        vec2 w = 1.0/iResolution.xy;
        
        vec4 data = solveFluid(iChannel0, uv, w, iTime);
        fragColor = data;
        
    }
]==]

local bufferBCode = [==[

    float length2(vec2 p){return dot(p,p);}
    mat2 mm2(in float a){float c = cos(a), s = sin(a);return mat2(c,s,-s,c);}
    
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        vec2 uv = fragCoord.xy/iResolution.xy;
        vec2 w = 1.0/iResolution.xy;
        
        vec4 data = solveFluid(iChannel0, uv, w, iTime);
        fragColor = data;
        
    }
]==]

local bufferCCode = [==[

    float length2(vec2 p){return dot(p,p);}
    mat2 mm2(in float a){float c = cos(a), s = sin(a);return mat2(c,s,-s,c);}
    
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        vec2 uv = fragCoord.xy/iResolution.xy;
        vec2 w = 1.0/iResolution.xy;
        
        vec4 data = solveFluid(iChannel0, uv, w, iTime);
        fragColor = data;
        
    }
]==]

local bufferDCode = [==[
    //Chimera's Breath
    //by nimitz 2018 (twitter: @stormoid)
    
    //液体シミュレーションコードについては「Common」タブを参照
    
    mat2 mm2(in float a){float c = cos(a), s = sin(a);return mat2(c,s,-s,c);}
    
    //このパレットに関連するシェーダーが来る
    vec3 getPalette(float x, vec3 c1, vec3 c2, vec3 p1, vec3 p2)
    {
        float x2 = fract(x/2.0);
        x = fract(x);   
        mat3 m = mat3(c1, p1, c2);
        mat3 m2 = mat3(c2, p2, c1);
        float omx = 1.0-x;
        vec3 pws = vec3(omx*omx, 2.0*omx*x, x*x);
        return clamp(mix(m*pws, m2*pws, step(x2,0.5)),0.,1.);
    }
    
    vec4 pal(float x)
    {
        vec3 pal = getPalette(-x, vec3(0.2, 0.5, .7), vec3(.9, 0.4, 0.1), vec3(1., 1.2, .5), vec3(1., -0.4, -.0));
        return vec4(pal, 1.);
    }
    
    vec4 pal2(float x)
    {
        vec3 pal = getPalette(-x, vec3(0.4, 0.3, .5), vec3(.9, 0.75, 0.4), vec3(.1, .8, 1.3), vec3(1.25, -0.1, .1));
        return vec4(pal, 1.);
    }
    
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        vec2 uv = fragCoord.xy / iResolution.xy;
        vec2 mo = iMouse.xy / iResolution.xy;
        vec2 w = 1.0/iResolution.xy;
        
        vec2 velo = textureLod(iChannel0, uv, 0.).xy;
        vec4 col = textureLod(iChannel1, uv - dt*velo*w*3., 0.); //advection
    
        col += .0025/(0.0005+pow(length(uv - point1(iTime)),1.75))*dt*0.12*pal(iTime*0.05 - .0);
        col += .0025/(0.0005+pow(length(uv - point2(iTime)),1.75))*dt*0.12*pal2(iTime*0.05 + 0.675);
        
        if (iFrame < 20)
        {
            col = vec4(0.);
        }
        
        col = clamp(col, 0.,5.);
        col = max(col - (0.0001 + col*0.004)*.5, 0.); //decay
    
        fragColor = col;
        
    }
    
]==]

local mainCode = [==[
    void mainImage( out vec4 fragColor, in vec2 fragCoord )
    {
        vec4 col = textureLod(iChannel0, fragCoord/iResolution.xy, 0.);
        fragColor = col;
    }
]==]

local texA,texB,texC=newTex(width,height),newTex(width,height),newTex(width,height)

swapTex(PARAM0,lastTexC)
shadertoy(commonCode .. bufferACode)
swapTex(PARAM0,lastTexC)
castTex(texA,OUTPUT)

swapTex(PARAM0,texA)
shadertoy(commonCode .. bufferBCode)
swapTex(PARAM0,texA)
castTex(texB,OUTPUT)

swapTex(PARAM0,texB)
shadertoy(commonCode .. bufferCCode)
swapTex(PARAM0,texB)
castTex(texC,OUTPUT)
saveRAW(cachepath .. "C_" .. tostring(frameId) ..".raw",texC)

swapTex(PARAM0,texA)
swapTex(PARAM1,lastTexD)
shadertoy(commonCode .. bufferDCode)
swapTex(PARAM0,texA)
swapTex(PARAM1,lastTexD)
saveRAW(cachepath .. "D_" .. tostring(frameId) ..".raw",OUTPUT)
```