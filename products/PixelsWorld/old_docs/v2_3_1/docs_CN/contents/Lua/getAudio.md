# pw.getAudio()
---

**说明：**

- 获取音频数据


**参数：**

- pw.getAudio(start, duration)
- pw.getAudio(start, duration, layerid)
- pw.getAudio(start, duration, layerid, samplerate)
- start: 开始时间。
- duration: 持续时间。
- layerid: 参数层，默认为-1——代表当前层。可填-1~9,0~9指参数层序号。
- samplerate: 采样率，默认为44100。

**返回：**

按次序返回如下四个数组
- 左声道波形 (浮点数组, -1~1)
- 右声道波形 (浮点数组, -1~1)
- 左声道频谱 (浮点数组, 0~正无穷)
- 右声道频谱 (浮点数组, 0~正无穷)

**示例**

```lua:getAudio.lua

pw.in2out()

local wl,wr,fl,fr = pw.getAudio(time-0.1,0.2,-1,44100)
local nm = math.floor(height/8);

for i=1,nm do
    local wid =math.max(math.floor(i/nm*#wl),1)
    local fid = math.max(math.floor(i/nm*#fl/16),1)
    pw.print(string.format("%8.5f",wl[wid]),1,wl[wid]*4,0,-wl[wid]*4)
    pw.print("  < L  R >  ",1,0,0,0)
    pw.print(string.format("%8.5f",wr[wid]),1,wr[wid]*4,0,-wr[wid]*4)
    pw.print("      <   Wave  FFT   >      ",1,0.5,0.5,0.5)
    pw.print(string.format("%8.5f",fl[fid]),1,fl[fid]/math.sqrt(#fl),0,0)
    pw.print("  < L  R >  ",1,0,0,0)
    pw.print(string.format("%8.5f",fr[fid]),1,0,0,fr[fid]/math.sqrt(#fr))
    pw.println("");
end

```
