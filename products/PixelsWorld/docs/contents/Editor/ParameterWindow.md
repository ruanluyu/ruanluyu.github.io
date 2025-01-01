# Parameter Editor
-------
Launch the parameter editor by clicking the `Parameter manager` button on the [World Rule Editor](ScriptWindow.md). Once opened, it appears as shown below:
![Parameter Editor](PM_Review.png)

## Rules
Enter the name in the long box and the default value (decimal) in the short box.

The `Clear names` button clears the names in each area. The `Clear all names` button at the bottom clears the names in all areas.

The `Reset names` button resets each area's name to its default name, while the `Reset all names` button at the bottom resets the names in all areas to their default.

The `Reset value` button resets each area's values, and the `Reset all names` button at the bottom also resets all areas' values.

> Note: The range for point and 3dpoint should be `0~1`. For example, on a `1280x720` layer, when using `0.5, 0.5` as the default value for point, PixelsWorld will automatically convert it to `640x360` on the plugin panel UI's point control.

## Parameter Name Encoding Language

PixelsWorld supports UTF-8 and local encoding, meaning parameter names theoretically support most Unicode characters. However, due to encoding support issues in After Effects, the name data in presets might display unsupported characters as `?` (question marks) on different system regions (this is not a glitch).

> - If you are an individual artist, you can name parameters in any language.
> - If you are part of a team, **especially one involved in international art exchanges**, we recommend using parameter names composed of visible characters from <span style="color:rgb(255,0,0)">[ASCII](https://en.wikipedia.org/wiki/ASCII) (generally consisting of English letters, numbers, and underscores)</span>.

<br>
<br>
<br>
<br>
<br>
<br>