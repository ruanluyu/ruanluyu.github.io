uniform vec2 resolution;
uniform vec4 mouse;
uniform float time;

uniform sampler2D milai;
uniform sampler2D noise_texture;

vec2 hash2( float n )
{
    return fract(sin(vec2(n,n+1.0))*vec2(13.5453123,31.1459123));
}

float rand(vec2 co){
    return texture2D(noise_texture,co).r*1.2;
}


float noise( in vec2 x )
{
    vec2 p = floor(x);
    vec2 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float a = rand((p+vec2(0.5,0.5))/500.);
    float b = rand((p+vec2(1.5,0.5))/500.);
    float c = rand((p+vec2(0.5,1.5))/500.);
    float d = rand((p+vec2(1.5,1.5))/500.);
    return mix(mix( a, b,f.x), mix( c, d,f.x),f.y);
}

const mat2 mtx = mat2( 0.80,  0.60, -0.60,  0.80 );

float fbm( vec2 p )
{
    float f = 0.0;

    f += 0.500000*noise( p ); p = mtx*p*2.02;
    f += 0.250000*noise( p ); p = mtx*p*2.03;
    f += 0.125000*noise( p ); p = mtx*p*2.01;
    f += 0.062500*noise( p ); p = mtx*p*2.04;
    f += 0.031250*noise( p ); p = mtx*p*2.01;
    f += 0.015625*noise( p );

    return f/0.96875;
}

// -----------------------------------------------------------------------

float pattern(in vec2 p, in float t, in vec2 uv, out vec2 q, out vec2 r, out vec2 g)
{
    q = vec2(fbm(p), fbm(p + vec2(10, 1.3)));
    
    float s = dot(uv.x + 0.5, uv.y + 0.5);
    r = vec2(fbm(p + 4.0 * q + vec2(t) + vec2(1.7, 9.2)), fbm(p + 4.0 * q + vec2(t) + vec2(8.3, 2.8)));
    g = vec2(fbm(p + 2.0 * r + vec2(t * 20.0) + vec2(2, 6)), fbm(p + 2.0 * r + vec2(t * 10.0) + vec2(5, 3)));
    return fbm(p + 5.5 * g + vec2(-t * 7.0));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/resolution.xy;
    
    // noise
    vec2 q, r, g;
    float noise = pattern(fragCoord * vec2(.004), time * 0.007, uv, q, r, g);
    
    // base color based on main noise
    vec3 col = mix(vec3(0.1, 0.4, 0.4), vec3(0.5, 0.7, 0.0), smoothstep(0.0, 1.0, noise));
    
    // other lower-octave colors and mixes
    col = mix(col, vec3(0.35, 0.0, 0.1), dot(q, q) * 1.0);
    col = mix(col, vec3(0, 0.2, 1), 0.2*g.y*g.y);
    col = mix(col, vec3(.3, 0, 0), smoothstep(0.0, .6, 0.6*r.g*r.g));
    col = mix(col, vec3(0, .5, 0), 0.1*g.x);
    
    // some dark outlines/contrast and different steps
    col = mix(col, vec3(0), smoothstep(0.3, 0.5, noise) * smoothstep(0.5, 0.3, noise));
    col = mix(col, vec3(0), smoothstep(0.7, 0.8, noise) * smoothstep(0.8, 0.7, noise));
    
    // contrast
    col *= noise*2.0;
    
    // vignette
    col *= 0.70 + 0.65 * sqrt(70.0*uv.x*uv.y*(1.0-uv.x)*(1.0-uv.y));
    
    // Output to screen
    float dist_t = sin(.1*time) + cos(.2*time)*.3+sin(.4*time)*.1;
    vec4 mc = texture2D(milai,col.rg*0.1*dist_t+uv);
    float ra = rand(vec2(floor(time/0.2)*0.2));

    fragColor.a =1.0;
    vec3 c1 = col.rgb;
    vec3 c2 = (col.rrr+col.ggg+col.bbb)/3.0;
    float st = sin(time);
    fragColor.rgb = st*c1+(1.0-st)*c2;

    if(mc.a>.0){
        if(mc.r>.0){
            fragColor.rgb += mc.rgb;
        }else{
            fragColor.rgb += vec3(0.24);
        }
    }
}

void main()	{
    mainImage( gl_FragColor, gl_FragCoord.xy);
}
