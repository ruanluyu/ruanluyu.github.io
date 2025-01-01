# The Genesis Revelation — Poly Function

The `poly(obj)` function parses the `obj` and renders the object.

## Example of Use

> If you have used Houdini, the construction process of `obj` is similar to filling out a spreadsheet in Houdini.

Below is an example of constructing an unusual triangle `obj`.

![Result](poly_test1.png)

```lua:PolyTest1.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
dotRadius(5)
obj = {
    point = {
        {p = {0, 0, 0}, color = {0, 1, 1}},
        {p = {100, 0, 0}, color = {1, 1, 0}},
        {p = {0, 100, 0}, color = {1, 0, 1}},
        {p = {100, 100, 0}, color = {1, 0, 0}},
    },
    prim = {
        {type = "triangle", pref = {1, 2, 3}},
        {type = "line", pref = {2, 3, 3, 4, 4, 2}},
        {type = "point", pref = {2, 4}},
    }
}
poly(obj)
```

## Supported Primitives and Names

Below, we explain using `pref={1,2,3,4,5,6}` as an example.

> - `pref` means `point reference`. It refers to the sequence of point indices that the primitive will draw in.
> - A semicolon (`;`) indicates the end of drawing a primitive.

| Standard Name (type name) | Corresponding Primitive | Drawing Sequence | Full Name |
|---|---|---|---|
| points | Point | `1;2;3;4;5;6;` | points |
| pointd | Plane Point | `1;2;3;4;5;6;` | point disc |
| pointb | Sphere Point | `1;2;3;4;5;6;` | point ball |
| line | Single Line | `123456;` | single line |
| linef | Flat Line | `123456;` | line flat |
| linec | 3D Line | `123456;` | line capsule |
| linel | Loop Line | `1234561;` | line loop |
| linelf | Flat Loop Line | `1234561;` | line loop flat |
| linelc | Capsule Loop Line | `1234561;` | line loop capsule |
| lines | Multiple Lines | `12;34;56;` | lines |
| linesf | Multiple Flat Lines | `12;34;56;` | lines flat |
| linesc | Multiple Capsule Lines | `12;34;56;` | lines capsule |
| triangles | Triangle Surface | `123;456;` | triangles |
| triangleb | Bridge Constructed Triangle Surface | `123;324;345;546;` | triangle bridge |
| triangler | Radially Constructed Triangle Surface | `123;134;145;156;` | triangle radial |

## Constructing obj

We define the details of `obj` in the following steps.

- `obj` is a table.
- `obj` can include four keys: `point`, `vertex`, `prim`, `detail`.
- These keys correspond to four tables, named `pointArray`, `vertexArray`, `primArray`, and `detailList`.
- `pointArray` must exist.
- `vertexArray` is optional.
- `primArray` must exist.
- `detailList` is optional.
- Tables with the suffix `Array` can contain N sub-tables, where N can be freely defined.
- The k-th sub-table in `pointArray` is called `point[k]` or "the k-th point".
- The k-th sub-table in `vertexArray` is called `vertex[k]` or "the k-th sub-point".
- The k-th sub-table in `primArray` is called `prim[k]` or "the k-th primitive".
- `detailList` and the aforementioned points, sub-points, and primitives contain several indivisible units: key-value pairs. These keys are temporarily called `K`, and the values are `V`.
- `K` is recommended to contain only English letters, numbers, and underscores, and should not be purely numeric.
- `V` can be one-dimensional, two-dimensional, three-dimensional, four-dimensional, string, texture ID, or index group.
- For any floating precision numbers `x, y, z, w`:
  - `x` or `{x}` is a one-dimensional `V`.
  - `{x, y}` is a two-dimensional `V`.
  - `{x, y, z}` is a three-dimensional `V`.
  - `{x, y, z, w}` is a four-dimensional `V`.
  - `"Hello! PixelsWorld!"` is a string `V`.
  - When the last four characters of `K` are `"_tex"` and `V` is an integer corresponding to a valid texture, it is called a texture ID `V`.
  - For an integer sequence `a1,...,an`, `{a1,a2,a3,...,an}` is called an index group `V`.
- For each point `point[k]`, a key named `"p"` must exist to represent the point's location. Otherwise, it is an invalid point.
- For each sub-point `vertex[k]`, a key named `"pref"` with a one-dimensional `V` must exist to indicate the reference point ID. Otherwise, it is an invalid sub-point.
- For each primitive `prim[k]`, a `"type"` key must exist with a string `V` to indicate the primitive type. Additionally, `"vref"` or `"pref"` keys with an index group `V` must exist to indicate the drawing point order of the primitive.

## Overriding Priority

For a `K` with the same name, we define the following overriding priorities:

> Similar to `Houdini`

1. vertex
2. point
3. prim
4. detail

Example of use:

In the `obj` below, the `prim` contains color information (red), resulting in a solid red triangle.

![PrimColor](polyPrimColor.png)

```lua:PrimColor.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
obj = {
    point = {
        {p = {0, 0, 0}},
        {p = {100, 0, 0}},
        {p = {0, 100, 0}},
    },
    prim = {
        {type = "triangle", pref = {1, 2, 3}, color = {1, 0, 0}},
    },
}
poly(obj)
```

---

In the `obj` below, both `prim` and `point` have `color`. Since `point` has a higher priority, the triangle uses the data provided by `point`, resulting in a colorful triangle.

![PointColor](polyPointColor.png)

```lua:PointColor.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
obj = {
    point = {
        {p = {0, 0, 0}, color = {0, 1, 1}},
        {p = {100, 0, 0}, color = {1, 1, 0}},
        {p = {0, 100, 0}, color = {1, 0, 1}},
    },
    prim = {
        {type = "triangle", pref = {1, 2, 3}, color = {1, 0, 0}},
    },
}
poly(obj)
```

## Use of Vertices

Vertices (sub-points) can inherit the information of points.

![Vertex](polyVertexTest.png)

```lua:VertexColor.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
obj = {
    point = {
        {p = {0, 0, 0}},
        {p = {100, 0, 0}},
        {p = {0, 100, 0}},
        {p = {100, 100, 0}},
    },
    vertex = {
        {pref = 1, color = {1, 0, 0}},
        {pref = 2, color = {1, 0, 0}},
        {pref = 3, color = {1, 0, 0}},
        {pref = 2, color = {0, 1, 0}},
        {pref = 3, color = {0, 1, 0}},
        {pref = 4, color = {0, 1, 0}},
    },
    prim = {
        {type = "triangle", vref = {1, 2, 3, 4, 5, 6}},
    },
}
poly(obj)
```

> - `pref` indicates which point the current vertex is referencing. It stands for `Point reference`.
> - `vref` in `prim` stands for `Vertex reference`.
> - Note: In Lua tables, the first element index is 1, not 0.

---

Without using vertices, the situation turns into the one below:

![NoVertexRes](polyNoVertexTest.png)

```lua:NoVertex.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
obj = {
    point = {
        {p = {0, 0, 0}, color = {1, 0, 0}},
        {p = {100, 0, 0}, color = {1, 0, 0}},
        {p = {0, 100, 0}, color = {1, 0, 0}},
        {p = {100, 100, 0}, color = {0, 1, 0}},
    },
    prim = {
        {type = "triangle", pref = {1, 2, 3, 2, 3, 4}},
    },
}
poly(obj)
```

## Using Shaders

You can even use shader language within Poly.

![FragColorRes](polyVertexFragTest.png)

```lua:FragColor.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
obj = {
    point = {
        {p = {0, 0, 0}, myattribute = {1, 0}},
        {p = {100, 0, 0}, myattribute = {0, 1}},
        {p = {0, 100, 0}, myattribute = {0, 0}},
        {p = {100, 100, 0}, myattribute = {1, 1}},
    },
    prim = {
        {
            type = "triangle",
            pref = {1, 2, 3, 2, 3, 4},
            frag = [==[
                #define t ]==] .. tostring(time) .. [==[

                void main(){
                    outColor = vec4(mod(myattribute*10+vec2(t),1),0,1);
                }
            ]==],
        },
    },
}
poly(obj)
```
## Using Textures

> - The following `obj` will use the input layer as a texture output to the scene.
> - When the key name suffix of an integer property value has `_tex`, it is considered a texture ID.
> - By using custom shaders, multiple textures can be used simultaneously within a single primitive.
> - [More information about textures](./Texture.md)

```lua:UVTex.lua
version3()
background(0.95)
move(width/2, height/2)
dim3()
obj = {
    point = {
        {p = {0, 0, 0}, uv = {0, 0}},
        {p = {100, 0, 0}, uv = {1, 0}},
        {p = {0, 100, 0}, uv = {0, 1}},
        {p = {100, 100, 0}, uv = {1, 1}},
    },
    prim = {
        {
            type = "triangler",
            pref = {1, 2, 4, 3},
            my_tex = INPUT,
        },
    },
}
poly(obj)
```