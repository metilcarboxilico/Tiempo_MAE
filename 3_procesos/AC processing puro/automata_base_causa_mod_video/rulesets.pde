

float actualizarCelula_test( int rules, float actual, float n, float ne, float e, float se, float s, 
  float so, float o, float no, float x, float y ) {

  float suma=n+ne+e+se+s+so+o+no; //sin la propia celula

  switch(rules) {

    case(1):
    if (actual<30) {
      actual =random(160);
    } else if (actual<30) {
      actual=(suma)/8;
    } else if (((suma)/8)>220) {
      actual =random(45);
    } else if (((suma)/8)>210) {
      actual =random(255);
    } else if (((suma)/8)>165) {
      actual =random(220, 255);
    } else if (((suma)/8)>140) {
      actual =random(110, 180);
    } else {
      actual-=.4;
    }

    break;

    case(2):

    break;



  default:

    break;


  }
      float proximo = actual;
    return proximo;

}
