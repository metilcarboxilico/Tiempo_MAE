

float actualizarCelula_test( int rules, float actual, float n, float ne, float e, float se, float s, 
  float so, float o, float no, float x, float y ) {

  int count=0;
  float suma=n+ne+e+se+s+so+o+no; //sin la propia celula

  if (rules==0) {
    if (actual<30)actual =random(160);
    //else if (actual<30) actual=(suma)/8;
    else if (((suma)/8)>220) actual =random(45);
    else if (((suma)/8)>210) actual =random(255);
    else if (((suma)/8)>165) actual =random(220, 255);
    else if (((suma)/8)>140) actual =random(110, 180);
    else actual-=.4;
  } else if (rules==1) {
    if (suma<30)actual -=2;
    else if (suma/8<70) actual+=random(-50, 5);
    else if (suma/8<140) actual+=random(-25, 25);
    else if (suma/8<200) actual+=random(-15, 35);
    else if (suma/8<220) actual+=random(-5, 35);
    else actual=random(10, 255);
    ;
  } else if (rules==2) {
    if (suma<30)actual -=2;
    else if ((suma+actual)/8<70) actual+=random(-50, 5);
    else if ((suma+actual)/8<140) actual+=random(-25, 25);
    else if ((suma+actual)/8<200) actual+=random(-15, 35);
    else if ((suma+actual)/8<220) actual+=random(-5, 35);
    else actual=random(10, 255);
    ;
  } else if (rules==3) {//este frame count podria generar alguna explosion o algo segun un random? ampliar experimento
    if (frameCount%20==0) {
      if (random(1)<.001) actual=255;
    } else if (suma<30)actual -=2;
    else if ((suma+actual)/8<70) actual+=random(-50, 5);
    else if ((suma+actual)/8<140) actual+=random(-25, 25);
    else if ((suma+actual)/8<200) actual+=random(-15, 35);
    else if ((suma+actual)/8<220) actual+=random(-5, 35);
    else actual=random(10, 255);
    ;
  } else if (rules==4) {
    if (n<150)count++;
    if (ne<150)count++;
    if (e<150)count++;
    if (se<150)count++;
    if (s<150)count++;
    if (so<150)count++;
    if (o<150)count++;
    if (no<150)count++;

    if (count==3)actual=255;
    else if (count==4)actual=180;
        else if (count<=5)actual=30;
    else actual=0;

    
  } else if (rules==5) {
  } else if (rules==6) {
  } else if (rules==7) {
  } else if (rules==8) {
  } else if (rules==9) {
  } else {
  }
  float proximo = actual;
  return proximo;
}
