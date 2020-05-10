# World formula editor
-------

## How to open
Click "Edit" button in plugin panel. 

![World formula editor](formulaEditor.png)

To make it simple to describe, we assigned defferent area with color. 

![World formula editor(colored)](FE_AreaInfo.png)

## <span style="color:rgb(255,0,0)">◆</span>Code area

Input your creative code here. 

> `Language` can override the settings in your plugin panel. `(default)` selection means don't override. 


## <span style="color:rgb(56,148,228)">◆</span>Reference list

You can copy reference code here, this is read-only currently.


## <span style="color:rgb(243,27,243)">◆</span>Parameter settings

Here you can see the labels, the default value of parameters and the language settings. Click `Parameter manager` button to manage them. See also [Parameter manager](ParameterWindow.md)


> Parameter settings will be saved with code into preset. 

## <span style="color:rgb(153,204,0)">◆</span>Preset list

The pop-up menu will show you all the preset files in your local disc. 

Here we have same definition:

- A file with `.pwp` post fix, has **JSON** format and put beside plugin will be treat as one **Preset column**. The name of Preset column is the name of that file. 
- One **Preset column** containing several **Presets**
- All **Presets** will be list on the bottom of the pop-up menu. 

## <span style="color:rgb(128,0,0)">◆</span>Formula preview

The selected **Preset**'s code will be shown here. If you want it to go to your code area, click `Replace` button to override code in the code area. 

> If you only want to replace the text and don't want the parameter settings changed. Uncheck `Apply when replace` in <span style="color:rgb(247,136,58)">Parameter settings preview</span> area. 

If you want to add the preset code before your code, click `<<Top` button; If you want it behind your code, click `Bottom>>` button. 

## <span style="color:rgb(247,136,58)">◆</span>Parameter settings preview

The selected **Preset**'s parameter settings will be shown here. If you want it to go to your code area, click `Replace` button to override code in the code area. 
> `Apply when replace` means if auto apply parameter settings when you clicked `Replace` button in Formula preview area. 


<br>
<br>
<br>
<br>
<br>
<br>