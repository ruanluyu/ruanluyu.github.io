# Writing Code Locally

If you prefer not to use the built-in editor of Pixel World, you can create a `txt` document locally and import it into Pixel World using the following code.

> Do not place the code file on the system drive (C:\ drive).

```lua:loadTxt.lua
version3()
runFile([[d:\mycode.txt]]) -- Replace with your path
```

> - The reason for using `[[d:\mycode.txt]]` instead of `"d:\mycode.txt"` is that the latter will cause the `\` to be escaped.
> - You can use any file extension (`*.lua, *.code, *.magic`) as long as the file content is text.

If you want to place the code next to the project files, you can use the following code.

```lua:loadTxt.lua
version3()
runFile(projectFolder .. [[mycode.txt]]) -- Replace with your file name
```

> Note that using `projectFolder` requires your project to be saved locally.

## It's Not Over! Don't Forget to Refresh the Code

![RerenderClick](RerenderLOGO.png)

After typing and saving your code locally, Pixel World will not immediately respond in the scene. You need to press **Ctrl + Alt** and click on the LOGO image on the plugin panel with your mouse. Pixel World will then read the new code you've written.

> The LOGO image here rotates randomly according to a certain probability distribution. To cater to artists who enjoy collecting, we have designed many exquisite LOGOs to display here.