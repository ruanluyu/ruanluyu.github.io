# pw.getAudio()
---

**Description**

- Get audio data


**Parameter**

- pw.getAudio(start, duration)
- pw.getAudio(start, duration, layerid)
- pw.getAudio(start, duration, layerid, samplerate)
- start: Start time of sampling。
- duration: Duration of sampling。
- layerid: -1 means current layer, 0~9 means the index of layer parameter, default: -1 
- samplerate: Sample rate, default: 44100

**Return**

Return four array one by one
- Waveform samples of left channel (float array, -1~1)
- Waveform samples of right channel (float array, -1~1)
- Spectrum samples of left channel (float array, 0~infinity)
- Spectrum samples of right channel (float array, 0~infinity)

**Example**

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
