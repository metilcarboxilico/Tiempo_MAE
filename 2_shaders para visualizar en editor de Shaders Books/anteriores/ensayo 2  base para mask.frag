// Author:
// Title:

#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;


//los metodos de raiz cuadrada son mas eficaces para fusionarse pero los de utilizar el dot y generar una circunferencia en teoria son mas economicos
//
float circle(in vec2 _st, in float _radius){
    vec2 dist = _st;//-vec2(0.350,0.700);
	return 1.-smoothstep(_radius-(_radius*0.154),
                         _radius+(_radius*-1.318),
                         dot(dist,dist)*2.436);
}
float circle(in vec2 _st, in float _radius,in float _stp1,in float _stp2){
    vec2 dist = _st-vec2(-0.980,0.870);
	return 1.-smoothstep(_radius-(_radius*0.234),
                         _radius+(_radius*-0.438),
                         dot(dist,dist)*4.0);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    st.x *= u_resolution.x/u_resolution.y;
	st *=2.;
    st -=1.;
    
    float pct = 01.0;
     vec2 toCenter = vec2(-0.380,-0.290)-st;
   	pct = length(toCenter)*1.836;
    
    vec3 color = vec3(pct);
    
    
    st+=vec2(0.000,0.0);
    color *= vec3(circle(st,1.060));
        st+=vec2(-0.380,0.520);
    color *= vec3(circle(st,1.060));
    
    //  st+=vec2(0.470,0.170);
    st*=vec2(1.9000,0.890);
   //color *= vec3(circle(st,0.9));

    gl_FragColor = vec4(color,1.0);
}




/*   float pct = 01.0;

    // a. The DISTANCE from the pixel to the center
   //pct = distance(st,vec2(0.710,0.100))/0.856;

    // b. The LENGTH of the vector
    //    from the pixel to the center
     vec2 toCenter = vec2(0.410,0.630)-st;
   		pct *= length(toCenter)*5.036;
  //  toCenter = vec2(0.040,0.670)-st;
   //  pct *= length(toCenter);
  //  toCenter = vec2(0.60,0.870*abs(sin(u_time*0.25)))-st;
  //   pct *= length(toCenter)*2.884;
   // toCenter = vec2(0.910,0.520)-st;
   //  pct *= length(toCenter*2.036);
    // c. The SQUARE ROOT of the vector
    //    from the pixel to the center
    // vec2 tC = vec2(0.200,0.240)-st;
     //pct *= sqrt(tC.x*tC.x+tC.y*tC.y)*2.348;
    */