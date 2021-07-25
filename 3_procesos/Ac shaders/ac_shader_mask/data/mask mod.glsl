#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
//uniform sampler2D mask;
uniform float time;
uniform vec2 resolution;

uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;




#define pi 3.14159235659

float random (vec2 st) {

    st = floor(st);
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123); 
}
vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}
// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

float noise2(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random2(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random2(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random2(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random2(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
}

// Some useful functions
vec3 mod289(vec3 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec2 mod289(vec2 x) { return x - floor(x * (1.0 / 289.0)) * 289.0; }
vec3 permute(vec3 x) { return mod289(((x*34.0)+1.0)*x); }

//
// Description : GLSL 2D simplex noise function
//      Author : Ian McEwan, Ashima Arts
//  Maintainer : ijm
//     Lastmod : 20110822 (ijm)
//     License :
//  Copyright (C) 2011 Ashima Arts. All rights reserved.
//  Distributed under the MIT License. See LICENSE file.
//  https://github.com/ashima/webgl-noise
//
float snoise(vec2 v) {

    // Precompute values for skewed triangular grid
    const vec4 C = vec4(0.211324865405187,
                        // (3.0-sqrt(3.0))/6.0
                        0.366025403784439,
                        // 0.5*(sqrt(3.0)-1.0)
                        -0.577350269189626,
                        // -1.0 + 2.0 * C.x
                        0.024390243902439);
                        // 1.0 / 41.0

    // First corner (x0)
    vec2 i  = floor(v + dot(v, C.yy));
    vec2 x0 = v - i + dot(i, C.xx);

    // Other two corners (x1, x2)
    vec2 i1 = vec2(0.0);
    i1 = (x0.x > x0.y)? vec2(1.0, 0.0):vec2(0.0, 1.0);
    vec2 x1 = x0.xy + C.xx - i1;
    vec2 x2 = x0.xy + C.zz;

    // Do some permutations to avoid
    // truncation effects in permutation
    i = mod289(i);
    vec3 p = permute(
            permute( i.y + vec3(0.0, i1.y, 1.0))
                + i.x + vec3(0.0, i1.x, 1.0 ));

    vec3 m = max(0.5 - vec3(
                        dot(x0,x0),
                        dot(x1,x1),
                        dot(x2,x2)
                        ), 0.0);

    m = m*m ;
    m = m*m ;

    // Gradients:
    //  41 pts uniformly over a line, mapped onto a diamond
    //  The ring size 17*17 = 289 is close to a multiple
    //      of 41 (41*7 = 287)

    vec3 x = 2.0 * fract(p * C.www) - 1.0;
    vec3 h = abs(x) - 0.5;
    vec3 ox = floor(x + 0.5);
    vec3 a0 = x - ox;

    // Normalise gradients implicitly by scaling m
    // Approximation of: m *= inversesqrt(a0*a0 + h*h);
    m *= 1.79284291400159 - 0.85373472095314 * (a0*a0+h*h);

    // Compute final noise value at P
    vec3 g = vec3(0.0);
    g.x  = a0.x  * x0.x  + h.x  * x0.y;
    g.yz = a0.yz * vec2(x1.x,x2.x) + h.yz * vec2(x1.y,x2.y);
    return 130.0 * dot(m, g);
}
float voronoi(vec2 uv){
// Scale
    uv *= 10.;
    // Tile the space
    vec2 i_st = floor(uv);
    vec2 f_st = fract(uv);
    float m_dist = 1.0;  // minimun distance
    for (int y= -1; y <= 1; y++) {
        for (int x= -1; x <= 1; x++) {
            vec2 neighbor = vec2(float(x),float(y));
            vec2 point = random2(i_st + neighbor);
            point = 0.5 + 0.5*sin(time + 6.2831*point);
            vec2 diff = neighbor + point - f_st;
            float dist = length(diff);
            m_dist = min(m_dist, dist);
        }
    }
    
    return m_dist; 
}

vec3 voronoi2( in vec2 x ) {
    vec2 n = floor(x);
    vec2 f = fract(x);

    // first pass: regular voronoi
    vec2 mg, mr;
    float md = 8.0;
    for (int j= -1; j <= 1; j++) {
        for (int i= -1; i <= 1; i++) {
            vec2 g = vec2(float(i),float(j));
            vec2 o = random2( n + g );
            o = 0.5 + 0.5*sin( time + 6.2831*o );

            vec2 r = g + o - f;
            float d = dot(r,r);

            if( d<md ) {
                md = d;
                mr = r;
                mg = g;
            }
        }
    }

    // second pass: distance to borders
    md = 8.0;
    for (int j= -2; j <= 2; j++) {
        for (int i= -2; i <= 2; i++) {
            vec2 g = mg + vec2(float(i),float(j));
            vec2 o = random2( n + g );
            o = 0.5 + 0.5*sin( time + 6.2831*o );

            vec2 r = g + o - f;

            if ( dot(mr-r,mr-r)>0.00001 ) {
                md = min(md, dot( 0.5*(mr+r), normalize(r-mr) ));
            }
        }
    }
    return vec3(md, mr);
}

#define OCTAVES 6
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitude = .5;
    float frequency = 0.;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitude * noise(st);
        st *= 2.;
        amplitude *= .5;
    }
    return value;
}

// Ridged multifractal
// See "Texturing & Modeling, A Procedural Approach", Chapter 12
float ridge(float h, float offset) {
    h = abs(h);     // create creases
    h = offset - h; // invert so creases are at top
    h = h * h;      // sharpen creases
    return h;
}

float ridgedMF(vec2 p) {
    float lacunarity = 2.0;
    float gain = 0.5;
    float offset = 0.9;

    float sum = 0.0;
    float freq = 1.0, amp = 0.5;
    float prev = 1.0;
    for(int i=0; i < OCTAVES; i++) {
        float n = ridge(snoise(p*freq), offset);
        sum += n*amp;
        sum += n*amp*prev;  // scale by previous octave
        prev = n;
        freq *= lacunarity;
        amp *= gain;
    }
    return sum;
}



vec2 rotate2d(vec2 _st, float _angle){
  _st -=0.5;
  _st = mat2(cos(_angle),-sin(_angle),
  sin(_angle),cos(_angle))*_st;
	_st +=0.5;
	return _st;
}



void main() {

    vec2 uv = gl_FragCoord.xy /resolution;
    uv.x*= resolution.x/resolution.y;
    
/*
	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec2 pixel = 1./resolution;


		float rnd1 = mod(fract(sin(dot(position  + time* 0.001, vec2(14.9898,78.233))) * 43758.5453), 1.0);

    
   vec2 uv = gl_FragCoord.xy / resolution;
    uv.x*= resolution.x/resolution.y;
    vec2 p = vec2(0.5) - uv;
    float r = length(p);
    float a = atan(p.x,p.y);
    */
    
    /*
    vec2 uv2 = vec2(uv.x*1.0,uv.y*1.);
    
    float e = random(uv2);
          e = noise(uv2);
         e = noise2(uv2);
        // e = snoise(uv2);
         e = voronoi(uv2);
       e = fbm(uv2);
        e = fbm(uv*5.+fbm(uv*20.+fbm(uv2-time)+time*8.01));
      //e = ridgedMF(vec2(ridgedMF(uv2)-time*0.2));
      
      
     e = ridgedMF(vec2(e));
*/
vec2 uv2 = vec2(uv.x*1.0,uv.y*1.);
    
    float e = random(uv2);
          e = noise(uv2);
         e = noise2(uv2);
        // e = snoise(uv2);
       //  e = voronoi(uv2);
       e = fbm(uv2);
       e = fbm(vec2(e));
        //e = fbm(uv*5.+fbm(uv*20.+fbm(uv2-time)+time*0.01));
      //e = ridgedMF(vec2(ridgedMF(uv2)-time*0.2));
      
      
     e = ridgedMF(vec2(e));
    
   vec2 uvrot = rotate2d(uv2,89.376);
    
    float e2 = fbm(uvrot);
       e2 = fbm(vec2(e2));
        //e = fbm(uv*5.+fbm(uv*20.+fbm(uv2-time)+time*0.01));
      //e = ridgedMF(vec2(ridgedMF(uv2)-time*0.2));
      
      
     e2 = ridgedMF(vec2(e2));
    
    
    e =mix(e,e2,0.572);
    
/*


vec4 fin = vec4(vec3(e),1.0);



  vec4 texColor = texture2D(texture, vertTexCoord.st).rgba;
  vec4 maskColor = texture2D(mask, vec2(vertTexCoord.s, 1.0 - vertTexCoord.t)).rgba;
  gl_FragColor = mix(texColor,vec4(0, 0, 0, 0),  1.0 - fin.r);  

  //  gl_FragColor = mix(texColor, vec4(0, 0, 0, 0), 1.0 - maskColor.r);  
*/


   vec2 st = gl_FragCoord.xy/resolution;
   float pct = 0.0;

    // a. The DISTANCE from the pixel to the center
    pct = distance(st,vec2(0.710,0.100))/0.856;

    // b. The LENGTH of the vector
    //    from the pixel to the center
     vec2 toCenter = vec2(0.410,0.630)-st;
     pct *= length(toCenter)*5.036;
    toCenter = vec2(0.040,0.670)-st;
     pct *= length(toCenter);
    toCenter = vec2(0.60,0.870*abs(sin(time*0.25)))-st;
     pct *= length(toCenter)*2.884;
    toCenter = vec2(0.850,0.600)-st;
     pct *= length(toCenter*2.036);
    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
     vec2 tC = vec2(0.200,0.240)-st;
     pct *= sqrt(tC.x*tC.x+tC.y*tC.y)*2.348;


    //test de base para la mascara
   /// e= pct;
    
    vec3 color = vec3(pct);
    
    //mezcla
    e= e-color.r;
     e= step(0.076,e);
     
     
     
   // gl_FragColor = vec4(vec3(e),1.0);

//esto quizas deba ajustarlo mejor y comprewnderlo en teoria funciona mezclando pero quiciera q solo modifique la trasparencia multiplicando 
//el canal alfa, si es para q 0 de col sea 0 de alfa y si el ac tiene alfa lo deje intacto.
vec4 fin = vec4(vec3(e),1.0);

  vec4 texColor = texture2D(texture, vertTexCoord.st).rgba;
  //vec4 maskColor = texture2D(mask, vec2(vertTexCoord.s, 1.0 - vertTexCoord.t)).rgba; //esto no se usa x ahora
  gl_FragColor = mix(texColor,vec4(0, 0, 0, 0),  1.0 - fin.r);  

}