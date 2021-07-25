// Actualizada al 21/Ago/2020
//-------------------------------------------------------------------------------------------------------------------------
//
//  Emiliano Causa 2008-2020
//  emiliano.causa@gmail.com
//  emilianocausa.ar
//  biopus.ar
//
//-------------------------------------------------------------------------------------------------------------------------
class AutomataCelular {
  PGraphics pg;
  int initX, initY, finX, finY;
  int col;
  int fil;
  int rules;
  Celula[][] celulas;

  //---------------------------


  AutomataCelular( int initX_, int initY_, int finX_, int finY_, int res_, int r_) {

    col = int((finX_-initX_)/res_);
    fil = int((finY_-initY_)/res_);
    //pg = createGraphics(col, fil);//un px por cada col y fil?
    pg = createGraphics(int(finX_-initX_), int(finY_-initY_));//un px por cada col y fil?
    rules=r_;
    celulas = new Celula[col][fil];

    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j] = new Celula( i, j, col, fil );
      }
    }

    localizar(initX_, initY_, finX_, finY_);
    iniciar();
  }

  AutomataCelular( int initX_, int initY_, int finX_, int finY_, int res_) {
    col = int((finX_-initX_)/res_);
    fil = int((finY_-initY_)/res_);
    //pg = createGraphics(col, fil);//un px por cada col y fil?
    pg = createGraphics(int(finX_-initX_), int(finY_-initY_));//un px por cada col y fil?
    rules=1;
    celulas = new Celula[col][fil];

    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j] = new Celula( i, j, col, fil );
      }
    }

    localizar(initX_, initY_, finX_, finY_);
    iniciar();
  }
  //---------------------------

  void actualizar() {
    for ( int i=0; i<col; i++ ) {

      for ( int j=0; j<fil; j++ ) {//calculo
        celulas[i][j].calculraCelFuturo( this );
      }
    }
    //aplicacion
    for ( int i=0; i<col; i++ ) {

      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].actualizar( );
      }
    }
  }
  //---------------------------

  PGraphics dibujar() {


    pg.beginDraw();
    pg.background(100);
    // noStroke();
    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].dibujar(this);
      }
    }

    pg.endDraw();

    return pg;
  }
  //---------------------------

  void iniciar() {

    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].iniciar( );
      }
    }
  }
  //---------------------------

  void localizar( float left, float top, float right, float botton ) {

    float pasox = (right-left) * 1.0 / col;
    float pasoy = (botton-top) * 1.0 / fil;
    for ( int i=0; i<col; i++ ) {

      for ( int j=0; j<fil; j++ ) {

        celulas[i][j].localizar( pasox*i+left, pasoy*j+top, pasox, pasoy );
      }
    }
  }
  //---------------------------

  /* //funcion a decidir si la construyo aca o traigo el mismo sistema de vecino aqui
   void pulso(int col_, int fil_) {
   celulas[i][j].selecRulset(255);
   }
   */
  void setActual(int col_, int fil_, float actual_) {
    celulas[col_][fil_].setActual (actual_);
  }



  void randRulset(int min, int max) {
    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].selecRulset(int(random(min, max)));
      }
    }
  }

  void selecRulset(int r) {
    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].selecRulset(r);
      }
    }
  }

  //---------------------------
}
