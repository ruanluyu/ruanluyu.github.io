# 物理シミュレーション
---

> 次の動画は[nimitzさんが作った作品Chimera's Breath](https://www.shadertoy.com/view/4tGfDW)のPixelsWorldにおいて実装した結果です。[フルサイズ動画](https://youtu.be/OvohYJbnOvE)

![fluidDual](fluidDual.gif)

この章では、PixelsWorldを用いてキャッシュの扱い方を紹介します。

<span style="color:red">注意：正しいシミュレーション結果を得るために、本マニュアルにきちんと読んだ上でコードを実装してください。</span>

> - `v3.3.2+`以上のPixelsWorldが必要です。
> - この章は、読者が既にAe及びPixelsWorldを深く理解したと仮定して書いたものです。

<!-- no toc --> 
- [キャッシュデータ](#データのキャッシュ)
- [キャッシュテクスチャ](#テクスチャのキャッシュ)
- [キャッシュデータ使用例：三体問題](#データのキャッシュ使用例：三体問題)
- [キャッシュテクスチャ使用例：ライフゲーム](#テクスチャのキャッシュ使用例：ライフゲーム)


## キャッシュデータ

データをキャッシュするために、次の手順に従ってください。

コード：
1. キャッシュの保存する場所とキャッシュファイルの名前を決める
2. `frameId=time*fps`を計算する
3. `lastFrameId=frameId-1`を計算する
4. `lastFrameId` < 0　ならば5へ、そうでなければ、6へ。
5. データを初期化する。7へ
6. 前のフレームで保存したデータファイルを読み取る。ファイルがない場合エラーを出力する。他の場合、7へ
7. 今のフレームのデータを計算する。
8. データをローカルに保存する。

操作：
1. 上の手順に満たすコードを実装する。
2. Aeの時間カーソルを最初のフレームに移動させる。
3. Aeのキャッシュを削除する(`Edit->Purge->All Memory & Disk Cache...` 下の図に示すように)
4.  `Ctrl+Alt`を押しながら、LOGO画像をクリックする。（このステップはオプショナル）
5. スペースキーを押してレンダリングする。(**フレームをスキップしないこと**)

> 注意：何か不具合があったら (エラー、画像キャッシュの不具合など)、2～5をやり直してください。

![Purge](purge.png)



## キャッシュテクスチャ


コード：
1. 画像の質が下がったら(例えば：1/2, 1/4 プレビューモード), エラーを出す。
2. `frameId=time*fps`を計算する
3. `lastFrameId=frameId-1`を計算する
4. `lastFrameId` < 0　ならば5へ、そうでなければ、6へ。
5. データを初期化する。7へ
6. 前のフレームで保存したデータファイルを読み取る。ファイルがない場合エラーを出力する。他の場合、7へ
7. 今のフレームのデータを計算する。
8. データをローカルに保存する。 

> テクスチャの操作方法に関しては、[こちら](./Texture.md)をご覧ください。

操作：
1. 上の手順に満たすコードを実装する。
2. PixelsWorldパネルの設定の`Advanced->Internal texture format`を`Floating point 32bit x RGBA (HDR)`にする。
3. Aeの時間カーソルを最初のフレームに移動させる。
4. Aeのキャッシュを削除する(`Edit->Purge->All Memory & Disk Cache...` 下の図に示すように)
5.  `Ctrl+Alt`を押しながら、LOGO画像をクリックする。（このステップはオプショナル）
6. スペースキーを押してレンダリングする。(**フレームをスキップしないこと**)


## キャッシュデータ使用例：三体問題


![TheThreeBodyProblemResult](TheThreeBody.gif)

```lua:the_three_body_problem.lua
version3()


-- Include vector library
require("veclib") 


-- Set cache file name
local cacheFileName = "A" 


-- Add checking if file exists function(Refer: https://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-lua) 
function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
end


-- Calculate current frame index then round it to integer. 
local frameId = math.floor(time * fps + .5)


-- Calculate last frame index 
local lastFrameId = frameId -1



-- Frame id should not be negative. 
assert(frameId >= 0, "FrameId not support")
-- Print it out. (This line can be removed)
println("Frame ID: " .. frameId)



-- Set cache folder. (Here I used the aep project folder, don't forget to save your project before use projectFolder)
local cachePath = projectFolder .. "cache\\"
-- Print it out. (This line can be removed)
println("Cache path: " .. cachePath)



-- If frameId == 0 (Namely lastFrameId < 0)
if(lastFrameId < 0) then
    -- Initialze the position and velocity of 3 plants
    p1 = vec3(100,0,0)
    v1 = vec3(-0.1,-0.1,-0.5)
    p2 = vec3(0,-100,0)
    v2 = vec3(0,0.1,0)
    p3 = vec3(-100,0,-95)
    v3 = vec3(0.1,0,0.5)
else
    -- Check if last frame data exists. 
    if(file_exists(cachePath .. cacheFileName .. "_" .. tostring(lastFrameId) .. ".txt")) then
        -- Read last frame data. 
        lua(loadString(cachePath .. cacheFileName .. "_" .. tostring(lastFrameId) .. ".txt"))
    else 
        -- Throw error when not exists
        error("Please go back to frame 0 to re-cache your comp")
    end
end

-- Start calculation (simulation)
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

-- End simulation


-- Save position and velocity to local
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


-- Draw three plants with simulation data. 
dim3()

move(center.x,center.y,center.z)

-- Draw coordinate and grid. 
coord()
grid()

-- 1st planet
beginGroup()
move(p1.x,p1.y,p1.z)
fill(1,0,1)
ball(r)
endGroup()

-- 2nd planet
beginGroup()
fill(1,1,0)
move(p2.x,p2.y,p2.z)
ball(r)
endGroup()

-- 3rd planet
beginGroup()
fill(0,1,1)
move(p3.x,p3.y,p3.z)
ball(r)
endGroup()
```


## キャッシュテクスチャ使用例：ライフゲーム

![GameOfLifeResult](GameOfLife.gif)

```lua:game_of_life.lua
version3()

-- Check downsample settings. 
assert(width == ds_width and height == ds_height , "Downsample not support" )


-- Add checking if file exists function(Refer: https://stackoverflow.com/questions/4990990/check-if-a-file-exists-with-lua) 
function file_exists(name)
    local f=io.open(name,"r")
    if f~=nil then io.close(f) return true else return false end
 end


-- Calculate current frame index then round it to integer. 
local frameId = math.floor(time * fps + .5)


-- Calculate last frame index 
local lastFrameId = frameId -1



-- Frame id should not be negative. 
assert(frameId >= 0, "FrameId not support")
-- Print it out. (This line can be removed)
println("Frame ID: " .. frameId)



-- Set cache folder.
local cachePath = projectFolder .. "cache\\"
-- Print it out. (This line can be removed)
println("Cache path: " .. cachePath)



-- Check if it is frame 0
if(lastFrameId < 0) then
    -- Initialize texture
    lastTexA = newTex(width,height)
else
    -- Check if last frame texture exists
    if(file_exists(cachePath .. "A_" .. tostring(lastFrameId) .. ".exr")) then
        -- Load last frame texture
        lastTexA = loadEXR(cachePath .. "A_" .. tostring(lastFrameId) .. ".exr")
    else 
        error("Please go back to frame 0 to cache your comp")
    end
end


-- Set render code
local fragCode = [==[
// Definition from: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
// MIT license (Free for study and business purpose)
// Code by ZzStarSound

const int dx[8] = int[](-1,0,1,1,1,0,-1,-1);
const int dy[8] = int[](1,1,1,0,-1,-1,-1,0);

bool fetchStatus(int ox, int oy)
{
    ivec2 iuv = ivec2(floor(uv*resolution.xy)) + ivec2(ox,oy);
    ivec2 res = ivec2(floor(resolution.xy));
    if(iuv.x >= res.x || iuv.x < 0 || iuv.y >=res.y || iuv.y<0) return false;
    return texelFetch(layer[0],iuv,0).x>.5;
}

// From https://thebookofshaders.com/10/
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


-- Put the last frame texture to PARAM0, so that you can read last frame texture via layer[0]
swapTex(PARAM0,lastTexA)


-- Render texture
glsl(fragCode)


-- Put the last frame texture back to its original position. 
swapTex(PARAM0,lastTexA)



-- Save texture to local
saveEXR(cachePath .. "A_" .. tostring(frameId) .. ".exr",OUTPUT)


```
