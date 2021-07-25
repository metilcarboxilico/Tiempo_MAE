// Author:
// Title:
#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	 1.-smoothstep(_radius-(_radius*0.018),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
    return dot(dist,dist)*_radius;
}

float exponentialInOut(float t) {
  return t == 0.0 || t == 1.0
    ? t
    : t < 0.5
      ? +0.5 * pow(2.0, (20.0 * t) - 10.0)
      : -0.5 * pow(2.0, 10.0 - (t * 20.0)) + 1.0;
}

float random (in vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43759.193);
}
float noise (in vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    vec2 u = f * f * (3.0 - 2.0 * f);

    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}

#define OCTAVES 8
float fbm (in vec2 st) {
    // Initial values
    float value = 0.0;
    float amplitud = 0.708;
    float frequency = .0;
    //
    // Loop of octaves
    for (int i = 0; i < OCTAVES; i++) {
        value += amplitud * noise(st);
        st *= 2.;
        amplitud *= .5;
    }
    return value;
}
void main(){
	vec2 st = gl_FragCoord.xy/u_resolution.xy;

	vec3 color = vec3(circle(st,4.708));
 	vec2 uv= st+vec2(0.486*cos(u_time),0.114*sin(u_time));
//	 uv *= st+vec2(0.350,-0.270)*exponentialInOut(sin(u_time));
	//uv = st+vec2(0.350,-0.270)*exponentialInOut(sin(u_time));
    //st.y *=.05;
     float e=  distance(st,vec2(0.770,0.110)*1.122);
    //        float e=  distance(st*sin(u_time),vec2(0.770,0.110)*1.122);

	float a=  distance(vec2(e),vec2(0.200,-0.310));
    float b=  distance(vec2(e),vec2(a));
    


    color *= vec3(circle(uv,11.508)*e);
    
   color *=  vec3(fbm(vec2(fbm(st*12.880),1.-fbm(1.-st*20.600))));
    
    color =step(0.268,color);
	
    gl_FragColor = vec4( 1.-color, 1.0 );
}
