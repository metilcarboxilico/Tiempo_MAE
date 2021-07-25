
import processing.video.*;


//definición 
AutomataCelular automata;
Movie a;//, b, c, d;

boolean recording=false, flag =true;

void setup() {
  size( 1920, 1080, FX2D );
  surface.setTitle("AC con video");
  surface.setResizable(true);
  surface.setLocation(100, 100);

  //se inicializa pasando las columnas y filas
  //frameRate(12);
  noStroke();

  a= new Movie(this, "a.mp4");

  a.loop();
  // a.frameRate(2);
  a.speed(.2);
  a.volume(0);
  a.read();

  int mW = a.width; 
  int mH = a.height;

  println("width: " + mW +" " + "Height: " + mH); 
    a.loadPixels();
  println("antes del rezise px: "+ int(1200)+int(700)*a.pixelWidth);
  a.resize(mW, mH); // no se donde cazzo esta el problema 
  //a.width=a.width/2;
  //a.height=a.height/2;
    println("despues del rezise px: "+ int(1200)+int(700)*a.pixelWidth);

  println("width: " + mW +" " + "Height: " + mH); 

  // AC : x/y/w/h/resolucion (en enteros basicamente cant px/res)
  automata = new AutomataCelular(0, 0, 1200, 700, 1 );
}

//provisoriamente a la vista para evaluar como se capturan los px
color pxVideo(float x_, float y_, Movie video_) {
  video_.loadPixels();
  return   video_.pixels[int(x_)+int(y_)*video_.pixelWidth];//video_.get(int(x_), int(y_));//
  //video_.get(x_, y_);
}
/*
  void localizar(float x, float y, float ancho, float alto) {
 this.x = x + ancho;
 this.y = y + alto;
 this.ancho = ancho;
 this.alto = alto;
 }
 */


void movieEvent(Movie m) {
  m.read();
}


void draw() {



  background(0);// pensar mejor el fondo

  automata.actualizar();
  automata.dibujar();
  //filter(BLUR, 2);

  if (recording) saveFrame("output/secuencia/secuencia_####.png");
}

void keyPressed() {
  if ( key == ' ' )  automata.iniciar();
  if (key  =='r'||key =='R')  recording= !recording;
  if (key == 'c'||key =='C') {
    saveFrame("output/capturas/####.png");
  }
}
