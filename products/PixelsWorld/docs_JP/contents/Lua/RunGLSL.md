# LuaでGLSLを実行する
---

## 使用方法

```lua:glsl.lua
version3()
glsl(Your_code_string_here)
```

注意、文字列を括る際に`[==[Your_code_string_here]==]`を使用することをお勧めします。これにより、エスケープの問題が回避されます。通常、コードは以下の形式で記述する必要があります：

```lua:glsl2.lua
version3()
glsl([==[
void main(){
    outColor = vec4(uv,sin(time*10)/2+.5,1);
}
]==])
```

以下のコードを使用して、`shadertoy.com`からのコードをレンダリングできます。

```lua:shadertoy.lua
version3()
shadertoy(Your_shadertoy_code_here)
```