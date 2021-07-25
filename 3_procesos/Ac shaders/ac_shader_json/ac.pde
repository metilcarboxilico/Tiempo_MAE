
class Ac {


  int w = int(random(width));
  int h = int(random(height));
  int id;
  boolean isRulRange= false;
  float posX, posY;

  float vida;
  float cnt=0.0;
  // double norm =1.0/255; //estudiar el pasaje a doble?
  PShader maskShader;
  PShader ac;

  PGraphics pg;
  PGraphics base;
  //PImage img;
  PImage salida;


  String path;

  int   modulo ;

  float scale;
  float rotate;

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


 float rulRange[];
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
/*
  float resul[]={
    (float)(norm*0.1*random(160)), 
    (float)(norm*random(180)), 
    (float)(norm*random(110, 180)), 
    (float)(norm*random(220, 255)), 
    (float)(norm*random(255)), 
    (float)(norm*random(45))
  };
*/

  Ac(JSONObject json_) {

    pg = createGraphics(w, h, P2D);
    pg.noSmooth();
    base = createGraphics(w, h, P2D);
    base.noSmooth();

    posX= random(width/2);//setearlo desde json
    posY= random(height/2);

    //img = loadImage("pantallaverde.jpg");//tendria que omiir esta carga
    //actualizar luego con la funcion de cargar capeta desde el path?
    //o generar una funcion display q la reciba desde afuera?

    salida = createImage(w, h, RGB);
    //salida.copy(img, 0, 0, w, h, 0, 0, w, h);

    //seteo por via json del
    setJSON(json_);

    maskShader = loadShader("mask json mid.glsl");
    maskShader.set("resolution", float(w), float(h));

    setMask();

 //resetShader();
    //seteo del sahder del automata celular
    if(isRulRange) ac = loadShader("ac arrayrand.glsl");
    else ac = loadShader("ac array.glsl");
    //ac.set("modulo", modulo);

    ac.set("resolution", float(pg.width), float(pg.height));  
    ac.set("resul", resultado);
    ac.set("rules", rulset);
    ac.set("dft", (float)(norm*-255*10));
  }

  void setMask() {


    //maskShader.set("scl", scale);
    //maskShader.set("rotate", rotate);
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

  void setJSON(JSONObject obj) {
    //para el ac en general
    //path = obj.getString("path");
   // modulo = obj.getInt("modulo");//omitidisimos
   
   
    id = obj.getInt("id");

    //para la mascara
    //scale = obj.getFloat("scale");
   // rotate = obj.getFloat("rotate");

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


  void actualizar() {

    cnt +=1;

    ac.set("time", millis()/1000.0);
    ac.set("frame", float(frameCount));
    ac.set("iniciar", cnt);

    maskShader.set("time", millis()/1000.0);
  }

void reShader(){
    pg.beginDraw();
    pg.resetShader();
    pg.endDraw();
}


  void dibujar(PImage img_) {
    this.dibujar(img_, posX, posY, width/3, height);
  }


 void dibujar(PImage img_,float x_, float y_) {
     //dibujar(img_, x_,  y_, 100, 100 ); 
     this.dibujar(img_, x_,  y_, img_.width, img_.height ); 

 }
 
 
  void dibujar(PImage img_,float x_, float y_, float w_, float h_) {
    //background(170);

    pg.beginDraw();
    pg.background(0);
    pg.shader(ac);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
    //creo q vot a tener que poner todo dentro de otro pg
    //shader(maskShader); 
    
    //salida = createImage(w, h, RGB);
    salida.copy(img_, 0, 0,  pg.width, pg.height, 0, 0,  pg.width, pg.height);
   
    salida.mask(pg);

    base.beginDraw();
    base.background(0);
    base.shader(maskShader);
    base.endDraw();
   
    base.mask(base);
    
    //aunque parezca poco ideal me ahorre crear un pg 
    //y pronto pensare como afectar correctamente el canal alfa dentro del shader, 
    base.beginDraw();
    base.image(salida, 0, 0, pg.width, pg.height);
    base.endDraw();
    
    //base.mask(base);
    
    image(base, x_, y_, w_, h_);

  }













  boolean isDead() {
    if (vida<=0) {
      return true;
    } else {
      return false;
    }
  }



  ///////////////////////FIN AC/////////////////////////////////////////////
}
