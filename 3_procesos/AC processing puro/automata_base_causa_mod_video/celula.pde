// Actualizada al 21/Ago/2020
//-------------------------------------------------------------------------------------------------------------------------
//
//  Emiliano Causa 2008-2020
//  emiliano.causa@gmail.com
//  emilianocausa.ar
//  biopus.ar
//
//-------------------------------------------------------------------------------------------------------------------------
class Celula {

  float actual;
  float futuro;

  float x, y, ancho, alto;

  int vecinoX[], vecinoY[];

  //---------------------------

  Celula( int i, int j, int col, int fil ) {
    vecinoX = new int[8];
    vecinoY = new int[8];

    //n
    vecinoX[0] = i;
    vecinoY[0] = j-1;
    //ne
    vecinoX[1] = i+1;
    vecinoY[1] = j-1;
    //e
    vecinoX[2] = i+1;
    vecinoY[2] = j;
    //se
    vecinoX[3] = i+1;
    vecinoY[3] = j+1;
    //s
    vecinoX[4] = i;
    vecinoY[4] = j+1;
    //so
    vecinoX[5] = i-1;
    vecinoY[5] = j+1;
    //o
    vecinoX[6] = i-1;
    vecinoY[6] = j;
    //no
    vecinoX[7] = i-1;
    vecinoY[7] = j-1;

    for ( int k=0; k<8; k++ ) {
      vecinoX[k] = ( vecinoX[k] < 0 ? col-1 : vecinoX[k] );
      vecinoX[k] = ( vecinoX[k] > col-1 ? 0 : vecinoX[k] );
      vecinoY[k] = ( vecinoY[k] < 0 ? fil-1 : vecinoY[k] );
      vecinoY[k] = ( vecinoY[k] > fil-1 ? 0 : vecinoY[k] );
    }
  }
  //---------------------------

  void actualizar() {
    actual = futuro;
  }
  //---------------------------

  void dibujar() {//esta resuelta  de esta forma para facilitar el for 

    display( actual, x, y, ancho, alto, a);
    //dibujarCelula( actual, x, y, ancho, alto );
  }
  //---------------------------

  void iniciar() {
    actual = iniciarCelula();
  }
  //---------------------------

  void localizar(float x, float y, float ancho, float alto) {
    this.x = x + ancho/2;
    this.y = y + alto/2;
    this.ancho = ancho;
    this.alto = alto;
  }
  //---------------------------

  void operar( AutomataCelular todos ) {

    futuro = actualizarCelula( actual 
      , todos.celulas[ vecinoX[0] ][ vecinoY[0] ].actual 
      , todos.celulas[ vecinoX[1] ][ vecinoY[1] ].actual 
      , todos.celulas[ vecinoX[2] ][ vecinoY[2] ].actual
      , todos.celulas[ vecinoX[3] ][ vecinoY[3] ].actual 
      , todos.celulas[ vecinoX[4] ][ vecinoY[4] ].actual
      , todos.celulas[ vecinoX[5] ][ vecinoY[5] ].actual
      , todos.celulas[ vecinoX[6] ][ vecinoY[6] ].actual
      , todos.celulas[ vecinoX[7] ][ vecinoY[7] ].actual
      , x
      , y
      );
  }
  //---------------------------
}




float iniciarCelula() {  
  //carga en cada célula un valor al azar entre 0 y 255
  float valor;
  float rand=random(1);
  if (rand<.2) { //20%
    valor = random(255);
  } else if (rand<.5) {  //30%
    valor = random(100, 200);
  } else if (rand<.9) {  //40%
    valor = random(10, 50);
  } else { //10%
    valor = random(100);
  }
  return valor;
}



float actualizarCelula( float actual, float n, float ne, float e, float se, float s, 
  float so, float o, float no, float x, float y ) {

  if (actual<30) {
    actual =random(160);
  } else if (actual<30) {
    actual=(n+ne+e+se+s+so+o+no)/8;
  } else if (((n+ne+e+se+s+so+o+no)/8)>220) {
    actual =random(45);
  } else if (((n+ne+e+se+s+so+o+no)/8)>210) {
    actual =random(255);
  } else if (((n+ne+e+se+s+so+o+no)/8)>165) {
    actual =random(220, 255);
  } else if (((n+ne+e+se+s+so+o+no)/8)>140) {
    actual =random(110, 180);
  } else {
    actual-=.5;
  }

  float proximo = actual;
  return proximo;
}



void dibujarCelula( float actual, float x, float y, float ancho, float alto ) {

  rectMode(CENTER);
  fill( actual );
  rect( x, y, ancho, alto );
}


void display( float actual, float x, float y, float w, float h, Movie video_) { //a modificar con un return?
  color colPx=pxVideo(x, y, video_);
  rectMode(CENTER); //para no joder la estructura anterior
  
  /*
  if (actual>8&&actual<15) {
    colPx=(colPx+color(255, 0, 0))/2;
    fill(colPx);
  } else if (actual>3&&actual<7) {

    colPx=color(255, 100, 20);
    fill(colPx);
  } else  fill(colPx, map(actual, 0, 255, 255, 0));
*/

  //se podria sacar color
   fill(colPx, map(actual, 0, 255, 255, 0));
  rect(x, y, w, h);//ellipse
}


color pxVideo(float x_, float y_, Movie video_) {
  video_.loadPixels();
  return   video_.pixels[int(x_)+int(y_)*video_.pixelWidth];//video_.get(int(x_), int(y_));//
  //video_.get(x_, y_);
}
