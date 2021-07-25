
//forkeado de un ejemplo que me paso Leo Nuñez

PShader conway;
PGraphics pg;
PImage foto;
PImage salida;

void setup() {
  size(400, 400, P3D);    //2d o 3d ? o es indiferente para el shader
  //pg = createGraphics(400, 400, P3D);
   pg=degradeCentral(400, 400);

  //pg.noSmooth();
  conway = loadShader("achot.glsl");//achot.glsl  // conway.glsl
  conway.set("resolution", float(pg.width), float(pg.height));  
  foto = loadImage("imagen.jpg");
  salida = createImage(400, 400, RGB);
  salida.copy(foto, 0, 0, 400, 400, 0, 0, 400, 400);
  pg.beginDraw();
  pg.shader(conway);
    pg.endDraw();

}

void draw() {
  //loop();
  background(0);

 // for(int i=0;i<302;i++){

  //conway.set("time", millis()/1000.0);
  float x = map(mouseX, 0, width, 0, 1);
  float y = map(mouseY, 0, height, 1, 0);
  //conway.set("mouse", 0.5, 0.5);  
  conway.set("textura", pg);//esto no se si va

  
  pg.beginDraw();
  pg.background(0); //esto es vital pero no se por que 
  pg.shader(conway);
  pg.rect(0, 0, pg.width, pg.height); //esto es vital pero no se por que 
  pg.endDraw();

  //salida.blend(pg, 0, 0, 400, 400, 0, 0, 400, 400, DARKEST);
  salida.mask(pg);
  image(salida, 0, 0, width, height);
 // }
 // degradeCentral() ;
}


void mousePressed() {
  //conway.set("time", millis()/1000.0);
  for (int i = 0; i<10; i++) {
    float x = map(mouseX, 0, width, 0, 1) + random(-0.05, 0.05);
    float y = map(mouseY, 0, height, 1, 0) + random(-0.05, 0.05);
    //conway.set("mouse", x, y);

    pg.beginDraw();
    pg.background(0);
    pg.shader(conway);
    pg.rect(0, 0, pg.width, pg.height);
    pg.endDraw();
  }
}
