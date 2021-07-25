


//import controlP5.*;
//ControlP5 cp5;

//import processing.video.*;
import java.io.File;

final double norm =1.0/255; //normalizacion del 255 si se usa otro rango del espacio color aqui se ajusta ejemplo rgb 100 => 1./100

String jsonName ="data-mid.json"; 
// con 3 obj 38.5 FrameRate -26.5 ms de ejecucion 
//con 12 obj frameRate a 15 y 66ms de ejecucion
//el limite recomendable de obj es de 15/16 y a 12 fR 81.5 ms
//con 45 instancias 8 fR  215 ms 

JSONArray values;

PImage[] listImg;

HashMap<Integer, FloatList> minmax ;
HashMap<Integer, FloatList> rul ;
HashMap<Integer, FloatList> resul ;

ArrayList<Ac> acList;

boolean recording= false;
boolean unlock = true;




int rFuturoMin =70, rFuturoMax =140;
int contador=0, estadoFuturoLoc = int(random(7, 14));
int mPos;


FloatList locTempX = new FloatList();
FloatList locTempY = new FloatList();
FloatList tamTempX = new FloatList();
FloatList tamTempY = new FloatList();


//String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/ac_shader_final_compilar/data/img";
//String path="F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/procesos/cargar_carpeta/data/img";

//String regex ="(.png|.PNG)";
//String regex ="(.jpg|.JPG)";



void setup() {
  size(1000, 1000, P3D);  
  surface.setTitle("AC");
  surface.setLocation(100, 0);
  
  
//  cp5 = new ControlP5(this);
//cp5.addFrameRate().setInterval(10).setPosition(0, height - 10).setColor(#FF0000);
  
  randomSeed(2021);
  frameRate(10);

  //cargo los rulsets desde csv
  minmax = cargarRangeRul();
  rul = cargarRul();
  resul = cargarResul();

  //genero instancias desde json
  values = loadJSONArray(jsonName);
  acList = new ArrayList<Ac>(); 
  for (int i = 0; i < values.size(); i++) {
    print("\n");
    JSONObject obj = values.getJSONObject(i); 
    acList.add(new Ac(obj) );
  }
  print(values.size(), "\n");


  StringList jpg;
 // jpg = listDirRegex( path, regex);

  listImg = new PImage[54] ;
  for (int i= 0; i< 54; i++)
  {listImg[i] = loadImage("a/"+str(i)+".jpg");
}
  // println("jpg ",i," : ",jpg.get(i));



  //setDefault(float dft_)
  //seteo a ac
  for (int i=0; i< acList.size(); i++) {
    int rand = int(random(5));

    acList.get(i).setRange(normalizar(devolver(minmax, 1)));
    acList.get(i).setRul(normalizar(devolver(rul, rand)));
    acList.get(i).setResultado(normalizar(devolver(resul, rand)));

    acList.get(i).setAcShader();
    //printArray(acList.get(i).rulRange);
    //printArray(acList.get(i).rulset);
    // printArray(acList.get(i).resultado);
  }


  for (int i=0; i< acList.size(); i++) {
    float rad = random(TAU);
    locTempY.append(350 *randomGaussian()*sin(rad)+height/2);
    locTempX.append(350 *randomGaussian()*cos(rad)+width/2);
    tamTempX.append(abs(200*randomGaussian())+500);
    tamTempY.append(abs(200*randomGaussian())+500);
  }

  //---------fin setup----------------------
  contador = int(random(listImg.length));
  image(listImg[contador%listImg.length], 0, 0, width, height);
}
//    image(listImg[contador%listImg.length],width/2,height/2,width,height);




void draw() {
 // background(100);
  /*
  if (frameCount%estadoFuturo==0) {
   estadoFuturo= int(random(5, 50));
   }
   */
   
  // double a=0,b=0,c=0;
  //a=millis();

  if (frameCount%estadoFuturoLoc==0 && unlock) {
    //   for (int i=acList.size()-1; i>=0; i--) {
    //    locTempX.set(i, 150 *randomGaussian()+width/2);
    //    locTempY.set(i, 150*randomGaussian()+height/2) ;
    //    tamTempX.set(i, abs(250*randomGaussian())+width/2);
    //    tamTempY.set(i, abs(250*randomGaussian())+height/2);
    //   }

    for (int i=0; i< acList.size(); i++) {
      float rad = random(TAU);
      // locTempY.set(i,random(height/2) *sin(rad)+height/2); //*randomGaussian()
      //locTempX.set(i,random(width/2) *cos(rad)+width/2);//*randomGaussian()
      locTempX.set(i, 350 *randomGaussian()*cos(rad)+width/2);
      locTempY.set(i, 350 *randomGaussian()*sin(rad)+height/2);
      tamTempX.set(i, abs(200*randomGaussian())+500);
      tamTempY.set(i, abs(200*randomGaussian())+500);
      // println(locTempX,locTempY);
    }

/*
    for (int i=0; i< acList.size(); i++) {
      int rand = int(random(5));

      acList.get(i).setRange(normalizar(devolver(minmax, 1)));
      acList.get(i).setRul(normalizar(devolver(rul, rand)));
      acList.get(i).setResultado(normalizar(devolver(resul, rand)));
//acList.get(i).resetCtn();
      acList.get(i).setAcShader();
      //printArray(acList.get(i).rulRange);
      //printArray(acList.get(i).rulset);
      // printArray(acList.get(i).resultado);
    }*/
    estadoFuturoLoc = int(random(rFuturoMin, rFuturoMax));
    contador++;
    /*
    for (int i=acList.size()-1; i>=0; i--) {
     acList.get(i).setZoomAcX(random(0.5, 2.5));
     acList.get(i).setZoomAcY(random(0.5, 2.5));
     acList.get(i). setZoomImgX(random(0.5, 2.5));
     acList.get(i).setZoomImgY(random(0.5, 2.5));
     }
     */
  }

  mPos= int(map(mouseX, 0, width, 1, acList.size()));

  //for (int i=acList.size()-1; i>=0; i--) {  //en caso de usar remove
  for (int i=0; i< acList.size(); i++) { //mPos
    Ac acTemp = acList.get(i);
    acTemp.actualizar();
    //acTemp.dibujar();
    float dist=width/acList.size();
    imageMode(CENTER);

    acTemp.dibujar(listImg[(contador+acTemp.id)%listImg.length], locTempX.get(i), locTempY.get(i), tamTempX.get(i), tamTempY.get(i));

    //  if(i<0){
    // acTemp.dibujar(listImg[(contador+acTemp.id)%listImg.length],  width/2, height/2, tamTempX.get(i), tamTempY.get(i));
    //dist*i, dist*i, tamTempX.get(i), tamTempY.get(i));
    /*  }else{
     
     acTemp.dibujar(listImg[(contador+acTemp.id)%listImg.length],locTempX.get(i), locTempY.get(i), tamTempX.get(i), tamTempY.get(i));
     //dist*i, dist*i, tamTempX.get(i), tamTempY.get(i));
     
     }*/



    //if(acTemp.isDead()) acList.remove(i);
  }

  //b=millis();
  
 // c=b-a;
  
  //println("tiempos inicio: " , a,", fin: ", b ,", ejecucion en ms: ",c );
  //println("ejecucion en ms: ",c );
  
  if (recording) saveFrame("output/secuencia/secuencia_####.png");
}




void keyPressed() {
  if (key  =='r'||key =='R')  recording= !recording;
  if (key == 'c'||key =='C') saveFrame("output/capturas/####.png");
  if (key == 'l'||key =='L') unlock = !unlock;
}
/*for (int i=acList.size()-1; i>=0; i--) {
 acList.get(i).
 }*/
void mousePressed() {
  println(mPos);
}
void mouseReleased() {
}
