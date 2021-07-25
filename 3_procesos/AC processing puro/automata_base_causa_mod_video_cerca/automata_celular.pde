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

  int initX, initY, finX, finY;
  int col;
  int fil;

  Celula[][] celulas;

  //---------------------------

  AutomataCelular( int initX_, int initY_, int finX_, int finY_, int res_) {

    col = int((finX_-initX_)/res_);
    fil = int((finY_-initY_)/res_);

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

      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].operar( this );
      }
    }
    for ( int i=0; i<col; i++ ) {

      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].actualizar( );
      }
    }
  }
  //---------------------------

  void dibujar( ) {
    for ( int i=0; i<col; i++ ) {

      for ( int j=0; j<fil; j++ ) {
        celulas[i][j].dibujar( );
      }
    }
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
}
