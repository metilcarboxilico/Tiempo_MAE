

/*
tomando codigo de Daniel Shiffman 
y proximamente de Emiliano Causa

*/


AC ac;

void setup() {
  size(640, 360);
  ac = new AC();
}

void draw() {
  background(255);

  ac.generate();
  ac.display();
}

// reset board when mouse is pressed
void mousePressed() {
  ac.init();
}
