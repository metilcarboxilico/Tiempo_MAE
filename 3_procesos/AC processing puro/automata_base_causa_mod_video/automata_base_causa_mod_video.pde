
import processing.video.*;


//definición 
AutomataCelular automata;
Movie a;//, b, c, d;

boolean recording=false;

void setup() {
  size( 1200, 700, FX2D );
  surface.setTitle("AC con video");
  surface.setResizable(true);
  surface.setLocation(100, 100);

  //se inicializa pasando las columnas y filas
  automata = new AutomataCelular( 1200/2, 700/2 );
  //frameRate(12);
  noStroke();

  a= new Movie(this, "a.mp4");
  a.loop();
  // a.frameRate(2);
  a.speed(.2);
  a.volume(0);
}


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
