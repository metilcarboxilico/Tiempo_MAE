
void gui() {

  cp5 = new ControlP5(this);
  cp5.addFrameRate().setInterval(10).setPosition(0, height - 10).setColor(#FF0000);

  Group g0 = cp5.addGroup("basicos")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(250)
    ;

  cp5.addBang("save_config")
    .setPosition(10, 25)
    .setSize(100, 30)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .moveTo(g0)
    //.plugTo(this, "shuffle");
    ;
  cp5.addBang("seteo")
    .setPosition(10, 75)
    .setSize(100, 30)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .moveTo(g0)
    //.plugTo(this, "shuffle");
    ;
  cp5.addBang("reseteo_shader")
    .setPosition(10, 125)
    .setSize(100, 30)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .moveTo(g0)
    //.plugTo(this, "shuffle");
    ;    
  cp5.addBang("invertir_ac")
    .setPosition(10, 175)
    .setSize(100, 30)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .moveTo(g0)
    //.plugTo(this, "shuffle");
    ;
  //group number 2, contains a radiobutton
  Group g1 = cp5.addGroup("Bias")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(300)
    ;
  cp5.addSlider("bias1")
    .setPosition(10, 20)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)    
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias2")
    .setPosition(10, 45)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias3")
    .setPosition(10, 60)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)    
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias4")
    .setPosition(10, 85)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias5")
    .setPosition(10, 110)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)      
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias6")
    .setPosition(10, 135)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)    
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias7")
    .setPosition(10, 160)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias8")
    .setPosition(10, 185)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("bias9")
    .setPosition(10, 210)
    .setSize(100, 20)
    .setRange(-5.0, 5.0)
    .setValue(1.0)      
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;
  cp5.addSlider("divisor")
    .setPosition(10, 235)
    .setSize(100, 20)
    .setRange(1.0, 9.0)
    .setValue(8.0)     
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g1)
    ;

  Group g2 = cp5.addGroup("MinMax")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(300)
    ;

  range0 = cp5.addRange("minMax0")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 20)
    .setSize(250, 40)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range1 = cp5.addRange("minMax1")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 60)
    .setSize(250, 40)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range2 = cp5.addRange("minMax2")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 100)
    .setSize(250, 40)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range3 = cp5.addRange("minMax3")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 140)
    .setSize(250, 40)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range4 = cp5.addRange("minMax4")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 180)
    .setSize(250, 40)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range5 = cp5.addRange("minMax5")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 220)
    .setSize(220, 40)
    .setHandleSize(10)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;


  //group number 3, contains a bang and a slider
  Group g3 = cp5.addGroup("default")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;
  cp5.addSlider("dft")
    .setPosition(60, 50)
    .setSize(100, 20)
    .setRange(-1.,1.)
    .setValue(0.0)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g3)
    ;


  Group g4 = cp5.addGroup("resultados")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200)
    ;
  cp5.addSlider("resultado0")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(10)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g4)
    ;
  cp5.addSlider("resultado1")
    .setPosition(10, 40)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(20)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g4)
    ;
  cp5.addSlider("resultado2")
    .setPosition(10, 70)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(45)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g4)
    ;
  cp5.addSlider("resultado3")
    .setPosition(10, 100)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(120)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g4)
    ;
  cp5.addSlider("resultado4")
    .setPosition(10, 130)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(200)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g4)
    ;
  cp5.addSlider("resultado5")
    .setPosition(10, 160)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(250)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g4)
    ;

  Group g5 = cp5.addGroup("rulsets")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200)
    ;
  cp5.addSlider("rulset0")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(25)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g5)
    ;

  cp5.addSlider("rulset1")
    .setPosition(10, 40)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(65.)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g5)
    ;
  cp5.addSlider("rulset2")
    .setPosition(10, 70)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(90)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g5)
    ;

  cp5.addSlider("rulset3")
    .setPosition(10, 100)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(130)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g5)
    ;
  cp5.addSlider("rulset4")
    .setPosition(10, 130)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(190)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g5)
    ;

  cp5.addSlider("rulset5")
    .setPosition(10, 160)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(220)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g5)
    ;
  Group g6 = cp5.addGroup("zooms")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;

  cp5.addSlider("zoomX")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(0.2, 5)
    .setValue(1.)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g6)
    ;
  cp5.addSlider("zoomY")
    .setPosition(10, 40)
    .setSize(100, 20)
    .setRange(0.2, 5)
    .setValue(1.)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g6)
    ;
  cp5.addSlider("zoomXac")
    .setPosition(10, 70)
    .setSize(100, 20)
    .setRange(0.2, 5)
    .setValue(1.)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g6)
    ;
  cp5.addSlider("zoomYac")
    .setPosition(10, 100)
    .setSize(100, 20)
    .setRange(0.2, 5)
    .setValue(1.)   
    .setColorBackground(back) 
    .setColorActive(active) 
    .setColorForeground(fore) 
    .setDecimalPrecision(3)
    .moveTo(g6)
    ;
  //create a new accordion
  //add g1, g2, and g3 to the accordion.
  accordion = cp5.addAccordion("acc")
    .setPosition(40, 40)
    .setWidth(250)
    .addItem(g0)
    .addItem(g1)
    .addItem(g2)
    .addItem(g3)
    .addItem(g4)
    .addItem(g5)
    .addItem(g6)
    ;

  //----------------------------------------
  accordion.setCollapseMode(Accordion.MULTI);
  //accordion.open(0);
}
void controlEvent(ControlEvent theControlEvent) {

  //range[i] = cp5.addRange("rangeController"+str(i))
  //range[i] = cp5.addRange("rangeController"+str(i))
  if (theControlEvent.isFrom("minMax0")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    min0 = theControlEvent.getController().getArrayValue(0);
    max0 = theControlEvent.getController().getArrayValue(1);
    println("min y max ", min0, " ", max0);
    float temp[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
    minMaxArray = temp;
  }  //range[i] = cp5.addRange("rangeController"+str(i))
  if (theControlEvent.isFrom("minMax1")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    min1 = theControlEvent.getController().getArrayValue(0);
    max1 = theControlEvent.getController().getArrayValue(1);
    println("min y max ", min1, " ", max1);
    float temp[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
    minMaxArray = temp;
  }  //range[i] = cp5.addRange("rangeController"+str(i))
  if (theControlEvent.isFrom("minMax2")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    min2 = theControlEvent.getController().getArrayValue(0);
    max2 = theControlEvent.getController().getArrayValue(1);
    println("min y max ", min2, " ", max2);
    float temp[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
    minMaxArray = temp;
  } 
  //range[i] =cp5.addRange("rangeController"+str(i))
  if (theControlEvent.isFrom("minMax3")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is atindex 0, max is at index 1.
    min3 = theControlEvent.getController().getArrayValue(0);
    max3 = theControlEvent.getController().getArrayValue(1);
    println("miny max ", min3, " ", max3);
    float temp[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
    minMaxArray = temp;
  }
  //range[i] = cp5.addRange("rangeController"+str(i))
  if (theControlEvent.isFrom("minMax4")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    min4 = theControlEvent.getController().getArrayValue(0);
    max4 = theControlEvent.getController().getArrayValue(1);
    println("min y max ", min4, " ", max4);
    float temp[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
    minMaxArray = temp;
  } 
  // range[i] = cp5.addRange("rangeController" + str(i))
  if (theControlEvent.isFrom("minMax5")) {
    // min and max values are stored in an array.
    // access this arraywith controller().arrayValue().
    // min is at index 0, max is at index 1.
    min5 = theControlEvent.getController().getArrayValue(0);
    max5 = theControlEvent.getController().getArrayValue(1);
    println("min y max ", min5, " ", max5);
    float temp[] = {min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
    minMaxArray = temp;
  }
}

/*

 float min0=0.0, min1=0.0, min2=0.0, min3=0.0, min4=0.0, min5=0.0;
 float max0=0.0, max1=0.0, max2=0.0, max3=0.0, max4=0.0, max5=0.0;
 float minMaxArray[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};
 
 
 float rulset0=0.0, rulset1=0.0, rulset2=0.0, rulset3=0.0, rulset4=0.0, rulset5=0.0;
 float rulsetArray[] = {rulset0, rulset1, rulset2, rulset3, rulset4, rulset5};
 
 float resultado0=0.0, resultado1=0.0, resultado2=0.0, resultado3=0.0, resultado4=0.0, resultado5=0.0;
 float resultadosArray[] = {resultado0, resultado1, resultado2, resultado3, resultado4, resultado5};
 
 
 float bias0=0.0, bias1=0.0, bias2=0.0, bias3=0.0, bias4=0.0, bias5, bias6=0.0, bias7=0.0, bias8=0.0, divisor=8.0;
 float biasArray[] = {bias0, bias1, bias2, bias3, bias4, bias5, bias6, bias7, bias8};
 
 
 
 
 
 
 */


void resultado() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setResultado(normalizar(resultadosArray));
  }
}
void dft() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setDefault(dft);
  }
}

void divisor() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setDivisor(divisor);
  }
}
void bias() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setBias(normalizar(biasArray));
  }
}
void minmax() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setRange(normalizar(minMaxArray));
  }
}

void rulset() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setRulset(normalizar(rulsetArray));
  }
}

void seteoResRange() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).seteoResRange();
  }
}



void invertir_ac() {
  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).setAcInvert();
  }
}

void reseteo_shader() { 

  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).reShader();
  }
  reseteoCnt();
}

void reseteoCnt() { 

  for (int i = acList.size() - 1; i>= 0; i--) {
    acList.get(i).resetCtn();
  }
}




void seteo() {
  
  seteoForsoso();
  reseteoCnt();
/*
  rulset();
  //minmax();
  resultado();

  dft();
  bias();
  divisor();

  seteoResRange();
  reseteoCnt();
  */
  
}

/*
void save_config() { 
 
 }*/
