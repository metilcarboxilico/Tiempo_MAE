// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


/*


uniformfloat posX0 ;
uniformfloat posX1 ;
uniformfloat posX2 ;
uniformfloat posX3 ;
uniformfloat posX4 ;
uniformfloat posX5 ;

uniformfloat posY0 ;
uniformfloat posY1 ;
uniformfloat posY2 ;
uniformfloat posY3 ;
uniformfloat posY4 ;
uniformfloat posY5 ;

// alto y ancho del circulo/ elipse
uniformfloat w0 ;
uniformfloat w1 ;
uniformfloat w2 ;
uniformfloat w3 ;
uniformfloat w4 ;
uniformfloat w5 ;

uniformfloat h0 ;
uniformfloat h1 ;
uniformfloat h2 ;
uniformfloat h3 ;
uniformfloat h4 ;
uniformfloat h5 ;
    
    
uniformfloat s0 ;
uniformfloat s1 ;
uniformfloat s2 ;
uniformfloat s3 ;
uniformfloat s4 ;
uniformfloat s5 ;

uniformfloat cosT0 ;
uniformfloat cosT1 ;
uniformfloat cosT2 ;
uniformfloat cosT3 ;
uniformfloat cosT4 ;
uniformfloat cosT5 ;
    
uniformfloat sinT0 ;
uniformfloat sinT1 ;
uniformfloat sinT2 ;
uniformfloat sinT3 ;
uniformfloat sinT4 ;
uniformfloat sinT5 ;
    



*/


float circle(in vec2 _st, in float _radius){
    vec2 dist = _st;
	return   dot(dist,dist)*_radius;
}



float random (vec2 st) {

    st = floor(st);
    return fract(sin(dot(st.xy,
                         vec2(0.680,-0.190)))*
        43758.641); 
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


/*
float random (vec2 st) {

    st = floor(st);
    return fract(sin(dot(st.xy,
                         vec2(12.9895,78.293)))*
        4376.545353); 
}
*/

vec2 random2(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43758.5453123);
}
// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd


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
            point = 0.5 + 0.5*sin(u_time + 6.2831*point);
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
            o = 0.5 + 0.5*sin( u_time + 6.2831*o );

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
            o = 0.5 + 0.5*sin(u_time + 6.2831*o );

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



vec2 scale(vec2 uv, vec2 _sc){
  uv -=vec2(0.5);
       
     uv = uv*  mat2(_sc.x,0.0,
                        0.0,_sc.y);

       uv +=vec2(0.5);
return uv;
}



void main() {

   vec2 st = gl_FragCoord.xy/u_resolution;
   float pct = 1.0;
vec2 uv=st;
vec2 uv2=st*2.-1.;

    
    
    
    uv2 = vec2(uv.x*1.0,uv.y*1.);
    
    float e = random(uv2);
           // e= noise(uv2);
         //e = noise2(uv2);
         //e = snoise(uv2);
       //  e = voronoi(uv2);
       e = fbm(uv2);
      // e = fbm(vec2(e));
        //e = fbm(uv*5.+fbm(uv*20.+fbm(uv2-time)+time*0.01));
      //e = ridgedMF(vec2(ridgedMF(uv2)-time*0.2));
      
      
     e = ridgedMF(vec2(e));
    
   vec2 uvMod = uv2;
    /*
	float rotate =1.192;
    
vec2 scales  = vec2(-0.980,-0.860);
    
    if(rotate != 0.0) uvMod = rotate2d(uvMod,rotate);
    if(scales.x != 0.0 ||scales.x != 1.0) uvMod = scale(uvMod,scales);
*/
    
    float e2 = fbm(uvMod);

       e2 = fbm(vec2(e2));
        //e = fbm(uv*5.+fbm(uv*20.+fbm(uv2-time)+time*0.01));
      //e = ridgedMF(vec2(ridgedMF(uv2)-u_time*0.2));
      
      
     e2 = ridgedMF(vec2(e2));
    
    
    e =mix(e,e2,0.5);
    
    
    
    
    
    
    
//esta todo muy enlazado por el tipo de 
    
float posX0 = 0.130;
float posX1 = -0.536;
float posX2 = 0.848;/*
float posX3 = -0.240;
float posX4 = -0.472;
float posX5 = -0.208;
*/
float posY0 = -0.192;
float posY1 = -0.600;
float posY2 = 0.928;/*
float posY3 = -0.208;
float posY4 = 0.536;
float posY5 = -0.432;
*/
// alto y ancho del circulo/ elipse
float w0 = 0.052;
float w1 = -0.208;
float w2 = -0.784;/*
float w3 = 1.248;
float w4 = 0.528;
float w5 = 1.200;
*/
float h0 = .514;
float h1 = -0.236;
float h2 = -0.896;/*
float h3 = 1.440;
float h4 = 0.440;
float h5 = 1.120;
    */

float s0 = 1.032;
float s1 = 1.0;
float s2 = 2.496;
    /*
float s3 = -0.744;
float s4 = 0.568;
float s5 = -0.160;
*/
float cosT0 = 0.136;
float cosT1 = 0.328;
float cosT2 = -01.184;/*
float cosT3 = -0.376;
float cosT4 = 01.0;
float cosT5 = 20.0;
    */
float sinT0 = 1.120;
float sinT1 = 0.408;
float sinT2 = 0.456;
/*float sinT3 = 01.0;
float sinT4 = -1.000;
float sinT5 = 05.0;
    */
    

    
    vec2 uv3 =(st*2.-1.)* vec2(1.-w0,1.-h0);
    vec2 pos;//= vec2(posX0+cos(noise(uv2+u_time*cosT0)),posY0+sin(noise(uv2+u_time*sinT0)));
    pos =vec2(posX0,posY0);
    pos *=vec2(cos(s0*noise((st*2.-1.)+u_time*cosT0)),sin(s0*noise((st*2.-1.)+u_time*sinT0)));
    vec2 toCenter = pos-uv3;
    pct = length(toCenter);
    
    
    
      uv3 =(st*2.-1.)* vec2(1.-w1,1.-h1);
    // pos= vec2(posX0+cos(noise(uv2+u_time*cosT0)),posY0+sin(noise(uv2+u_time*sinT0)));
    pos =vec2(posX1,posY1);
  pos *=vec2(cos(s1*noise(uv3+u_time*cosT1)),sin(s1*noise(uv3+u_time*sinT1)));
     toCenter = pos-uv3;
    pct *= length(toCenter);
    
    
    uv3 =(st*2.-1.)* vec2(1.-w2,1.-h2);
    // pos= vec2(posX0+cos(noise(uv2+u_time*cosT0)),posY0+sin(noise(uv2+u_time*sinT0)));
    pos =vec2(posX2,posY2);
    pos *=vec2(cos(s2*noise(uv3+u_time*cosT2)),sin(s2*noise(uv3+u_time*sinT2)));
     toCenter = pos-uv3;
    pct *= length(toCenter);
    
    /*
    uv2=st*2.-1.;
	uv2 -=vec2(posX1*cos(noise(uv2+u_time*cosT1)),posY1*sin(noise(uv2+u_time*sinT1)));
    uv2 /=vec2(w1,h1);*/
	//pct *= length(vec2(circle(uv2,1.-s1)))+0.1;
    //pct *= length(uv2*s1);
	//pct *= distance(uv2,vec2(puv2));
    
    /*
    uv2=st*2.-1.;
	puv2 -=vec2(posX2*cos(noise(uv2+u_time*cosT2)),posY2*sin(noise(uv2+u_time*sinT2)));
    uv2 /=vec2(w2,h2);
    pct *= distance(uv2,vec2(puv2));
*/
	//pct *= length(vec2(circle(uv2,1.-s2)));
     //pct *= length(uv2*s2);

   /* 
    uv2=st*2.-1.;
	uv2 -=vec2(posX3*cos(noise(uv2+u_time*cosT3)),posY3*sin(noise(uv2+u_time*sinT3)));
    uv2 /=vec2(w3,h3);
	pct *= length(vec2(circle(uv2,1.-s3)));
    
    uv2=st*2.-1.;
	uv2 -=vec2(posX4*cos(noise(uv2+u_time*cosT4)),posY4*sin(noise(uv2+u_time*sinT4)));
    uv2 /=vec2(w4,h4);
	pct *= length(vec2(circle(uv2,1.-s4)));
    
    uv2=st*2.-1.;
	uv2 -=vec2(posX5*cos(noise(uv2+u_time*cosT5)),posY4*sin(noise(uv2+u_time*sinT5)));
    uv2 /=vec2(w5,h5);
	pct *= length(vec2(circle(uv2,1.-s5)));
    */
//uv2=st*2.-1.;
//pct *= length(vec2(circle(uv2,3.112-s0)));
    
    
    vec3 color;
     //color = smoothstep(0.272,0.700,vec3(1.0-pct));
    
     //color = vec3(1.008-pct);
    
     color = vec3(1.-pct);
    
    //mezcla
    e *= color.x;
    //e = step(0.296,e);
     
  color =vec3(e);
      color = step(0.10 ,color);
    
   // gl_FragColor = vec4(vec3(e),1.0);

//esto quizas deba ajustarlo mejor y comprewnderlo en teoria funciona mezclando pero quiciera q solo modifique la trasparencia multiplicando 
//el canal alfa, si es para q 0 de col sea 0 de alfa y si el ac tiene alfa lo deje intacto.
vec4 fin = vec4(vec3(e),1.0);
     
    gl_FragColor = vec4(color,1.0);

}