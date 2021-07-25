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

  int col;
  int fil;

  Celula[][] celulas;

  //---------------------------

  AutomataCelular( int ancho, int alto ) {

    col = ancho;
    fil = alto;

    celulas = new Celula[col][fil];

    for ( int i=0; i<col; i++ ) {
      for ( int j=0; j<fil; j++ ) {
        celulas[i][j] = new Celula( i, j, col, fil );
      }
    }

    localizar(0, 0, width, height);
    iniciar();
  }
  //---------------------------

  void actualizar() {

    for ( int j=0; j<fil; j++ ) {
      for ( int i=0; i<col; i++ ) {
        celulas[i][j].operar( this );
      }
    }

    for ( int j=0; j<fil; j++ ) {
      for ( int i=0; i<col; i++ ) {
        celulas[i][j].actualizar( );
      }
    }
  }
  //---------------------------

  void dibujar( ) {

    for ( int j=0; j<fil; j++ ) {
      for ( int i=0; i<col; i++ ) {
        celulas[i][j].dibujar( );
      }
    }
  }
  //---------------------------
  
  void iniciar(){
    for ( int j=0; j<fil; j++ ) {
      for ( int i=0; i<col; i++ ) {
        celulas[i][j].iniciar( );
      }
    }
  }
  //---------------------------

  void localizar( float left, float top, float right, float botton ) {

    float pasox = (right-left) * 1.0 / col;
    float pasoy = (botton-top) * 1.0 / fil;

    for ( int j=0; j<fil; j++ ) {
      for ( int i=0; i<col; i++ ) {

        celulas[i][j].localizar( pasox*i+left, pasoy*j+top, pasox, pasoy );
      }
    }
  }
  //---------------------------
}
