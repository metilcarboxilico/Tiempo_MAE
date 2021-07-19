
PGraphics pg;

int seed=2022;
CA aut;

void setup() {
  randomSeed(seed);
  size(1200, 900);
  pg = createGraphics(width, height);

  aut = new CA();
  //111=0 110=1 101= 100=1     011=1 010=0 001=1 000=0 
  //cuando rullset se usa desde un parseInt es decir en binario, este se invierte
  aut.ruleset = reverse(new int[] {0, 0, 0, 1, 1, 1, 0, 0});
  //aut.loadGaussian();
  aut. loadRandom() ;
  noStroke();


  /* investigacion sobre como funciona el color en processing
   background(#cc5000);
   
   loadPixels();
   println(pixels[50]);
   println(pixels[50]==color(#cc5000));
   // println(Integer.parseInt(str(pixels[50]),16));
   println(Integer.toHexString(pixels[50]));
   
   */
}
float nOff=0;
void draw() {
  //println(round(constrain(randomGaussian(), 0, 1)));

  /*
noiseSeed()
   
   println("noise: "+int(map(noise(nOff),0,1,0,2)));
   println("random: "+int(random(2)));
   println("random floor: "+floor(random(1.9)));
   nOff+=0.75;
   */
  //if(aut.generation==60){


  //aut.ruleset = reverse(new int[] {int(random(2)), int(random(2)), int(random(2)), int(random(2)), int(random(2)), int(random(2)), int(random(2)), int(random(2))});

  /*
for(int g=0;g < aut.ruleset.length;g++){
   
   aut.ruleset[g] = round(constrain(randomGaussian(),0,1));
   }
   aut.ruleset = reverse(aut.ruleset);
   */
  //print("salto");
  //}
  aut.display();
  aut.generate();

  //image(pg,0,0);
  //filter(BLUR, 0.9);
}

void mousePressed() {
  // aut.loadGaussian();
  aut. loadRandom() ;
  // seed++;
  aut.generation=0;
}
void keyPressed() {

  if (key=='c') {
    String name ="";
    for (int g=0; g < aut.ruleset.length; g++) {
      name +=Integer.toString(aut.ruleset[g]);
    }
    saveFrame("output/capturas/seed-"+seed+"-rull-"+name+"--###.png");
  }
  if (key=='x') { 
    aut.loadGaussian();
    // aut. loadRandom() ;
    seed++;
    aut.generation=0;
  }
  if (key=='z') { 
    aut.loadGaussian();
    // aut. loadRandom() ;

    seed--;  
    aut.generation=0;
  }
  if (key=='n') for (int g=0; g < aut.ruleset.length; g++)aut.ruleset[g] = int(random(2));
  //imprimir el rullset en la captura, hacer un label text
}
