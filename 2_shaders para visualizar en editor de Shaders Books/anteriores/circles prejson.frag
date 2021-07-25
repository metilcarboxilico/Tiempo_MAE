// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


/*


uniform float posX0 ;
uniform float posX1 ;
uniform float posX2 ;
uniform float posX3 ;
uniform float posX4 ;
uniform float posX5 ;

uniform float posY0 ;
uniform float posY1 ;
uniform float posY2 ;
uniform float posY3 ;
uniform float posY4 ;
uniform float posY5 ;

// alto y ancho del circulo/ elipse
uniform float w0 ;
uniform float w1 ;
uniform float w2 ;
uniform float w3 ;
uniform float w4 ;
uniform float w5 ;

uniform float h0 ;
uniform float h1 ;
uniform float h2 ;
uniform float h3 ;
uniform float h4 ;
uniform float h5 ;
    
    
uniform float s0 ;
uniform float s1 ;
uniform float s2 ;
uniform float s3 ;
uniform float s4 ;
uniform float s5 ;

uniform float cosT0 ;
uniform float cosT1 ;
uniform float cosT2 ;
uniform float cosT3 ;
uniform float cosT4 ;
uniform float cosT5 ;
    
uniform float sinT0 ;
uniform float sinT1 ;
uniform float sinT2 ;
uniform float sinT3 ;
uniform float sinT4 ;
uniform float sinT5 ;
    



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

void main() {

   vec2 st = gl_FragCoord.xy/u_resolution;
   float pct = 1.0;

vec2 uv2=st*2.-1.;

    
//esta todo muy enlazado por el tipo de 
    
float posX0 = 0.226;
float posX1 = 0.742;
float posX2 = 0.160;
float posX3 = -0.240;
float posX4 = -0.472;
float posX5 = -0.208;

float posY0 = -0.136;
float posY1 = -1.182;
float posY2 = -0.376;
float posY3 = -0.208;
float posY4 = 0.536;
float posY5 = -0.432;

// alto y ancho del circulo/ elipse
float w0 = 0.220;
float w1 = 0.420;
float w2 = 2.552;
float w3 = 1.248;
float w4 = 0.528;
float w5 = 1.200;

float h0 = 0.074;
float h1 = 4.020;
float h2 = .784;
float h3 = 1.440;
float h4 = 0.440;
float h5 = 1.120;
    
    
float s0 = 0.444;
float s1 = -0.244;
float s2 = -0.200;
float s3 = -0.744;
float s4 = 0.568;
float s5 = -0.160;

float cosT0 = 0.0;
float cosT1 = 0.0;
float cosT2 = -0.536;
float cosT3 = -0.376;
float cosT4 = 01.0;
float cosT5 = 20.0;
    
float sinT0 = 0.032;
float sinT1 = -0.368;
float sinT2 = -0.232;
float sinT3 = 01.0;
float sinT4 = -1.000;
float sinT5 = 05.0;
    
 /*
uv2 -=vec2(posX0,posY0);
uv2 /=vec2(w0,h0);
pct = length(vec2(circle(uv2,0.936-s0)));
*/
    
  	uv2=st*2.-1.;
	uv2 -=vec2(posX0*cos(noise(uv2+u_time*cosT0)),posY0*sin(noise(uv2+u_time*sinT0)));
    uv2 /=vec2(w0,h0);
	pct *= length(vec2(circle(uv2,1.-s0)));
   
    uv2=st*2.-1.;
	uv2 -=vec2(posX1*cos(noise(uv2+u_time*cosT1)),posY1*sin(noise(uv2+u_time*sinT1)));
    uv2 /=vec2(w1,h1);
	pct *= length(vec2(circle(uv2,1.-s1)));
    
    uv2=st*2.-1.;
	uv2 -=vec2(posX2*cos(noise(uv2+u_time*cosT2)),posY2*sin(noise(uv2+u_time*sinT2)));
    uv2 /=vec2(w2,h2);
	pct *= length(vec2(circle(uv2,1.-s2)));
    
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
    

    vec3 color = step(0.5,vec3(1.0-pct));
     color = vec3(1.0-pct);
     
    gl_FragColor = vec4(color,1.0);

}