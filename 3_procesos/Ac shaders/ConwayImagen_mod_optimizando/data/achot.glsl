#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER

uniform sampler2D textura;
uniform vec2 resolution;
uniform float time;
//uniform vec2 mouse;
uniform int mouse;
// Example Pixel Shader

// uniform float exampleUniform;
//uniform float sRull[9];
//uniform float bRull[9];
uniform float frame;
//uniform float rule;



float get (int x,int y){ // luego renombrarla? vecinos?
	//return getVec4(x,y).r; //por ahi no tiene sentido 
		vec2 uv = ( gl_FragCoord.xy / resolution.xy );
 		uv= uv.st + vec2(x,y)* 1./resolution.xy;

//vec2 uv= vUV.st + vec2(x,y)*uTD2DInfos[0].res.xy;
		/* funcion q calcula 1/resX y 1/resY (es decir las normales)
		ultiplicandolas por un n pasos en x e y, simultaneamente
			y las suma a la posiscion que toque calcular (vUV.st)
			esto sirve para calcular a los ve cnos
		*/
	return texture2D(textura, uv.st).r;
}
/*
vec4 getVec4 (int x,int y){ // luego renombrarla? vecinos?

	vec2 uv= vUV.st + vec2(x,y)*uTD2DInfos[0].res.xy;
		// funcion q calcula 1/resX y 1/resY (es decir las normales)
		//ultiplicandolas por un n pasos en x e y, simultaneamente
		//	y las suma a la posiscion que toque calcular (vUV.st)
		//	esto sirve para calcular a los vecnos
		
	return texture(sTD2DInputs[0], uv.st);

}
*/
float random (vec2 st) {
    return fract(sin(dot(st.xy,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}
//---------------------------------------------------------

//---------------------------------------------------------
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


out vec4 fragColor;
//nose si lo tengo invertido
const float rulset[8] = float[8](0.0, 1.0, 1.0, 1.0,
								1.0, 0.0, 0.0, 0.0);
void main()
{

	if (mouse==1.0) {
		
		vec2 uv = ( gl_FragCoord.xy / resolution.xy );
			gl_FragColor = vec4(vec3(random(uv+time*0.2)),1.0);
	
	

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
	//luego float
	
	float resultado=0.0;
		
		
	int modulo=3;
	if(mod(frame,modulo)==0){ // cooking solo en determinados frame
	
	
	float suma = NE + NN + NO + SE + SS + SO + EE + OO+ CC;//faltaria agregarle el CC
	suma /= 9.0;

	resultado = suma;
	
	// un for por el lentgh recorriendo dos array?? 
	//oblicatoriamente un brek para saltar si la condicion se cumplr 
	// entre que numeros [x-y] o (x&&)   -0 uno que sume/reste  o q setee?
	// o una logica escalonada si es menor que  mayor q 
	//agregarle tambien el random y = clamp(x,0.2,0.4); 
	if(suma <= 0.02 ){resultado=0.0;}
	else if(suma <=0.07 ){resultado-=0.02;}
	else if(suma <=0.1 ){resultado+=0.04;}
	else if(suma  <=0.3 ){resultado+=0.1;}	
	else if(suma  <=0.5 ){resultado+=0.3;}	
	else if(suma  >0.5 ){resultado-=0.1;}	
		
		
		
	/*
	1f ( CC ==1.0){ 	 //vive ,esta forma me puede ayudar a complejizarlos
			if(sRull[suma]==1.0){
				resultado=1.0;
			}else{
				resultado=0.0;
			}
					/*if(suma == 2||suma==3){
						resultado=1.0;
					}else{
						resultado=0.0;
					}
				
		}else{
			if(bRull[suma]==1.0){
				resultado=1.0;
			}else{ 
				resultado=0.0;
			}
					/*if(suma==3){
							resultado=1.0;
						}else{
						resultado=0.0;
						}
				}*/
	
	}else { resultado = CC;}
			//para utomatas de calor con reglas mixtas 
	


	
	
	// vec4 color = texture(sTD2DInputs[0], vUV.st);
	
	vec4 color = vec4(vec3(resultado),1.0);
	gl_FragColor = color;
}
}
