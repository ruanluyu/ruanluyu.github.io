# Globals

## Global constants

Here are some global constants in PixelsWorld: 

```lua:const.lua
PI  -- the Circular constant pi
TPI -- two pi
HPI -- half pi
QPI -- quarter pi
E   -- the Natural number e
PHI -- the Golden ratio phi
R2  -- square root 2
R3  -- square root 3
R5  -- square root 5
R7  -- square root 7
INPUT -- Index of input image -1
TEMP -- Index of temp image -2
OUTPUT -- Index of output image -3
PARAM0 -- Index of the #0 layer parameter 0
PARAM1 -- Index of the #1 layer parameter 1
PARAM2 -- Index of the #2 layer parameter 2
PARAM3 -- Index of the #3 layer parameter 3
PARAM4 -- Index of the #4 layer parameter 4
PARAM5 -- Index of the #5 layer parameter 5
PARAM6 -- Index of the #6 layer parameter 6
PARAM7 -- Index of the #7 layer parameter 7
PARAM8 -- Index of the #8 layer parameter 8
PARAM9 -- Index of the #9 layer parameter 9
platform -- Windows == 0, no other platforms. 
host -- Ae == 0, no other hosts. 
```

## Global variables

Here are some global variables in PixelsWorld: 

```lua:globalvars.lua
depth -- Dpc: 8,16,32
width -- Width input image
height -- Height input image
time -- Current time(s)
duration -- Duration of current layer(s)
inpoint -- Inpoint of current layer(s)
compTime -- Comp current time(s)
pluginFolder -- The plugin folder(utf8)
projectName -- Project name(utf8)
projectPath -- Project path(utf8)
projectFolder -- Project folder(utf8)
ds_width -- Width of downsampled input image
ds_height -- Height of downsampled input image
origin_x -- The X coordinate of left top corner of input image in the layer coordinate. 
origin_y -- The Y coordinate of left top corner of input image in the layer coordinate. 
```

## Print the globals 

Globals can be printed by using following code: 

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