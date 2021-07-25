
//definición 
AutomataCelular automata;

//---------------------------

void setup() {
  size( 1200, 700 );
  //se inicializa pasando las columnas y filas
  automata = new AutomataCelular( 120, 70 );
  frameRate(12);
  noStroke();
}
//---------------------------

void draw() {

  automata.actualizar();
  automata.dibujar();
  filter(BLUR,2);
}
//---------------------------

void keyPressed() {
  if ( key == ' ' ) {
    automata.iniciar();
  }
}
//---------------------------
