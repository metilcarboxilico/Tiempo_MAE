

import processing.video.*;



boolean recording=true;
Movie videoHongo, a, b, c, d, e;

void setup() {
  randomSeed(2021);
  //size(1920, 1080);
  size(1080, 720,FX2D);
  //size(640, 400);

  a= new Movie(this, "a.mp4");
  b= new Movie(this, "b.mp4");
  a.loop();
  b.loop();
  
  a.frameRate(20);
  b.frameRate(2);
  a.volume(0);
  b.volume(0);

  c= new Movie(this, "c.mp4");
  c.loop();
  c.frameRate(30);
  c.speed(.2);
  c.volume(0);

  d= new Movie(this, "d.mp4");
  d.loop();
  d.frameRate(5);
  d.volume(0);

  e= new Movie(this, "e.mp4");
  e.loop();
  e.frameRate(14);
  e.volume(0);

   
  surface.setTitle("video tiras");
  surface.setResizable(true);
  surface.setLocation(100, 100);

}

void movieEvent(Movie m) {
  m.read();
}

int ancho=30;
void draw() {
  //ancho por cantidad de videos
  //la loc del set en x es x+ancho*N°del video mas W que seria el recorrido del ancho por un for

  //podria generar un obj que devuelva los anchos irregulares?


  //for (int x =0; x < width; x++) {
  //for (int y =0; y < height; y++) {

  loadPixels();  
  for (int y=0; y <height-1; y++) {  //cambiando el i+= se modifica la cantidad de lineas
    for (int x=0; x<width; x++) {
      for (int w=0; w<ancho; w++) {
        
        pixels[x+w+y*width]= pxVideo(x+w, y, a);//a.pixels[x+w+y*width];
        
        //tengo q ver q onda la densidad de pixeles y como operar alli
        pixels[x+ancho+w+y*width]=pxVideo(x+ancho+w, y, b);
        pixels[x+ancho*2+w+y*width]=pxVideo(x+ancho*2+w, y, c);
        pixels[x+ancho*3+w+y*width]=pxVideo(x+ancho*3+w, y, d);
        pixels[x+ancho*4+w+y*width]=pxVideo(x+ancho*4+w, y, e);
      }
      x+=ancho*5;
    }
  }

  updatePixels();
  /*   for (int w=0; w<ancho; w++) set(x+w, y, pxVideo(x+w, y, a));
   for (int w=0; w<ancho; w++) set(x+ancho+w, y, pxVideo(x+ancho+w, y, b));
   for (int w=0; w<ancho; w++) set(x+ancho*2+w, y, pxVideo(x+ancho*2+w, y, c));
   for (int w=0; w<ancho; w++) set(x+ancho*3+w, y, pxVideo(x+ancho*3+w, y, d));
   for (int w=0; w<ancho; w++) set(x+ancho*4+w, y, pxVideo(x+ancho*4+w, y, e));
   }
   x+=ancho*5;
   }
   */

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

  //if (videoHongo.time()+velVideo>=videoHongo.duration())videoHongo.jump(0);

  /*  if (videoHongo.time()+velVideo<=0){ videoHongo.stop();
   videoHongo.jump(videoHongo.duration());
   videoHongo.play();
   }
   */

  /*
  //todaviaen la reversa se me complica
   videoHongo.speed(velVideo);
   
   
   
   
   for (int t=0; t<forWalker; t++) {
   rW.movimiento();
   rW.controlCantidad(10000);
   if (flag) rW.display();
   }
   
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
