
import processing.video.*;
/*
tomando codigo de Daniel Shiffman 
 y proximamente de Emiliano Causa
 
 */


AC ac;
PImage a,b,c,d;
//char[]={a,b,c}
//Movie a, b, c, d;
boolean recording=false;

void setup() {
  size(900, 900,P2D);// inviable cualquier size, pero ya en formatos medios nisiquiera arranca
  frameRate(7);
  ac = new AC();
 a = loadImage("a.jpg");
  b = loadImage("d.jpg");
 c = loadImage("c.jpg");
 d = loadImage("b.jpg");

/*
  a= new Movie(this, "a.mp4");
  a.loop();
  a.frameRate(20);
  a.volume(0);

  b= new Movie(this, "b.mp4");
  b.loop();
  b.frameRate(2);
  b.volume(0);

  c= new Movie(this, "c.mp4");
  c.loop();
  c.frameRate(30);
  c.speed(.2);
  c.volume(0);


  d= new Movie(this, "d.mp4");
  d.loop();
  d.frameRate(5);
  d.volume(0);
  */
  
}
/*
void movieEvent(Movie m) {
  m.read();
}
*/
void draw() {
 // background(255);

  ac.generate();
  ac.display();
  if (recording) {
    saveFrame("output/secuencia/secuencia_####.png");
  }
}

// reset board when mouse is pressed
void mousePressed() {
  ac.init();
}

void keyPressed() {

  if (key  =='r'||key =='R')  recording= !recording;
  if (key=='c')  saveFrame("output/capturas/####.png");
  
}
