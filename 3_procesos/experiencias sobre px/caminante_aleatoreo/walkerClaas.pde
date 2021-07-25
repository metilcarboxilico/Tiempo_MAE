class RandomVideoWalker {

  ArrayList <Integer> posX;
  ArrayList <Integer> posY;
//¿hacerlo con un array finito y asi poder buscar repaticiones?
  Movie video;
  int x, y;
  color c=color(255);
  RandomVideoWalker(int x_, int y_, Movie video_) {// hacer que pase el video o solo el path y cargalo?

    posY= new ArrayList<Integer>();
    posX= new ArrayList<Integer>();
    x=int(random(x_));
    y=int(random(y_));
    video =video_;
  }


  void movimiento() {
    x+=random(-4, 4);
    y+=random(-4, 4); 

    if (x<0) x=int(random(0, width)); //que se teletrasporte, pensar en otros posible movimientos
    if (x>width) x=int(random(0, width)); 
    if (y<0) y=int(random(0, height)); 
    if (y>height) y=int(random(0, height)); 

    posX.add(x);
    posY.add(y);
  }

  void controlCantidad(int len_) {
    if (posX.size()>len_) {
      for (int r=posX.size()-len_; r>-1; r--) {
        posX.remove(r);
        posY.remove(r);

    }
    }
  }

  void display() {

    for (int pv=0; pv<posX.size(); pv++ ) {
      color c= video.get(posX.get(pv), posY.get(pv));
      noStroke();
      fill(c);
      circle(posX.get(pv), posY.get(pv), 2);//rect,etc
    }
  }
}
