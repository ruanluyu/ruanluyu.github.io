# World formula editor
-------

## Open the formula editor
Click the "Edit" button in the plugin panel. 

![World formula editor](formulaEditor.png)

For demonstrating purpose, we highlight different areas with colored rectangles. 

![World formula editor(colored)](FE_AreaInfo.png)

## <span style="color:rgb(255,0,0)">◆</span>Code area

Input your creative code here. 

> `Language` in this panel overrides the Language setting in your plugin panel. `(default)` selection means current language. 


## <span style="color:rgb(56,148,228)">◆</span>Reference list

Reference code that would help you to remind some frequently-used functions are listed here, this list is read-only currently.


## <span style="color:rgb(243,27,243)">◆</span>Parameter settings

Here you can see the labels, the default value of parameters, and the language settings. Click the `Parameter manager` button to manage them. See also [Parameter manager](ParameterWindow.md)


> Parameter settings are saved with code into preset. 

## <span style="color:rgb(153,204,0)">◆</span>Preset list

The pop-up menu contains all preset files in your local disc. 

Some definitions about presets:

- A preset is a file with `.pwp` postfix, **JSON** format and located beside plugin. It is represented as a **Preset column** in PixelsWorld. Preset's file name is equal to the column name. 
- One **Preset column** contains several **Presets**
- **Presets** contained in a **Preset column** are listed below the pop-up menu. 

## <span style="color:rgb(128,0,0)">◆</span>Formula preview

Formula preview is where you can preview the code in the preset you selected. 

Click `Replace` button to apply preset code. 
> NOTE: Code in Code area will be overwritten. 
> By default, click `Replace` button will also apply parameter settings. If this is not expected, uncheck `Apply when replace` in <span style="color:rgb(247,136,58)">Parameter settings preview</span> area. 

If you want to joint the preset code in front of your current code, click `<<Top` button. 

If you want to joint the preset code behind your current code, click `Bottom>>` button.  

## <span style="color:rgb(247,136,58)">◆</span>Parameter settings preview

Parameter settings preview is where you can preview the parameter settings of the selected **Preset**. Click `Apply` button to override the current parameter settings. 
> `Apply when replace` means weather or not applies parameter settings when you click the `Replace` button in the Formula preview area. 


<br>
<br>
<br>
<br>
<br>
<br>