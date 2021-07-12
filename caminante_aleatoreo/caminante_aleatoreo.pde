

/**
 
 MAE UNTREF - Introduccion a la programacion (Nayla Portas) - 2021
 segunda guia -ejercicio 6
 Santiago T. Fernandez G.
 
 
 
 me tome ciertas libertades para hacer uso de algunos conceptos no vistos 
 e ir probando alguans ideas para trabajar en el proyecto del eje tiempo
 
 en esta experimentacion 
 al presionar el mouse se oculta el caminante (pero sigue su movimiento)
 las flechas del teclado derecha/izquierda modifican la reporduccion del video
 las flechas del teclado arriba/abajo modifican los pasos que da el caminate por ciclo
 la tecla c hace una captura de pantalla
 
 
 setie la ventana para que se ejecute en la esquina superior izquierda 
 y defini la semmilla del random para tener 
 aun me falta solucionar un bug cuando me exedo del largo cuando se reproduce a maxima velocidad
 
 */


import processing.video.*;


int forWalker=1;
float velVideo=0.1;
boolean flag=true;

Movie videoHongo;
RandomVideoWalker rW;//, rW2;

void setup() {
  randomSeed(2021);
  size(640, 400);
  videoHongo= new Movie(this, "hongo.mp4");

  videoHongo.loop();
  videoHongo.frameRate(14);


  rW =new RandomVideoWalker(300, 220, videoHongo);

  surface.setTitle("walkerVideo");
  surface.setResizable(true);
  surface.setLocation(100, 100);
}

void movieEvent(Movie m) {
  m.read();
}


void draw() {
  background(30);
  if (videoHongo.time()+velVideo>=videoHongo.duration())videoHongo.jump(0);
/*  if (videoHongo.time()+velVideo<=0){ videoHongo.stop();
  videoHongo.jump(videoHongo.duration());
  videoHongo.play();
  }
  */
  //todaviaen la reversa se me complica
  videoHongo.speed(velVideo);


  for (int t=0; t<forWalker; t++) {
    rW.movimiento();
    rW.controlCantidad(10000);
    if (flag) rW.display();
  }
}

void mousePressed() {
  flag=!flag;
}

void keyPressed() {

  if (key=='c')  saveFrame("output/capturas/####.png");

  if (key == CODED) {
    if (keyCode == UP) {
      forWalker+= 1;
      if (forWalker>=20)forWalker=19;
    } else if (keyCode == DOWN) {
      forWalker-= 1;
      if (forWalker<=0) forWalker=1;
    } else if (keyCode == RIGHT) {
      velVideo+=0.1;
      if (velVideo>=2.1) velVideo=2.0;
    } else if (keyCode == LEFT) {
      velVideo-=0.1;
      if (velVideo<=-2.1) velVideo=-2.0;
    }
  }
}
