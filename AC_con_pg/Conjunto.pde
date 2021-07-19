



class Conjunto {
  //esta clase quizas me gustaria readaptarla para q se genere a partir de JSONs sobre todo los mod de poligonos

  float vida;
  PGraphics basePG;
  float offX=0, offY=0;// por ahi generar un array de offset dentro de la clase
  polyRetorcido polyAgitado;
  AutomataCelular automata;
  int ancho, alto, lados, interpolaciones =13;
  float radio;
  //Movie movie;
  //PGraphics pgMovie;

  Conjunto(float vida_, int w_, int h_) { //String pathMovie

    vida = vida_;

    lados=int(random(5, 14));
    alto= w_;
    ancho = h_;
    if (alto>ancho) radio= ancho*random(.2, .5);
    else  radio= alto*random(.2, .5);
     radio= alto*.3;
    //interpolaciones;
    automata = new AutomataCelular(0, 0, alto, ancho, 1);
    //polyRetorcido(int w_, int h_, float radio_, float init_, int lados_, int interpolaciones) 
    polyAgitado= new  polyRetorcido(alto, ancho, radio, 45, lados, interpolaciones);
   basePG = createGraphics(alto, ancho); //tiene sentido o usarlo de manera externa?
    
    //decidir si se queda o se va
    /*
    basePG.beginDraw();
    basePG.imageMode(CENTER); //de esta puedo regular el tamaño desde el centro del automata
    basePG.endDraw();
    */
    
    polyAgitado.reArray();
  }
  // una estrategia para no calcular ni almacenar muchos offset seria un contador de enteros q luego lo multiplico .001 .05 etc
  //float escalaOffX= .05  //float escalaOffY= .5

  void actualizar() {
    polyAgitado.reArray();

    //polyAgitado.reArray();
    //esto generar 8 for o funciones que modifiquen el array 
   // polyAgitado.senoPoly( -5.8, 0.1, -offY*.5); // esta puede ir
   // polyAgitado.noisePolyY(0.3, -50, 50, -offY*.5);
    //polyAgitado.noisePolyX(0.1, -50, 50, offX*.05);
    polyAgitado.noisePolyY( 0.2, -50, 50, offY*.5);

    automata.actualizar();
    //automata.actualizar();
   // automata.actualizar();
    automata.actualizar();

    offX++; 
    offY++;
    
    vida--;
  }





  ////--------------------------------------display-------------------------------------

  void display(Movie mov_, int x_, int Y_) {
    display(mov_, x_, Y_, ancho, alto) ;
  }
  void display(PImage img, int x_, int Y_) {
    display( img, x_, Y_, ancho, alto) ;//    display( img, x_, Y_, img.width, img.height) ;

  }

  void display(Movie mov_, int x_, int Y_, float wM_, float hM_) {
    basePG.beginDraw();
    basePG.image(mov_, 0, 0, wM_, hM_ ); //a
    basePG.endDraw();

    basePG.mask(mascara());
    image(basePG, x_, Y_, wM_, hM_);
  }
  void display(PImage img, int x_, int Y_, float wM_, float hM_) {
    basePG.beginDraw();
    basePG.image(img, 0, 0, wM_, hM_ );
    //basePG.image(img, basePG.width/2, basePG.height/2, wM_, hM_ );//.imageMode(CENTER)
    basePG.endDraw();
    basePG.mask(mascara());
    
    image(basePG, x_, Y_, wM_, hM_);
  }
   void displayCenter(PImage img, int x_, int Y_, float wM_, float hM_) {
    basePG.beginDraw();
    basePG.image(img, 0, 0, wM_, hM_ );
    basePG.imageMode(CENTER);
    basePG.image(img, basePG.width/2, basePG.height/2, wM_, hM_ );
    basePG.endDraw();

    basePG.mask(mascara());
    image(basePG, x_, Y_, wM_, hM_);
  }

  ////--------------------------------------masara (func utilizada x display)-------------------------------------

  PGraphics mascara() {


    polyAgitado.backgroundPG(0);
    polyAgitado.fillPG(#FFFFFF);


    //devuelven PGs y estoy obligado a este paso
    PGraphics mascaraAC =  automata.dibujar(); 
    PGraphics mascaraForma =polyAgitado.displayPG();
    mascaraAC.beginDraw();
    mascaraAC.loadPixels();
    mascaraForma.loadPixels();
    for (int i=0; i<mascaraAC.pixels.length; i++) { // a remplazar por una concatenacion de PGs?
      if (mascaraForma.pixels[i]==color(0))mascaraAC.pixels[i]=0;
    }
    mascaraAC.updatePixels();
    mascaraAC.endDraw(); 

    return mascaraAC;
  }

  boolean isDead() {
    if (vida>0)return false;
    else return true;
  }
}



/* 
  
 void  senoPoly (float amp, float frec, float off_) {
 void  senoPolyX   (float amp, float frec, float off_) {
 
 void  cosenoPoly (float amp, float frec, float off_) {
 void  cosenoPolyY (float amp, float frec, float off_) {
 
 void  noisePolyX ( float frec, float min, float max, float offset) {
 void  noisePolyY ( float frec, float min, float max, float offset) {
 
 void gauPolyX (float amp) 
 void gauPolyY (float amp)
 */

//una funcion que cargue
//funcion que recorra un diccionario con arrrays dentro  para setear cada mascara de AC
//una que actualice? 





// funcion de animacion,  seteo de rulset/ estados finitos
// de display (rebice pg??) de actualizacion
//carga desde json
