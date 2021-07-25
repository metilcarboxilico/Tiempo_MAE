//ponber lindo y pasar a fase de produccion de imgs

PShader ac;
//PShader capa;
boolean flag=false;

PGraphics pg;
PImage img, img2;
PImage salida;
PShader maskShader;
double norm =1.0/255; //estudiar el pasaje a doble?


void setup() {
  size(400, 400, P3D);    
  randomSeed(2021);
  //frameRate(10);
  pg = createGraphics(400, 400, P2D);
  pg.noSmooth();
  ac = loadShader("ac array.glsl");//ac array.glsl  //ac arrayrand.glsl
  ac.set("resolution", float(pg.width), float(pg.height));  


  //capa = loadShader("capa.glsl");
  //capa.set("resolution", float(pg.width), float(pg.height));  

  img = loadImage("img2.jpg");
  img2 = loadImage("pantallaverde.jpg");

  salida = createImage(400, 400, RGB);
  salida.copy(img, 0, 0, 400, 400, 0, 0, 400, 400);


  maskShader = loadShader("mask mod.glsl");

  //maskShader.set("mask", salida);//tiene q ser una img no funciona pg
  maskShader.set("resolution", float(img.width), float(img.height));

  //podria usar el random proppio de glsl y sincronoizarlo con el frame % modulo
  float rulset[]= {(float)(norm*30), (float)(norm*70), 
    (float)(norm*100), (float)(norm*165), 
    (float)(norm*210), (float)(norm*220)};


/*
//no logre traducirlo
  float minmax[]={  (float)(norm*0), (float)(norm*100), 
    (float)(norm*90), (float)(norm*150), 
    (float)(norm*110),(float)(norm* 180), 
    (float)(norm*220),(float)(norm* 255), 
    (float)(norm*0),(float)(norm*200), 
   (float)(norm*30), (float)(norm*250)};

*/


  /*
   
   if (actual<30)actual =random(160);
   else if (actual<30) actual=(suma)/8;
   else if (((suma)/8)>140) actual =random(110, 180);
   else if (((suma)/8)>165) actual =random(220, 255);
   else if (((suma)/8)>210) actual =random(255);
   else if (((suma)/8)>220) actual =random(45);
   
   else actual-=.4;
   
   */



   float resul[]={  (float)(norm*0.1*random(160)), 
   (float)(norm*random(180)), 
   (float)(norm*random(110, 180)), 
   (float)(norm*random(220, 255)), 
   (float)(norm*random(255)), 
   (float)(norm*random(45))};

   
     // float rulset[]= {0.02, 0.07, 0.1, 0.3, 0.5, 0.7};
  //float resul[]={0.0, -0.02, 0.04, 0.1, 0.3, -0.45};
  
//  ac.set("minmax", minmax); //
   ac.set("resul", resul);
  ac.set("rules", rulset);
  ac.set("dft", (float)(norm*-255*10));

  // ac.set("dft",(float)(-1.*norm));
  //print(norm);


  /*
  
   double norm =1.0/255; //estudiar el pasaje a doble?
   
   //podria usar el random proppio de glsl y sincronoizarlo con el frame % modulo
   float rulset[]= {(float)(norm*30), (float)(norm*50), 
   (float)(norm*140), (float)(norm*165), 
   (float)(norm*210), (float)(norm*220)};
   
   //usar el random podria requerir algunas cosas mas para usar entre 
   float resul[]={  (float)(norm*random(160)), 
   (float)(norm*random(180)), 
   (float)(norm*random(110, 180)), 
   (float)(norm*random(220, 255)), 
   (float)(norm*random(255)), 
   (float)(norm*random(45))};
   
   ac.set("dft",(float)(norm*-255*4));
   */
  /*
   float resul[]={  (float)(norm*0.1*random(160)), 
   (float)(norm*0.1*random(180)), 
   (float)(norm*0.1*random(110, 180)), 
   (float)(norm*0.1*random(220, 255)), 
   (float)(norm*0.1*random(255)), 
   (float)(norm*0.1*random(45))};
   
   */

  /*  println(norm*random(160));
   float resul[]={  (float)(norm*0.1*random(160)), 
   (float)(norm*random(180)), 
   (float)(norm*random(110, 180)), 
   (float)(norm*random(220, 255)), 
   (float)(norm*random(255)), 
   (float)(norm*random(45))};
   
   ac.set("resul", resul);
   
   */
}

float cnt=0;

void draw() {
  background(170);
  cnt +=1;
  image(salida, 0, 0, width, height);
  ac.set("time", millis()/1000.0);
  ac.set("frame", float(frameCount));

  //println("millis: ",millis()," mil div: ",millis()/1000.0 );
  //ac.set("mouse", 0, 0);  
  ac.set("iniciar", cnt);

  pg.beginDraw();
  pg.background(0);
  pg.shader(ac);
  pg.rect(0, 0, pg.width, pg.height);
  pg.endDraw();
  //salida.blend(pg, 0, 0, 400, 400, 0, 0, 400, 400, DARKEST);
  salida.mask(pg);
  //shader(ac);
  maskShader.set("time", millis()/1000.0);
  if (flag) shader(maskShader);  
  image(salida, 0, 0, width, height);
  
}


void mousePressed() {
  flag=!flag;
    salida.copy(img2, 0, 0, 400, 400, 0, 0, 400, 400);

}
void mouseReleased() {
  resetShader();
}
