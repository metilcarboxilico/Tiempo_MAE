class RectMod {

  PGraphics base;

  int divX, divY;
  float off=0;
  float[] vertebra, superior, inferior, izq, der; //vetebra es x y las otras son Ys
  float[] superiorCopy, inferiorCopy, izqCopy, derCopy; 

  float  magnitud, amplitud=100;
  float modulo, ordenada, absisa;




  RectMod(int  magnitud_, int amplitud_, int divX_, int divY_) {
    divX=divX_;
    divY=divY_;

    //gnerar un leve desfasaje entre el tamaños del PG y el dibujo?
    base= createGraphics(magnitud_, amplitud_); //esto deveria ser x Y en vez de W H y el centro de poly 00 o width/2?
    magnitud=magnitud_*.9;
    amplitud=amplitud_*.85;

    ordenada=amplitud_/2;
    absisa=(magnitud_-magnitud)/2;
    amplitud=amplitud/2; 

    modulo=magnitud/divX;// como se subdivide el largo, mi medida

    vertebra=new float[divX];//las unicas cordenadas en X
    superior=new float[divX];// aunque inferior y sup son cordenadas de y 
    inferior=new float[divX];
    izq=new float[divY];
    der=new float[divY];

    //podria generar un mapeo tambien para achicar o agrandar en los extremos o utilizar sin() y luego volver a procesar sin()
    for (int i=0; i<divX; i++) {
      vertebra[i]= i*modulo+absisa;// en teoria esta seria la unica indispensable
      superior[i]=ordenada -amplitud ;
      inferior[i]=ordenada + amplitud;
    }

    for (int i=0; i<izq.length; i++) {
      izq[i]= ordenada -amplitud + (amplitud*2/izq.length)*i;  //utilizo la misma estrategia de modulo e inicializo la cuenta eel limite superior
      der[i]= ordenada -amplitud + (amplitud*2/der.length)*i;
    }


    this.reLoad();
  }

  //-------------------------


  RectMod(int  magnitud_, int amplitud_, int divX_, int divY_, float ratioX, float ratioY) {
    divX=divX_;
    divY=divY_;

    //gnerar un leve desfasaje entre el tamaños del PG y el dibujo?
    base= createGraphics(magnitud_, amplitud_); //esto deveria ser x Y en vez de W H y el centro de poly 00 o width/2?
    magnitud=magnitud_*ratioX;
    amplitud=amplitud_*ratioY;

    ordenada=amplitud_/2;
    absisa=(magnitud_-magnitud)/2;
    amplitud=amplitud/2; 

    modulo=magnitud/divX;// como se subdivide el largo, mi medida

    vertebra=new float[divX];//las unicas cordenadas en X
    superior=new float[divX];// aunque inferior y sup son cordenadas de y 
    inferior=new float[divX];
    izq=new float[divY];
    der=new float[divY];

    //podria generar un mapeo tambien para achicar o agrandar en los extremos o utilizar sin() y luego volver a procesar sin()
    for (int i=0; i<divX; i++) {
      vertebra[i]= i*modulo+absisa;// en teoria esta seria la unica indispensable
      superior[i]=ordenada -amplitud ;
      inferior[i]=ordenada + amplitud;
    }

    for (int i=0; i<izq.length; i++) {
      izq[i]= ordenada -amplitud + (amplitud*2/izq.length)*i;  //utilizo la misma estrategia de modulo e inicializo la cuenta eel limite superior
      der[i]= ordenada -amplitud + (amplitud*2/der.length)*i;
    }


    this.reLoad();
  }

  //////////////////////////////////////////////////////
  void reLoad() {
    superiorCopy = superior.clone();
    inferiorCopy = inferior.clone();
    izqCopy = izq.clone();
    derCopy = der.clone();
  }



  void fillPG(color colFill) {
    base.beginDraw();
    base.fill(colFill);
    base.endDraw();
  }  
  void noFillPG( ) {
    base.beginDraw();
    base.noFill();
    base.endDraw();
  } 
  void strokePG(color colFill) {
    base.beginDraw();
    base.stroke(colFill);
    base.endDraw();
  }
  void noStrokePG( ) {
    base.beginDraw();
    base.noStroke();
    base.endDraw();
  }
  void backgroundPG( color colBk) {
    base.beginDraw();
    base.background(colBk); //no se porque me da nullPointerException
    base.endDraw();
  }

  PGraphics   displayPG() { 
    base.beginDraw();
    base.beginShape();

    for (int i=0; i<vertebra.length; i++) base.vertex(vertebra[i], superiorCopy[i]);
    for (int j=0; j<der.length; j++)base.vertex(vertebra[divX-1], derCopy[j]);
    for (int i=vertebra.length-1; i>0; i--)  base.vertex(vertebra[i], inferiorCopy[i]);
    for (int j=der.length-1; j>0; j--) base.vertex(vertebra[0], izqCopy[j]);
    /*{ //pensando en sacar las lineas del limite.
      if (izqCopy[j]< superiorCopy[0]) base.vertex(vertebra[0], izqCopy[j]);
      //else    base.vertex(vertebra[0], superiorCopy[0]);
    }*/

    base.endShape(CLOSE); //CLOSE

    base.endDraw();

    return base;
  }


  void   display() { 
    display( 0, #FFFFFF);
  }

  void   display(color colBk, color colFill) { 
    background(colBk); //no se porque me da nullPointerException
    beginShape();
    //stroke(#ffff00);
    fill(colFill);

    for (int i=0; i<vertebra.length; i++) vertex(vertebra[i], superiorCopy[i]);
    for (int j=0; j<der.length; j++)vertex(vertebra[divX-1], derCopy[j]);
    for (int i=vertebra.length-1; i>0; i--)  vertex(vertebra[i], inferiorCopy[i]);
    for (int j=der.length-1; j>0; j--)vertex(vertebra[0], izqCopy[j]);

    endShape(CLOSE); //CLOSE
  }



  //---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//
  //---//---//---//   //funciones para modificar la copia del array//   //---//---//---//---//---//---//---//---//
  //---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//


  void gauPoly(int a_, float amp) {
    //hay alguna forma mejor de aplicar esto?
    if ( a_==0)izqCopy = gauArray(izqCopy, amp);
    else if (a_==1)superiorCopy= gauArray(superiorCopy, amp);
    else if (a_==2)inferior= gauArray(inferior, amp);
    else if (a_==3)derCopy= gauArray(derCopy, amp);
    else println("la funcion no modifico el array, cambiar el index");
  } 

  void randPoly(int a_, float min, float max) {
    //hay alguna forma mejor de aplicar esto?
    if ( a_==0)izqCopy = randArray(izqCopy, min, max) ;
    else if (a_==1)superiorCopy= randArray(superiorCopy, min, max) ;
    else if (a_==2)inferiorCopy= randArray(inferiorCopy, min, max) ;
    else if (a_==3)derCopy= randArray(derCopy, min, max) ;
    else println("la funcion no modifico el array, cambiar el index");
  }


  void noisePoly(int a_, float frec, float min, float max) {
    noisePoly( a_, frec, min, max, 0) ;
  }

  void noisePoly(int a_, float frec, float min, float max, float offset) {
    if      (a_==0)izqCopy = noiseArray(izqCopy, frec, min, max, offset) ;
    else if (a_==1)superiorCopy= noiseArray(superiorCopy, frec, min, max, offset) ;
    else if (a_==2)inferiorCopy= noiseArray(inferiorCopy, frec, min, max, offset) ;
    else if (a_==3)derCopy= noiseArray(derCopy, frec, min, max, offset) ;
    else println("la funcion no modifico el array, cambiar el index");
  } 

  void senoPoly(int a_, float amp, float frec) {
    senoPoly( a_, amp, frec, 0);
  }

  void senoPoly(int a_, float amp, float frec, float offset) {
    if   (a_==0)izqCopy = senoArray(izqCopy, amp, frec, offset) ;
    else if (a_==1)superiorCopy= senoArray(superiorCopy, amp, frec, offset) ;
    else if (a_==2)inferiorCopy= senoArray(inferiorCopy, amp, frec, offset) ;
    else if (a_==3)derCopy= senoArray(derCopy, amp, frec, offset) ;
    else println("la funcion no modifico el array, cambiar el index");
  }

  void cosenoPoly(int a_, float amp, float frec) {
    cosenoPoly( a_, amp, frec, 0);
  }

  void cosenoPoly(int a_, float amp, float frec, float offset) {
    if      (a_==0)izqCopy = cosenoArray(izqCopy, amp, frec, offset) ;
    else if (a_==1)superiorCopy= cosenoArray(superiorCopy, amp, frec, offset) ;
    else if (a_==2)inferiorCopy= cosenoArray(inferiorCopy, amp, frec, offset) ;
    else if (a_==3)derCopy= cosenoArray(derCopy, amp, frec, offset) ;
    else println("la funcion no modifico el array, cambiar el index");
  }




  //////////////---------------------
}
