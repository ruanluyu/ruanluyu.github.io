# World formula editor
-------

## Open the formula editor
Click the "Edit" button in the plugin panel. 

![World formula editor](formulaEditor.png)

For demonstrating purpose, we highlight different area with colored rectangle. 

![World formula editor(colored)](FE_AreaInfo.png)

## <span style="color:rgb(255,0,0)">◆</span>Code area

Input your creative code here. 

> `Language` in this panel overrides the Language setting in your plugin panel. `(default)` selection means current language. 


## <span style="color:rgb(56,148,228)">◆</span>Reference list

Reference code that would help you to remind some frequently-used functions are listed here, this list is read-only currently.


## <span style="color:rgb(243,27,243)">◆</span>Parameter settings

Here you can see the labels, the default value of parameters and the language settings. Click `Parameter manager` button to manage them. See also [Parameter manager](ParameterWindow.md)


> Parameter settings are saved with code into preset. 

## <span style="color:rgb(153,204,0)">◆</span>Preset list

The pop-up menu contains all preset files in your local disc. 

Here are same definition:

- A file with `.pwp` post fix, **JSON** format and located beside plugin is a **Preset column**. The name of the Preset column is the file name. 
- One **Preset column** contains several **Presets**
- All **Presets** are listed below the pop-up menu. 

## <span style="color:rgb(128,0,0)">◆</span>Formula preview

The selected **Preset**'s code can be previewed here. Click the `Replace` button to send preset code to the left code area (This will override the previouse code). 

> If you only want to replace the text and don't want the parameter settings change. Uncheck `Apply when replace` in <span style="color:rgb(247,136,58)">Parameter settings preview</span> area. 

If you want the preset code to be combined in the front of your code, click `<<Top` button; `Bottom>>` means to combine preset code behind your current code.  

## <span style="color:rgb(247,136,58)">◆</span>Parameter settings preview

The selected **Preset**'s parameter settings can be previewed here. If you want to apply it, click `Apply` button to override the current settings. 
> `Apply when replace` means if auto apply parameter settings when you click the `Apply` button in the Formula preview area. 


<br>
<br>
<br>
<br>
<br>
<br>