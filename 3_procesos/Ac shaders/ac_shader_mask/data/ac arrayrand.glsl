// Conway's game of life

#ifdef GL_ES
precision highp float;
#endif

#define PROCESSING_COLOR_SHADER



uniform float rules[6];
uniform float minmax[12];
uniform float dft;


uniform float frame;
uniform float time;


uniform vec2 resolution;
uniform sampler2D ppixels;
uniform float iniciar;


float get (int x,int y){ 

	vec2 uv = ( gl_FragCoord.xy / resolution );
 	uv= uv + vec2(x,y)* 1./resolution;

	if(uv.x<0.0)uv.x=1.0;
	if(uv.y<0.0)uv.y=1.0;
	if(uv.x >1.0)uv.x=0.0;
	if(uv.y >1.0)uv.y=0.0;

	return texture2D(ppixels, uv).r;
}

float rand (vec2 st) {
    return fract(sin(time+dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}

float map(float value, float min1, float max1, float min2, float max2) {
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}


void main( void ) {

	vec2 position = ( gl_FragCoord.xy / resolution.xy );
	vec2 pixel = 1./resolution;


	if (iniciar<50.0){

		float rnd1 = mod(fract(sin(dot(position + time * 0.001, vec2(14.9898,78.233))) * 43758.5453), 1.0);

		gl_FragColor = vec4(vec3(rnd1),1.);

	} else {

		float NE = get(-1,1);
		float NN = get(0,1);
		float NO = get(1,1);
		float SE = get(-1,-1);
		float SS = get(0,-1);
		float SO = get(1,-1);
		float EE = get(-1,0);
		float CC = get(0,0);
		float OO = get(1,0);
			
		float resultado=0.0;
				
		int modulo=10;
		if(mod(frame,modulo)==0){ // cooking solo en determinados frame
			
		float mult =0.0;
		float sum = NE + NN + NO + SE + SS + SO + EE + OO+ CC;//faltaria agregarle el CC

		sum /= 9.0;
		resultado = sum;
		
		bool flag = true ;

		for(int i=0; i< rules.length();i++){
			if(sum <= rules[i] ){
				resultado =map(min(1.0,abs(rand(position))),0.0,1.0, minmax[i],minmax[i+1]);
				flag = false ;
				break;
				}
		}

		if(flag){resultado += dft;}

			gl_FragColor =vec4(vec3(resultado),1.0);

		}else {
			gl_FragColor =vec4(vec3(CC),1.0);
		}
	}
}