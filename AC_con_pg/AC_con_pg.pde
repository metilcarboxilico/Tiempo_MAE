
import processing.video.*;
import java.io.File;



//definición 
Conjunto conjunto;
Conjunto conjunto2;
Conjunto conjunto3;


float off, offX=0, offY=0;// por ahi generar un array de offset dentro de la clase
polyRetorcido polyAgitado;
AutomataCelular automata;

Movie[] listMovie;
//PGraphics[] pgArrayMovie;
PImage[] listImg;

boolean recording=false, flag =true;
PGraphics pgMovie;


void setup() {
  size( 1000, 800,P3D);//, FX2D ); // el pg funciona mejor con el render std ?
  surface.setTitle("AC con video");
  surface.setLocation(100, 100);


//esto es donde estan las imgs o losvideos
  String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/cargar_carpeta/data/img";
  //   String path =   "F:/imagenes/fotos/villacrespo";
  String regex ="(.jpg|.JPG)";

  StringList jpg, movie;
  jpg = listDirRegex( path, regex);

  // movie = listDirRegex( "F:/videos/Captures/A10", ".mp4");
  //  listMovie = new Movie[movie.size()] ;


  listImg = new PImage[jpg.size()] ;
  for (int i= 0; i< jpg.size(); i++) listImg[i] = loadImage(path+"/"+jpg.get(i));   // println("jpg ",i," : ",jpg.get(i));
  /*
  for (int i= 0; i< movie.size(); i++) {//movie.size()
   listMovie[i]= new Movie(this, "F:/videos/Captures/A10"+"/"+movie.get(i));
   listMovie[i].loop();
   //listMovie[i].speed(.2);
   listMovie[i].volume(0);// no sirve multiples videos con audio
   listMovie[i].read();
   }//comvinar todo en un array list no me permitiria animarel sonido ni la velocidad en los videos pero permitiria mostrar indistintamente img y video
   //el sonido es una cagada en simultaneo no se si vale la pena, se rompe todo 
   
   */


  frameRate(15);
  noStroke();



  int mW = 400; 
  int mH =400;

  // AC : x/y/w/h/resolucion (en enteros basicamente la res== a tam de la celula  (cant px lienzo/res) 

  pgMovie = createGraphics(mW, mH);
  //alguan estrategia para variar la definicion a posteriori?
  //un n que modifique el array que se recorre y q agrande el rect?
  automata = new AutomataCelular(0, 0, mW, mH, 1);
  polyAgitado= new   polyRetorcido(mW, mH, mW/4, 0, 7, 13);
  //alguna estrategia similar par el poly
  //como pienso el pasaje de recMod a poly? es viable?

  //como definir facilmente los estados finito? cambiando y setiando ?

  conjunto = new Conjunto(255, width/2, height/2);
  conjunto2 = new Conjunto(255, 600, 600);
  conjunto3 = new Conjunto(250, 700, 700);
}




void movieEvent(Movie m) {
  m.read();
}


int contador, estadoFuturo=int(random(5, 50));
void draw() {

  //(video.time()>=video.duration()-.1)video.jump(0);


  background(0);// pensar mejor el fondo



  if (frameCount%estadoFuturo==0) {
    estadoFuturo= int(random(5, 50));
    contador++;
  }
  
  
  
  int noi= int(map(noise(off+100), 0, 1, 0, width));
  int noi2= int(map(noise(off), 0, 1, 0, height/2));

  //pushStyle();
  //imageMode(CENTER);
  conjunto.actualizar();

  conjunto.display(listImg[contador%listImg.length], -10, -10, width, height);//contador%listMovie.length  

  conjunto2.actualizar();
  
  

  
  conjunto2.display(listImg[(contador+5)%listImg.length], 455, 300);//contador%listMovie.length
  conjunto2.display(listImg[(contador+2)%listImg.length], 20, 40);//contador%listMovie.length
  conjunto2.display(listImg[(contador+7)%listImg.length], noi-130, 100);//contador%listMovie.length
  
  
    conjunto3.actualizar();
    //println(conjunto3.isDead());
  if (conjunto3.isDead() !=true) {
    conjunto3.display(listImg[(contador+9)%listImg.length], noi, noi2);//contador%listMovie.length
    conjunto3.display(listImg[(contador+20)%listImg.length], 200, 40);//contador%listMovie.length
  }
  //popStyle();

  /*
  
   polyAgitado.reArray();
   //polyAgitado.noisePolyX( 0.1, -5, 5, offX*0.1+randomGaussian()); // optimas frecuncas 0.1 a .9? 
   // polyAgitado.senoPoly( -11.55, 0.9, -offY); // esta puede ir
   //  polyAgitado.senoPoly( -5.8, 0.1, -offY); // esta puede ir
   polyAgitado.noisePolyY(0.3, -50, 50, -offY);
   // polyAgitado.cosenoPolyY(12.33, 0.1022, offY);
   //  polyAgitado.cosenoPoly(2, 2.5, offX) ;  
   polyAgitado.noisePolyX(0.1, -50, 50, offX);
   polyAgitado.noisePolyY( 0.3, -50, 50, offY);
   
   automata.actualizar();
   
   
   //filter(BLUR, 2);
   pgMovie.beginDraw();
   //pgMovie.imageMode(CENTER); //de esta puedo regular el tamaño desde el centro del automata
   //pgMovie.image(listImg[frameCount%listImg.length], 0, 0, pgMovie.width, pgMovie.height); //a
   pgMovie.image(listMovie[contador%listMovie.length], 0, 0, pgMovie.width, pgMovie.height); //a
   if(frameCount%estadoFuturo==0){
   estadoFuturo= int(random(5,50));
   contador++;
   }
   
   pgMovie.endDraw();
   
   
   polyAgitado.backgroundPG(0);
   polyAgitado.fillPG(#FFFFFF);
   
   
   //devuelven PGs y estoy obligado a este paso
   PGraphics mascaraAC =  automata.dibujar(); 
   PGraphics mascaraForma =polyAgitado.displayPG();
   
   mascaraAC.beginDraw();
   mascaraAC.loadPixels();
   mascaraForma.loadPixels();
   for (int i=0; i<mascaraAC.pixels.length; i++) {
   if (mascaraForma.pixels[i]==color(0))mascaraAC.pixels[i]=0;
   }
   mascaraAC.updatePixels();
   mascaraAC.endDraw();
   
   pgMovie.mask(mascaraAC);
   
   image(pgMovie, 0, 0, width/2, height/2);
   //desde PGraphics? masc hasta aca ´podria pensar en una funcion
   
   image(mascaraAC, 0, height/2, width/2, height/2);
   image(mascaraForma, width/2, height/2, width/2, height/2);
   image(listMovie[contador%listMovie.length], width/2, 0, width/2, height/2);
   //image(a, width/2, 0, width/2, height/2);
   
   
   //esto tendria que estar dentro de la calse
   offX+=.05; 
   offY+=.5;
   */

  off+=0.1;
  if (recording) saveFrame("output/secuencia/secuencia_####.png");
}

void keyPressed() {
  if ( key == ' ' )  automata.iniciar();
  if (key  =='r'||key =='R')  recording= !recording;
  if (key == 'c'||key =='C') {
    saveFrame("output/capturas/####.png");
  }

  if (key == '0') automata.selecRulset(0);//esto estaria dentro de la master clase
  if (key == '1') automata.selecRulset(1);
  if (key == '2') automata.selecRulset(2);
  if (key == '3') automata.selecRulset(3);
  if (key == '4') automata.selecRulset(4);
  if (key == '6') automata.selecRulset(6);
}


void exit() {
  for (int i= 0; i< listMovie.length; i++) listMovie[i].stop();
}

//quizas llevarlo a una clase mejor y
//luego a una mega funcion mas que controle todo o solo con un array de esta clase estare bien?
