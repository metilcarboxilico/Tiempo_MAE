

/**
 
 Santiago T. Fernandez G.
 
 */


import processing.video.*;


boolean recording=false;
Movie a, b, c, d, e;

void setup() {  

  surface.setTitle("franjas video");
  surface.setResizable(true);
  surface.setLocation(100, 100);
   
  randomSeed(2021);
  
  size(1080, 720,FX2D);
  //size(1920, 1080, FX2D);
  // para reproducir video testeando los renders el que mas me rindio fue FX2D pero al utilizar mas adelante PG quedo a la par que P2D y P3D
  ///size(640, 400);


  //se que facilmente puedo cargarlos en un array list
  //pero preferi tener los videos desglosados para hacer pruebas

  a= new Movie(this, "a.mp4");
  b= new Movie(this, "b.mp4");
  a.loop();
  b.loop();
  a.frameRate(20);
  b.frameRate(10);
  a.volume(0);
  b.volume(0);



  c= new Movie(this, "c.mp4");
  c.loop();
  c.frameRate(20);
  c.volume(0);

  d= new Movie(this, "d.mp4");
  d.loop();
  d.frameRate(5);
  d.volume(0);

  e= new Movie(this, "e.mp4");
  e.loop();
  e.frameRate(7);
  e.volume(0);


}

void movieEvent(Movie m) {
  m.read();
}



int ancho;
int  aA=3, aB=15, aC=22, aD=5, aE=7; //tranquilamente podria inicializar aleatoreamente estos valores

void draw() {
  //ancho por cantidad de videos
  //la loc del set en x es x+ancho*N°del video mas W que seria el recorrido del ancho por un for
  //podria generar un obj que devuelva los anchos irregulares?

  for (int x =0; x < width; x++) {
    for (int y =0; y < height; y++) {
      // println("x: "+ x);
      ancho=0;
      /*     println("y: "+y);
       println("x: "+ x);
       println("ancho: "+ancho);*/
      //es algo obtuso pasarle esos parametros? quizas deba ser x+w en pxVideo?
      for (int w=0; w<aA; w++) set(x+w, y, pxVideo(x, y, a));
      ancho += aA;
      // println("ancho: "+ancho);
      for (int w=0; w<aB; w++) { 
        set(x+ancho+w, y, pxVideo(x+ancho+w, y, b));
        /* int temp=x+ancho+w;
         println("x: "+ x);
         println("w: "+ w);
         println("aB: "+ aB);
         println("sum: "+ temp);*/
      }
      ancho += aB;
      // println("ancho: "+ancho);
      for (int w=0; w<aC; w++) set(x+ancho+w, y, pxVideo(x+ancho+w, y, c));
      ancho += aC;
      // println("ancho: "+ancho);
      for (int w=0; w<aD; w++) set(x+ancho+w, y, pxVideo(x+ancho+w, y, d));
      ancho += aD;
      //  println("ancho: "+ancho);
      for (int w=0; w<aE; w++) set(x+ancho+w, y, pxVideo(x+ancho+w, y, e));
      ancho += aE;
      // println("ancho: "+ancho);
    }
    x += ancho;
    ancho=0;
  }


  /*  for (int x =0; x < width; x++) {
   for (int y =0; y < height; y++) {
   //  if (x+ancho%2==0)
   //    {
   for (int w=0; w<ancho; w++) set(x+w, y, pxVideo(x, y, a));
   //  } else {
   for (int w=0; w<ancho; w++) set(x+ancho+w, y, pxVideo(x, y, b));
   //  }
   }
   x+=ancho*2;
   }*/


  //versionmodificando anchos regularmente  y utilizando prixels[]
/* 
//lo resolvi con 3 bucles anidados por un tema de practicidad mental, un bucle para el ancho 
loadPixels();  
  for (int y=0; y <height-1; y++) {  //de arriba hacia abajo dibuja franjas horizontales
    for (int x=0; x<width; x++) {    //de derecha a izq cuenta los pasos desde donde dibujar  
      for (int w=0; w<ancho; w++) {  //de derecha a izq dibuja dibuja los videos por un n ancho
        //cambiando el i+= se modifica la cantidad de lineas
        
        pixels[x+w+y*width]= pxVideo(x+w, y, a);//a.pixels[x+w+y*width];
        
        //tengo q ver q onda la densidad de pixeles y como operar alli
        pixels[x+ancho+w+y*width]=pxVideo(x+ancho+w, y, b);
        pixels[x+ancho*2+w+y*width]=pxVideo(x+ancho*2+w, y, c);
        pixels[x+ancho*3+w+y*width]=pxVideo(x+ancho*3+w, y, d);
        pixels[x+ancho*4+w+y*width]=pxVideo(x+ancho*4+w, y, e);
      }
      x+=ancho*5; //sumo los anchos q agregue en el bucle anterior
    }
  }

  updatePixels();
  
  
  */

  if (recording) {
    saveFrame("output/secuencia/secuencia_####.png");
  }
}

void keyPressed() {
  if (key  =='r'||key =='R') {
    recording= !recording;
  }

  if (key=='c')  saveFrame("output/capturas/####.png");
}
