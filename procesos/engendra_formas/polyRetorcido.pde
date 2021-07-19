

class polyRetorcido {
  //clase para generar un poligono (regular) y modificarlo en funcion de sus coordenadas x Y

  PGraphics base;
  //float offX=0, offY=0;
  float[] cX, cY, interX, interY, interA, interB;
  //esto no se si es necesario pero podria ser util tenerlo
  /* int w;
   int h;
   float radio;
   float init;
   int lados; 
   int n;
   */

  polyRetorcido(int w_, int h_, float radio_, float init_, int lados_, int n_) {
    /*  w=w_;
     h=h_;
     radio=radio_;
     init=init_;
     lados=lados_;
     n=n_;
     */
    base= createGraphics(w_, h_); //esto deveria ser x Y en vez de W H y el centro de poly 00 o width/2?

    cX=polyCos(base.width/2, radio_, init_, lados_);
    cY=polySin(base.height/2, radio_, init_, lados_);
    interA=interArray(cX, n_);
    interB=interArray(cY, n_);
  }
  void reArray() {
    //funcion para el draw - copia el array para modificar 
    interX=interA.clone();
    interY=interB.clone();
  }
  //  void newSet(float x_, float y_, float radio_, float init_, int lados_, int n_) {

  void newSet(float radio_, float init_, int lados_, int n_) {
    cX=polyCos(base.width/2, radio_, init_, lados_);
    cY=polySin(base.height/2, radio_, init_, lados_);
    interA=interArray(cX, n_);
    interB=interArray(cY, n_);
  }

  void imageModePG(){

    base.beginDraw();
    base.imageMode(CENTER);
    base.endDraw();
  }
  void fillPG(color colFill) { //buscar otro nombre?

    base.beginDraw();
    base.fill(colFill);
    base.endDraw();
  }
  
   void backgroundPG(){
     backgroundPG(0);
   }
  void backgroundPG(color colBk) { //buscar otro nombre?
    base.beginDraw();
    base.background(colBk); 
    base.endDraw();
  }
  void strokePG(color stroke) { //buscar otro nombre?
    base.beginDraw();
    base.stroke(stroke); 
    base.endDraw();
  }
  void noStrokePG() { //buscar otro nombre?
    base.beginDraw();
    base.noStroke(); 
    base.endDraw();
  }
  void autoMaskPG() { //buscar otro nombre?
    base.beginDraw();
    base.mask(base); 
    base.endDraw();
  }

  PGraphics displayPG(color colBk, color colFill) { //buscar otro nombre?
    fillPG(colFill);
    backgroundPG(colBk);
    return displayPG();
  }


  PGraphics displayPG() { //buscar otro nombre?

    base.beginDraw();
    base.beginShape();
    //stroke(#ffff00);
    for (int i=0; i<interX.length; i++) {
      base.curveVertex(interX[i], interY[i]);
    } 
    base.endShape(CLOSE); //CLOSE

    base.endDraw();

    return base;
  }
  ///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///
  ///////////////////////////////////////  funciones:  /////////////////////////////////////////////////
  ///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///---///

  void display(float x, float y) { //buscar otro nombre?
    pushMatrix();
    translate(x-base.width/2, y-base.width/2);
    beginShape();
    //stroke(#ffff00);
    //curveVertex(cX[6], cY[6]);

    for (int i=0; i<interX.length; i++) {
      curveVertex(interX[i], interY[i]);
    } 
    endShape(CLOSE); //CLOSE
    popMatrix();
  }


  /*void actualizar() {// reformular el problema, esta funcion limita todo
   this.actualizar(.1, .1);//hace falta this
   }
   
   void actualizar(float aumentoX, float aumentoY) {
   //actualizo los offset
   offX += aumentoX;
   offY +=aumentoY;
   }
   */


  //---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//
  //---//---//---//   //funciones para modificar la copia del array//   //---//---//---//---//---//---//---//---//
  //---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//
  /*siento qeu todas estas definiciones o nombres pueden er altamente confusos
   aplicar otro criterio? formas abreviadas? otra logica para las funciones
   algo que recia?
   */

  //seno y coseno podrian ser tambien cruzados?  total no estoy generando algo siguiendo la logica 
  void  senoPoly(float amp, float frec) {
    senoPoly( amp, frec, 0);
  }
  void  senoPoly(float amp, float frec, float off_) {
    interY = senoArray(interY, amp, frec, off_);
  }

  void  senoPolyX(float amp, float frec, float off_) {
    interX = senoArray(interX, amp, frec, off_);
  }
  void  senoPolyX(float amp, float frec) {
    senoPolyX( amp, frec, 0);
  }

  //---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//---//

  void  cosenoPoly(float amp, float frec) {
    cosenoPoly( amp, frec, 0);
  }
  void  cosenoPoly(float amp, float frec, float off_) {
    interX = cosenoArray(interX, amp, frec, off_);
  }
  void  cosenoPolyY(float amp, float frec) {
    cosenoPolyY( amp, frec, 0);
  }
  void  cosenoPolyY(float amp, float frec, float off_) {
    interX = cosenoArray(interX, amp, frec, off_);
  }


  //---------------------------------


  //aca se complica, hacer un if char == x /y else ambos?
  void  noisePolyX ( float frec, float min, float max) {
    noisePolyX (  frec, min, max, 0) ;
  }    
  void  noisePolyY ( float frec, float min, float max) {
    noisePolyY (frec, min, max, 0) ;
  }  


  void  noisePolyX ( float frec, float min, float max, float offset) {
    interX = noiseArray(interX, frec, min, max, offset);
  }  
  void  noisePolyY ( float frec, float min, float max, float offset) {
    interY = noiseArray(interY, frec, min, max, offset);
  }  
  //---------------------------------


  void randPolyX(float min, float max) {
    interX= randArray(interX, min, max) ;
  }

  void randPolyY(float min, float max) {
    interY= randArray(interY, min, max) ;
  }
  //---------------------------------

  void gauPolyX(float amp) {
    interX =gauArray(interX, amp);
  }

  void gauPolyY(float amp) {
    interY =gauArray(interY, amp);
  }   

  //agregar una funcion de seteo x index?

  ///////////////////////////---------------------------------
}
