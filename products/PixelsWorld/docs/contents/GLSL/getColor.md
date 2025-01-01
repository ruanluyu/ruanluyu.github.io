# getColor
---
This function has two versions: **getColor(vec2)** and **getColor(int, vec2)**.

## getColor(vec2)
**Description:**

- Retrieves the color of the **input layer** at a specified position.

**Parameters:**
- vec2: UV position (range 0 to 1 in each dimension)

**Returns:**

- vec4: RGBA color (range 0 to 1 in each dimension)

## getColor(int, vec2)
**Description:**

- Retrieves the pixel of a **specific input layer** at a specified position.

**Parameters:**

- int: Layer index, -1 (or AE_INPUT_LAYER) refers to the input layer, numbers 0-9 refer to the corresponding layer parameters on the plugin panel (PW_TEMP_LAYER (Layer index-2) used in Lua rendering mode).
- vec2: UV coordinates

**Returns:**

- vec4: RGBA color

>**Note:**
>
>- In summary, ```getColor(AE_INPUT_LAYER, uv);``` and ```getColor(uv)``` are equivalent;
>- ```getColor(n, uv);``` can return pixel information of `layer[n]`.