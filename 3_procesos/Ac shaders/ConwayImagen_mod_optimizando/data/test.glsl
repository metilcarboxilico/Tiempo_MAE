// Conway's game of life

#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER


uniform int flag;
uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
uniform sampler2D ppixels;

vec4 live = vec4(1.0,1.0,1.0,1.);
vec4 dead = vec4(0.,0.,0.,0.0);
vec4 blue = vec4(01.,.0,0.,0.);


float rand (vec2 st) {
    st=floor(st);
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}//                    vec2(0.0111,0153.1010101010111)))*   029999975.010001);}
                //   vec2(0.0111,01.1010101010111)))*0.010001);

void main( void ) { 
    vec2 position = ( gl_FragCoord.xy / resolution.xy );
    vec2 pixel = 1./resolution;
    

if(flag==0){

    gl_FragColor =vec4(vec3(rand(gl_FragCoord.xy *0.1)),1.0);
 
 
 }else {
    if (length(position-mouse) < 0.01) { //parte importante
        float rnd1 = mod(fract(sin(dot(position + time * 0.001, vec2(14.9898,78.233))) * 43758.5453), 1.0);
        if (rnd1 > 0.5) {
            gl_FragColor = live;
        } else {
            gl_FragColor = blue; //esto tengo q ver
        }
    } else {
        float sum = 0.;
        sum += texture2D(ppixels, position + pixel * vec2(-1., -1.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(-1., 0.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(-1., 1.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(1., -1.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(1., 0.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(1., 1.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(0., -1.)).g;
        sum += texture2D(ppixels, position + pixel * vec2(0., 1.)).g;
        vec4 me = texture2D(ppixels, position);

        if (me.g <= 0.1) { 
            if ((sum >= 2.9) && (sum <= 3.1)) {
                gl_FragColor = live;
            } else if (me.b > 0.004) {
                gl_FragColor = vec4(0., 0., max(me.b - 0.004, 0.25), 0.);
            } else {
                gl_FragColor = dead;
            }
        } else {
            if ((sum >= 1.9) && (sum <= 3.1)) {
                gl_FragColor = live;
            } else {
                gl_FragColor = blue;
            }
        }
    }
   }
    
}


/*

  if (rules==0) {
    if (actual<30)actual =random(160);
    else if (actual<30) actual=(suma)/8;
    else if (((suma)/8)>220) actual =random(45);
    else if (((suma)/8)>210) actual =random(255);
    else if (((suma)/8)>165) actual =random(220, 255);
    else if (((suma)/8)>140) actual =random(110, 180);
    else actual-=.4;
  } else if (rules==1) {
    if (suma<30)actual -=2;
    else if (suma/8<70) actual+=random(-50, 5);
    else if (suma/8<140) actual+=random(-25, 25);
    else if (suma/8<200) actual+=random(-15, 35);
    else if (suma/8<220) actual+=random(-5, 35);
    else actual=random(10, 255);
    ;
  } else if (rules==2) {
    if (suma<30)actual -=2;
    else if ((suma+actual)/8<70) actual+=random(-50, 5);
    else if ((suma+actual)/8<140) actual+=random(-25, 25);
    else if ((suma+actual)/8<200) actual+=random(-15, 35);
    else if ((suma+actual)/8<220) actual+=random(-5, 35);
    else actual=random(10, 255);
    ;
  } else if (rules==3) {//este frame count podria generar alguna explosion o algo segun un random? ampliar experimento
    if (frameCount%20==0) {
      if (random(1)<.001) actual=255;
    } else if (suma<30)actual -=2;
    else if ((suma+actual)/8<70) actual+=random(-50, 5);
    else if ((suma+actual)/8<140) actual+=random(-25, 25);
    else if ((suma+actual)/8<200) actual+=random(-15, 35);
    else if ((suma+actual)/8<220) actual+=random(-5, 35);
    else actual=random(10, 255);
    ;
  } else if (rules==4) {
    if (n<150)count++;
    if (ne<150)count++;
    if (e<150)count++;
    if (se<150)count++;
    if (s<150)count++;
    if (so<150)count++;
    if (o<150)count++;
    if (no<150)count++;

    if (count==3)actual=255;
    else if (count==4)actual=180;
        else if (count<=5)actual=30;
    else actual=0;
*/
