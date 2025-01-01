# Global Variables

## Global Constants

PixelsWorld provides the following global constants for users to utilize:

```lua:const.lua
PI  -- The value of pi
TPI -- Two times pi
HPI -- Half of pi
QPI -- Quarter of pi
E   -- The natural number e
PHI -- The golden ratio phi
R2  -- Square root of 2
R3  -- Square root of 3
R5  -- Square root of 5
R7  -- Square root of 7
INPUT -- Input texture index -1
TEMP -- Cache texture index -2
OUTPUT -- Output texture index -3
PARAM0 -- Texture of layer 0
PARAM1 -- Texture of layer 1
PARAM2 -- Texture of layer 2
PARAM3 -- Texture of layer 3
PARAM4 -- Texture of layer 4
PARAM5 -- Texture of layer 5
PARAM6 -- Texture of layer 6
PARAM7 -- Texture of layer 7
PARAM8 -- Texture of layer 8
PARAM9 -- Texture of layer 9
platform -- Platform: Windows10: 0, no other platforms currently supported
host -- Host application: Ae: 0, no other hosts currently supported
```

## Global Variables

PixelsWorld provides the following variables derived from Ae for users to utilize:

> `[cached]` indicates a global variable that does not trigger a re-render unless memory is cleared.

```lua:globalvars.lua
depth -- Color depth, can be 8, 16, 32
width -- Width of the input layer
height -- Height of the input layer
time -- Current time (in seconds)
duration -- Duration of the current layer (in seconds) [cached]
inpoint -- In point time of the current layer (in seconds) [cached]
compTime -- Composition time (in seconds)
pluginFolder -- Plugin directory (UTF-8)
projectName -- Project name (UTF-8)
projectPath -- Project path (UTF-8)
projectFolder -- Path to the project folder (UTF-8)
ds_width -- Downsampled composition width
ds_height -- Downsampled composition height
origin_x -- X-coordinate of the top-left corner of the input layer in the layer coordinate system
origin_y -- Y-coordinate of the top-left corner of the input layer in the layer coordinate system
layerName -- Name of the current layer; if not set, it is empty (v3.6.4+) [cached]
layerSourceName -- Source name of the current layer; usually not empty (v3.6.4+) [cached]
compName -- Current composition name (v3.6.4+) [cached]
fps -- Frames per second
```

## Printing Global Variables

Run the following code in Lua mode to print global variables (including global functions):

```lua:printGlobals.lua
version3()
in2out()
for k, v in pairs(_G) do
    print(k)
    print(" " .. type(v), .5, .5, .5)
    print(" ".. tostring(_G[k]), 0, 1, 1)
    println("")
end
```