
String a ="azul,sigue siendo un signo";

void setup() {
  size(500, 500);
}


void draw() {
  /*
   textSize(1);
   println("width escalado a 1 "+textWidth(a));
   println("regla de 3 simple y el size que debe tener es: "+width/textWidth(a));
   textSize(width/textWidth(a));
   println( "texto escalado "+ textWidth(a));
   text(a, 0, 200);
   */
  txtWidthCentrado(a, width/2, 100, width/3);
  txtWidthCentrado(a, width/2, 190, width);
  txtWidthIzq(a, 0, 300, width-100);

  noLoop();
}

void txtWidthCentrado(String txt_, float x_, float y_, float ancho) {
  textAlign(CENTER, CENTER);
  txtWidthGenerica( txt_, x_, y_, ancho);
}

void txtWidthIzq(String txt_, float x_, float y_, float ancho) {
  textAlign(LEFT, CENTER);
  txtWidthGenerica( txt_, x_, y_, ancho);
}


void txtWidthGenerica(String txt_, float x_, float y_, float ancho) {
  textSize(1);
 // println("width escalado a 1 "+textWidth(txt_));
 // println("regla de 3 simple y el size que debe tener es: "+ancho/textWidth(a));
  textSize(ancho/textWidth(txt_));
 // println( "texto escalado "+ textWidth(txt_)+"\n");
  text(a, x_, y_);
}

//a.length()
//a.charAt(index);

//char 
//textWidth(char) tambien sirve individualmente
