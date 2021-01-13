# LuaでGLSLを実行する
---

## 使用例

```lua:glsl.lua
version3()
glsl(Your_code_string_here)
```

注意：`[==[Your_code_string_here]==]`を用いてコードを囲むことがお勧めです。なぜなら、この囲み方は`\n`のような変換を阻止できるからです。


```lua:glsl2.lua
version3()
glsl([==[
void main(){
    outColor = vec4(uv,sin(time*10)/2+.5,1);
}
]==])
```

`shadertoy.com`からのコードもレンダーできます。

```lua:shadertoy.lua
version3()
shadertoy(Your_shadertoy_code_here)
```