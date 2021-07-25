
import controlP5.*;

ControlP5 cp5;

Accordion accordion;

Range range0;
Range range1;
Range range2;
Range range3;
Range range4;
Range range5;
Range dfault;

int colorMin = 100;

int colorMax = 100;
color c = color(0, 160, 100);

void setup() {
  size(400, 850);
  noStroke();
  smooth();
  frameRate(10);
  gui();
}

void gui() {

  cp5 = new ControlP5(this);
  cp5.addFrameRate().setInterval(10).setPosition(0, height - 10).setColor(#FF0000);

  Group g0 = cp5.addGroup("basicos")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200)
    ;

  cp5.addBang("save-config")
    .setPosition(10, 25)
    .setSize(100, 40)
    .moveTo(g0)
    .plugTo(this, "shuffle");
  ;
  cp5.addBang("seteo")
    .setPosition(10, 75)
    .setSize(100, 40)
    .moveTo(g0)
    .plugTo(this, "shuffle");
  ;
  cp5.addBang("reseteo-shader")
    .setPosition(10, 125)
    .setSize(100, 40)
    .moveTo(g0)
    .plugTo(this, "shuffle");
  ;
  // group number 2, contains a radiobutton
  Group g1 = cp5.addGroup("Bias")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(300)
    ;
  cp5.addSlider("bias1")
    .setPosition(10, 20)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias2")
    .setPosition(10, 45)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias3")
    .setPosition(10, 60)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias4")
    .setPosition(10, 85)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias5")
    .setPosition(10, 110)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias6")
    .setPosition(10, 135)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias7")
    .setPosition(10, 160)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias8")
    .setPosition(10, 185)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("bias9")
    .setPosition(10, 210)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;
  cp5.addSlider("divisor")
    .setPosition(10, 235)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(100)
    .moveTo(g1)
    ;

  Group g2 = cp5.addGroup("MinMax")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(300)
    ;

  range0 = cp5.addRange("rangeController0")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 20)
    .setSize(150, 40)
    .setHandleSize(20)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range1 = cp5.addRange("rangeController1")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 60)
    .setSize(150, 40)
    .setHandleSize(20)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range2 = cp5.addRange("rangeController2")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 100)
    .setSize(150, 40)
    .setHandleSize(20)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range3 = cp5.addRange("rangeController3")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 140)
    .setSize(150, 40)
    .setHandleSize(20)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range4 = cp5.addRange("rangeController4")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 180)
    .setSize(150, 40)
    .setHandleSize(20)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;

  range5 = cp5.addRange("rangeController5")
    // disable broadcasting since setRange and setRangeValues will trigger an event
    .setBroadcast(false) 
    .setPosition(10, 220)
    .setSize(150, 40)
    .setHandleSize(20)
    .setRange(0, 255)
    .setRangeValues(50, 100)
    // after the initialization we turn broadcast back on again
    .setBroadcast(true)
    .setColorForeground(color(255, 40))
    .setColorBackground(color(255, 40))  
    .moveTo(g2)
    ;


  // group number 3, contains a bang and a slider
  Group g3 = cp5.addGroup("default")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;
  cp5.addSlider("Slider-dft")
    .setPosition(60, 50)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g3)
    ;


  Group g4 = cp5.addGroup("resultados")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(200)
    ;
  cp5.addSlider("resultado0")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g4)
    ;
  cp5.addSlider("resultado1")
    .setPosition(10, 40)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g4)
    ; 
  cp5.addSlider("resultado2")
    .setPosition(10, 70)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g4)
    ;  
  cp5.addSlider("resultado3")
    .setPosition(10, 100)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g4)
    ; 
  cp5.addSlider("resultado4")
    .setPosition(10, 130)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g4)
    ; 
  cp5.addSlider("resultado5")
    .setPosition(10, 160)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
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
    .setValue(100)
    .moveTo(g5)
    ;

  cp5.addSlider("rulset1")
    .setPosition(10, 40)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(200)
    .moveTo(g5)
    ;
  cp5.addSlider("rulset2")
    .setPosition(10, 70)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(100)
    .moveTo(g5)
    ;

  cp5.addSlider("rulset3")
    .setPosition(10, 100)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(200)
    .moveTo(g5)
    ;  
  cp5.addSlider("rulset4")
    .setPosition(10, 130)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(100)
    .moveTo(g5)
    ;

  cp5.addSlider("rulset5")
    .setPosition(10, 160)
    .setSize(100, 20)
    .setRange(0, 255)
    .setValue(200)
    .moveTo(g5)
    ;
  Group g6 = cp5.addGroup("zooms")
    .setBackgroundColor(color(0, 64))
    .setBackgroundHeight(150)
    ;

  cp5.addSlider("zoomX")
    .setPosition(10, 10)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g6)
    ;
  cp5.addSlider("zoomY")
    .setPosition(10, 40)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g6)
    ;
  cp5.addSlider("zoomXac")
    .setPosition(10, 70)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g6)
    ;
  cp5.addSlider("zoomYac")
    .setPosition(10, 100)
    .setSize(100, 20)
    .setRange(100, 500)
    .setValue(200)
    .moveTo(g6)
    ;
  // create a new accordion
  // add g1, g2, and g3 to the accordion.
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



/*
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.open(0, 1, 2);
    }
  }
  , 'o');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.close(0, 1, 2);
    }
  }
  , 'c');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setWidth(300);
    }
  }
  , '1');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setPosition(0, 0);
      accordion.setItemHeight(190);
    }
  }
  , '2'); 
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.ALL);
    }
  }
  , '3');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      accordion.setCollapseMode(ControlP5.SINGLE);
    }
  }
  , '4');
  cp5.mapKeyFor(new ControlKey() {
    public void keyEvent() {
      cp5.remove("myGroup1");
    }
  }
  , '0');
*/

  // use Accordion.MULTI to allow multiple group 
  // to be open at a time.

  // when in SINGLE mode, only 1 accordion  
  // group can be open at a time.  
  // accordion.setCollapseMode(Accordion.SINGLE);
}

/*
void radio(int theC) {
  switch(theC) {
    case(0):
    c=color(0, 200);
    break;
    case(1):
    c=color(255, 0, 0, 200);
    break;
    case(2):
    c=color(0, 200, 140, 200);
    break;
    case(3):
    c=color(0, 128, 255, 200);
    break;
    case(4):
    c=color(50, 128);
    break;
  }
} 
*/
void controlEvent(ControlEvent theControlEvent) {

  //range[i] = cp5.addRange("rangeController"+str(i))
  if (theControlEvent.isFrom("rangeController")) {
    // min and max values are stored in an array.
    // access this array with controller().arrayValue().
    // min is at index 0, max is at index 1.
    colorMin = int(theControlEvent.getController().getArrayValue(0));
    colorMax = int(theControlEvent.getController().getArrayValue(1));
    println("min y max ", colorMin, " ", colorMax);
  }
}


void shuffle() {
  c = color(random(255), random(255), random(255), random(128, 255));
}


void draw() {
  background(220);

  fill(c);
  /*
  float s1 = cp5.getController("hello").getValue();
   ellipse(200, 400, s1, s1);
   
   float s2 = cp5.getController("world").getValue();
   ellipse(300, 100, s2, s2);*/
}
