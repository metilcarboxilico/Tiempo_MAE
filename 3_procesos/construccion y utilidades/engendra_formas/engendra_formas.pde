

polyRetorcido pR;
polyRetorcido polyA, polyB;


boolean flag=true;
float offX=0, offY=0;
float[] cX, cY, interX, interY, interA, interB;
int lados=7;
int diam =145;
int n=12;



/*
   el limite de calidad visual perceptible de 5607 puntos
 dentro de mi pc corre :
 en FX2D
 el limite de relentizarse por el bucle es de un array de 20000 aprox floats 
 
 en P2D
 el limite de relentizarse por el bucle es de un array de 1785 floats / 280 divisiones por punto
 
 visualmente desde 16/28 divisiones ya es interesante y lo optimo seria entre 75 y 150 
 ya 400 empieza a no tener tanto sentido
 
 se genera un desplazamiento al usar nois y no aplicar ej -100,100,
 es decir no centrar el min y el max con el negativo-positivo de una magnitud
 */

void setup() {

  size(900, 900, FX2D);

  pR= new   polyRetorcido(250, 250, 100, 45, 4, 13);
  polyA = new   polyRetorcido(170, 250, 85, 45, 5, 13);
  polyB = new   polyRetorcido(300, 500, 150, 77, 9, 16);
  //printArray(interpolar(1,10,10));
  //noStroke();

  cX=polyCos(450, diam, 45, lados);
  cY=polySin(450, diam, 45, lados);

  interA=interArray(cX, n);
  interB=interArray(cY, n);


  noStroke();
  polyA.noStrokePG();
  polyB.noStrokePG();
}

///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///
///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///


void draw() {
  background(75);

  //copio los arrays para no tener q procesarlos en cada vuelta
  interX=interA.clone();
  interY=interB.clone();


  //interX=senoArray(interX, .50, 0.5, offX);
  //interX=senoArray(interX, 4.33, 0.0146, offX);
  //interX=senoArray(interX, 12.33, 0.1022, offX*-10);
  //interY=senoArray(interY, -11.55, 0.2, offY); // esta puede ir
  //interY=cosenoArray(interY, .33, random(-1, 1), offY);
  //interY=cosenoArray(interY, 12.33, 0.1022, offY);


  //contruccion de la forma que luego converti en una clase con sus respesctivas funciones

  interX=noiseArray(interX, 0.1, -50, 50, offX); // optimas frecuncas 0.1 a .9? 
  interY=noiseArray(interY, 0.3, -50, 50, offY);
  /*
  beginShape();
   for (int i=0; i<interY.length; i++) {
   curveVertex(interX[i], interY[i]);//randomGaussian()
   } 
   endShape(CLOSE); //CLOSE
   */

  //secuencia de funciones para la reproduccion en PG de la clase polyRetorcido


  float f=map(mouseX, 0, width, .1, 5);
  float a=map(mouseY, 0, width, 1, 100);

  pR.reArray();
  polyA.reArray();
  polyB.reArray();




  polyA.cosenoPoly(25, 15, offX);
//  polyB.noisePolyY(0.3, -50, 50, -offY);
  polyB.senoPoly(12, 10, offY);


  if (flag)pR.senoPoly(a, f);
  for ( float i=0; i<1; i+=.07) pR.cosenoPoly(1.5, i, offX);


  //pR.noisePolyX( 0.1, -5, 5, offX*0.1+randomGaussian()); // optimas frecuncas 0.1 a .9? 
  //pR.noisePolyY(0.3, -50, 50, -offY);
  //pR.cosenoPolyY(12.33, 0.1022);//, offY);
  //pR.noisePolyX( 0.1, -50, 50, random(-20,20)); 
  //pR.senoPoly(.50, 0.5, offX);
  //pR.senoPolyX( 4.33, 0.0146, offX);
  //pR.senoPolyX(12.33, 0.1022, offX*-10);
  //pR.senoPoly( .33, random(-1, 1), offY);


  PGraphics fusion;
  /*
polyA.autoMaskPG();
   polyB.autoMaskPG();
   */
  polyA.backgroundPG();
  polyB.backgroundPG();
  polyA.autoMaskPG();
   polyB.autoMaskPG();

  fusion = createGraphics(500, 400);
  fusion.beginDraw();
  fusion.background(0); 
  fusion.imageMode(CENTER);
  fusion.image(polyA.displayPG(), 255, 250);
  fusion.image(polyB.displayPG(), 250, 150);
  fusion.endDraw();

  image(fusion, 100, 100);
  //  image(pR.displayPG(), 100, 100);




  offX+=.05; 
  offY+=.01;


  //noLoop();
}


void mousePressed() {
  flag=!flag;
  //redraw();
}
