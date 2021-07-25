
PGraphics degradeCentral(int W_, int h_) {
  PGraphics base;

  base = createGraphics(W_, h_, P3D);
  //escala del ruido y la resolucion general cuanto mayor menos resolucion el calculo seria: 1px/res
  float nScale= .015; // recomendrables de .1 a .001 mayor q .999 o menor q 0.001 pierde efecto
  int res=3;

  //pushStyle();
   base.noSmooth();
  base.beginDraw();
  base.noStroke();    
  for (int i=0; i<width; i+=res) {
    for (int j=0; j<height; j+=res) {

      //calculo la distancia del centro a cada punto de la pantalla para generar un degrade basico
     float distancia  =dist(i, j, width/2, height/2);
      float mapeo=map(distancia, 0, dist(0, 0, width/2, height/2), 255, 0);
      //,
      float ruido = map(noise(i*nScale, j* nScale), 0, 1, 255, 0);
      //
      //println("map ",mapeo,"; ");
      //ruido multiplicado por un float para reducir su presencia y luego el promedio 
      //fill((mapeo+ruido*.5)/2);
       base.fill((mapeo+ruido*0.4)/2); // ruido * n si ene es mayor a 1 empieza a sobre exponerse.
      //base.fill(ruido);
      base.rect(i, j, res, res);
      
    }
  }
  //popStyle();
  base.endDraw();

  //filter(BLUR,4)}

  return base;
}
/*
void degradeCentral() {
 
 //escala del ruido y la resolucion general cuanto mayor menos resolucion el calculo seria: 1px/res
 float nScale= .015; // recomendrables de .1 a .001 mayor q .999 o menor q 0.001 pierde efecto
 int res=3;
 
 
 pushStyle();
 noStroke();
 for (int i=0; i<width; i+=res) {
 for (int j=0; j<height; j+=res) {
 
 //calculo la distancia del centro a cada punto de la pantalla para generar un degrade basico
 float distancia  =dist(i, j, width/2, height/2);
 float mapeo=map(distancia, 0, dist(0, 0, width/2, height/2), 255, 0);
 //,
 float ruido = map(noise(i*nScale, j* nScale), 0, 1, 255, 0);
 
 //println("map ",mapeo,"; ");
 //ruido multiplicado por un float para reducir su presencia y luego el promedio 
 //fill((mapeo+ruido*.5)/2);
 fill((mapeo+ruido*0.4)/2); // ruido * n si ene es mayor a 1 empieza a sobre exponerse.
 //fill((ruido));
 
 rect(i, j, res, res);
 }
 }
 popStyle();
 //filter(BLUR,4);
 }
 */
