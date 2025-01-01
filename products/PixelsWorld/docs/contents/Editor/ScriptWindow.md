# World Formula Editor
-------

## How to Open
Click the "Edit" button next to "World formula" to open the World Formula Editor. Below is how it looks when opened.

> Note: The actual appearance may slightly differ with version updates.

![World Formula Editor](formulaEditor.png)

For clarification, we have outlined different functional areas in different colors, as shown below:

![World Formula Editor (with labeled boxes)](FE_AreaInfo.png)

## <span style="color:rgb(255,0,0)">◆</span> Code Area

You can write your creative rendering code in this area.

> The option at `Language` will automatically change the language type on the plugin panel after you finish editing. This setting will be recorded in the preset file when saving a preset. The `(default)` option will not modify your language.

## <span style="color:rgb(56,148,228)">◆</span> Reference Table

This section provides some convenient code for you to copy and use. This document is currently in read-only mode and cannot be modified.

## <span style="color:rgb(243,27,243)">◆</span> Parameter Settings

This area will display the parameter panel's name and default value, as well as language settings. If you want to modify the parameter name or default value, you can click `Parameter manager` below to enter the [Parameter Manager](ParameterWindow.md).

> Parameter settings will be recorded in the preset file when saving a preset.

## <span style="color:rgb(153,204,0)">◆</span> Preset List

The dropdown list above will show all preset categories. We define presets as follows:

- A **JSON** format file with the `.pwp` suffix, placed next to the plugin, will be regarded as a **preset category**. The category name is the file name.
- A **preset category** contains several **preset data**.
- All **preset data** within a category will be listed below the dropdown menu.

## <span style="color:rgb(128,0,0)">◆</span> Preset Formula Preview

The code data of the **preset data** selected by the user in the list will be displayed here. If you are sure this preset is what you want, click the `Replace` button to replace the code in the Code Area.

> If you only want to replace the text part, you can deselect `Apply when replace` in the <span style="color:rgb(247,136,58)">Preset Parameter Setting Preview</span> area.

If you want to add the preset code before the currently edited code, you can click the `<<Top` button; to add it after, click the `Bottom>>` button.

## <span style="color:rgb(247,136,58)">◆</span> Preset Parameter Setting Preview

The parameter setting data of the **preset data** selected by the user in the list will be displayed here. If you are sure to use the current parameters, click the `Apply` button.
> The `Apply when replace` option box will determine whether to automatically apply the parameter settings on the current preset when you click the `Replace` button above.

<br>
<br>
<br>
<br>
<br>
<br>