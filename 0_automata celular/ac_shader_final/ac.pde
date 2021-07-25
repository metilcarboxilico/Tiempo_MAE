
class Ac {

  boolean isRulRange= false; //actualmente en busca de un rulset o configuracion general optimas

// rutas de los shaders
  String acSimple="ac array.glsl";
  String acRange ="ac arrayrand.glsl";
  String shMask="mask json mid.glsl";
  
  
  
  //float rnd=random(1);
  int w = int(random(width));
  int h = int(random(height));
  int id;

  float posX, posY;
  float zoomAcX =1., zoomAcY=1., zoomImgX=1.0, zoomImgY=1.0;


  float vida;
  float cnt=0.0;

  PShader maskShader;
  PShader ac;

  PGraphics pg;
  PGraphics base;
  PImage salida;



  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  //dft seria la condicion default al no estar evaluada en el Resultado
  float dft =(float)(norm*-255*10);

//para modificar la ingerencia de cada celula en la suma de sus estados
//en sentido horario - desde la izquierdar hacia la derecha y el centro EE NE NN NO OO SO SS SE CC
  float bias[]= {1.0, 1.0, 1.0, 1.0, 
    1.0, 1.0, 1.0, 1.0, 
    0.0 };  //
    //originalmente  el AC se calcula por cada celula y en base la cant de vivas o el promedio de sus estado se genera un estdo futuro,
    //en este caso encontre mucho mas practico para alargar el comportamiento de los AC no promediar sino q 
  float divisor= 6.550;


//el modulo son las veces que el automata se actualiza en funcion ==> frameRate % modulo == 0
  int   modulo =int(abs(randomGaussian()*5)+1) ;




  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //parametros para los Shaders sobre todo para la mascara irregular
  
  float sclrand;
  float rndX ;
  float rndY ;

  float posX0 ;
  float posX1 ;
  float posX2 ;

  float posY0 ;
  float posY1 ;
  float posY2 ;

  float  w0;
  float  w1;
  float  w2;

  float h0 ;
  float  h1;
  float  h2;

  float s0 ;
  float s1 ;
  float s2 ;

  float cosT0 ;
  float cosT1 ;
  float cosT2 ;


  float sinT0 ;
  float sinT1 ;
  float sinT2 ;

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  
  
  //estan seteados por default pero luego se sobreescribiran por el JSON
  //;float minmax[]=
  float rulRange[] ={  (float)(norm*0), (float)(norm*100), 
    (float)(norm*220), (float)(norm*255), 
    (float)(norm*200), (float)(norm* 255), 
    (float)(norm*200), (float)(norm* 255), 
    (float)(norm*200), (float)(norm*255), 
    (float)(norm*200), (float)(norm*255)};

  // float rulset[];
  float resultado[]={
    (float)(norm*0.1*random(160)), 
    (float)(norm*random(180)), 
    (float)(norm*random(110, 180)), 
    (float)(norm*random(220, 255)), 
    (float)(norm*random(255)), 
    (float)(norm*random(45))
  };

  float rulset[]= {
    (float)(norm*30), (float)(norm*70), 
    (float)(norm*100), (float)(norm*165), 
    (float)(norm*210), (float)(norm*220)
  };


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Ac(JSONObject json_) {

    pg = createGraphics(w, h, P2D);
    //pg.noSmooth();
    base = createGraphics(w, h, P2D);
    //base.noSmooth();

    posX= random(width/2);
    posY= random(height/2);

    salida = createImage(w, h, RGB);

    //seteo por via json del
    getJSON(json_);

    maskShader = loadShader(shMask);
    maskShader.set("resolution", float(w), float(h));

    setMask();
  }
  //resetShader();




  void setAcShader() {
    //seteo del sahder del automata celular

    setShader();
    ac.set("resolution", float(pg.width), float(pg.height));  

    ac.set("rules", rulset);
    ac.set("dft", dft);
    ac.set("sclrand", sclrand);
    ac.set("rndX", rndX);
    ac.set("rndY", rndY);
    ac.set("modulo", modulo);

    ac.set("bias", bias);

    ac.set("divisor", divisor);
  }


  void actualizar() {

    cnt +=5;

    ac.set("time", millis()/10000.0);
    ac.set("frame", float(frameCount));
    ac.set("iniciar", cnt); //si es <50 se activa el AC

    maskShader.set("time", millis()/1000.0);
  }

  void setShader() { 
    if (isRulRange) { 
      ac = loadShader(acRange);
      ac.set("minmax", rulRange);
    } else {
      ac = loadShader(acSimple);
      ac.set("resul", resultado);
    }
  }


  //////////////////////////////////////////////////


  void dibujar(PImage img_) {
    this.dibujar(img_, posX, posY, w, h);
  }


  void dibujar(PImage img_, float x_, float y_) {
    //dibujar(img_, x_,  y_, 100, 100 ); 
    this.dibujar(img_, x_, y_, w, h);
  }


  void dibujar(PImage img_, float x_, float y_, float w_, float h_) {
    //background(170);

    pg.beginDraw();
    pg.background(0);
    pg.shader(ac);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
    //creo q vot a tener que poner todo dentro de otro pg
    //shader(maskShader); 

    //salida = createImage(w, h, RGB);
    salida.copy(img_, 0, 0, img_.width, img_.height, 0, 0, int(pg.width*zoomImgX), int(pg.height*zoomImgY));
// (img_.width+pg.width)/2, (img_.height+pg.height)/2,
    salida.mask(pg);

    base.beginDraw();
    base.background(0);
    base.shader(maskShader);
    base.endDraw();

    base.mask(base);

    //aunque parezca poco ideal me ahorre crear un pg 
    //y pronto pensare como afectar correctamente el canal alfa dentro del shader, 
    base.beginDraw();
    base.image(salida, 0, 0, pg.width*zoomAcX, pg.height*zoomAcY);
    base.endDraw();

    //base.mask(base);
    image(base, x_, y_, w_, h_);
  }



  void setDivisor(float k_) {
    this.divisor =k_;
    this.ac.set("divisor", divisor);
  }
  void setDivisor() {
    this.ac.set("divisor", divisor);
  }

  void setBias(float[] bias_) {
    this.bias=bias_;
    this.ac.set("bias", bias);
  }
  void setBias() {
    this.ac.set("bias", bias);
  }

  void setDefault(float dft_) {
    dft= dft_;
    ac.set("dft", dft);
  }
  void setDefaultNorm(float dft_) {
    dft= (float)(norm*dft_);
    ac.set("dft", dft);
  }

  void setAcToRange() {
    this.isRulRange= true;
    this.reShader();
    this.setShader();
  }
  void setAcInvert() {
    this.isRulRange= !isRulRange;
    this.reShader();
    this.setShader();
  }
  void setAcToSimple() {
    this.isRulRange= false;
    this.reShader();
    this.setShader();
  }

  void reShader() {
    pg.beginDraw();
    pg.resetShader();
    pg.endDraw();
  }
  void setRange(float[] fA_) {
    rulRange =fA_;
  }
  void setRul(float[] fA_) {
    rulset =fA_;
  }
  void setResultado(float[] fA_) {
    resultado =fA_;
  }



  void setZoomAcX(float k_) {
    this.zoomAcX= k_;
  } 
  void setZoomAcY(float k_) {
    this.zoomAcY= k_;
  }
  void setZoomImgX(float k_) {
    this.zoomImgX= k_;
  }
  void setZoomImgY(float k_) {
    this.zoomAcY= k_;
  }


void resetCtn(){
     cnt=42; 
    }


  boolean isDead() {
    if (vida<=0) {
      return true;
    } else {
      return false;
    }
  }



  //----------------seteos fundamentales-------------------



  void setMask() {

    maskShader.set("sclrand", sclrand);

    maskShader.set("rndX", rndX);
    maskShader.set("rndY", rndY);

    maskShader.set("posX0", posX0);
    maskShader.set("posX1", posX1);
    maskShader.set("posX2", posX2);

    maskShader.set("posY0", posY0);
    maskShader.set("posY1", posY1);
    maskShader.set("posY2", posY2);

    maskShader.set("w0", w0);
    maskShader.set("w1", w1);
    maskShader.set("w2", w2);

    maskShader.set("h0", h0);
    maskShader.set("h1", h1);
    maskShader.set("h2", h2);

    maskShader.set("s0", s0);
    maskShader.set("s1", s1);
    maskShader.set("s2", s2);

    maskShader.set("cosT0", cosT0);
    maskShader.set("cosT1", cosT1);
    maskShader.set("cosT2", cosT2);

    maskShader.set("sinT0", sinT0);
    maskShader.set("sinT1", sinT1);
    maskShader.set("sinT2", sinT2);
  }

  void getJSON(JSONObject obj) {

    id = obj.getInt("id");

    sclrand= obj.getFloat("sclrand");
    rndX = obj.getFloat("rndX");
    rndY = obj.getFloat("rndY");

    posX0 = obj.getFloat("posX0");
    posX1 = obj.getFloat("posX1");
    posX2 = obj.getFloat("posX2");

    posY0 = obj.getFloat("posY0");
    posY1 = obj.getFloat("posY1");
    posY2 = obj.getFloat("posY2");

    w0= obj.getFloat("w0");
    w1= obj.getFloat("w1");
    w2= obj.getFloat("w2");

    h0 = obj.getFloat("h0");
    h1= obj.getFloat("h1");
    h2= obj.getFloat("h2");

    s0 = obj.getFloat("s0");
    s1 = obj.getFloat("s1");
    s2 = obj.getFloat("s2");

    cosT0 = obj.getFloat("cosT0");
    cosT1 = obj.getFloat("cosT1");
    cosT2 = obj.getFloat("cosT2");

    sinT0 = obj.getFloat("sinT0");
    sinT1 = obj.getFloat("sinT1");
    sinT2 = obj.getFloat("sinT2");
  }


  ///////////////////////FIN AC/////////////////////////////////////////////
}
