/**
 Sketch elaborado para el proyecto del eje tiempo _ MAE 2021
 Santiago T. Fernandez G.
 
 sistema que mezcla imagenes por medio de superpociciones 
 y mascaras animadas a partir de shaders + una carpeta de imagenes
 (cuidado q si se cargan + de 60 img o 50 intnacias en un unico bucle crashea java, a su vez sucede esto si se suben imagenes de mas de 5.5MB)  
 
 */


//estan seteadas las semillas del random (
//una semilla por cada json y pasadas a los shaders generadores de las mascaras.
//y otra general en este skecht  de la cual dependen los ritmos de cambio y las locaciones de las imgs




//import controlP5.*;
//ControlP5 cp5;


import java.io.File;

final double norm =1.0/255; 
//normalizacion del 255 si se usa otro rango del espacio color aqui se ajusta ejemplo rgb 100 => 1./100


String jsonName ="data-mid.json"; 

JSONArray values;

PImage[] listImg;



HashMap<Integer, FloatList> minmax ;//actualmente en busca de un rulset o configuracion general optimas
HashMap<Integer, FloatList> rul ;
HashMap<Integer, FloatList> resul ;

ArrayList<Ac> acList;



//boleanos para guardar video y lockear el cambio de estados de las imageness
boolean recording= false;
boolean unlock = true;


//variables para el cambio de iamgenes
/*
int rFuturoMin =10, rFuturoMax =40;
 int contador=0, estadoFuturoLoc = int(random(rFuturoMin, rFuturoMax));
 */
int[] rFuturoMin, rFuturoMax, estadoFuturoLoc, contador;


int rangoMinA=20;
int rangoMinB =50;
int rangoMaxnA = 70;
int rangoMaxnB = 120;


// variables de tamaño y locacion de las imagenes desplegadas
FloatList locTempX = new FloatList();
FloatList locTempY = new FloatList();
FloatList tamTempX = new FloatList();
FloatList tamTempY = new FloatList();



//modificar la ruta a uan carpeta con imgs q no supere las 50/70 imgs ni 500mb de peso para que java lo soporte (sin tener q alterar los bucles de carga)
//utilizo este metdo para no acumular material en las carpetas de processing y sobre todo cada nueva variante del skecht no acarrea copias inecessarias
//a su vez q puedo utilizar cualquier elemeto del sistema 
String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/carpetas/ernest";//ernest

String regex ="(.jpg|.JPG)"; 
//elegir el tipo de imgs, para videos utilizar el skecht de videos (no esta comentado pero sigue la misma logica)
//String regex ="(.png|.PNG)";




void setup() {
  size(1300, 800, P3D);  
  //size(1900, 1000, P3D);  
  surface.setTitle("AC");
  surface.setLocation(100, 0);


  //cp5 = new ControlP5(this);
  //cp5.addFrameRate().setInterval(10).setPosition(0, height - 10).setColor(#FF0000);


  randomSeed(2021);
  frameRate(10);

  //cargo los rulsets desde csv a los HashMaps
  minmax = cargarRangeRul();
  rul = cargarRul();
  resul = cargarResul();

  //genero instancias desde json
  values = loadJSONArray(jsonName);


  acList = new ArrayList<Ac>(); 
  for (int i = 0; i < values.size(); i++) {
    JSONObject obj = values.getJSONObject(i); 
    acList.add(new Ac(obj) );
  }

  print("intacionas creadas via json: ", values.size(), "\n");


  StringList jpg;
  jpg = listDirRegex( path, regex);

  listImg = new PImage[jpg.size()] ;
  for (int i= 0; i< jpg.size(); i++) listImg[i] = loadImage(path+"/"+jpg.get(i)); 


  rFuturoMin = new int[acList.size()];
  rFuturoMax = new int[acList.size()];
  estadoFuturoLoc = new int[acList.size()];
  contador = new int[acList.size()];

  //setDefault(float dft_)


  //seteo a ac
  for (int i=0; i< acList.size(); i++) {

    int randRange = int(random(minmax.size()));//actualmente en busca de un rulset o configuracion general optimas
    int randRul = int(random(rul.size()));
    int randResultado = int(random(resul.size()));

    acList.get(i).setRange(normalizar(devolver(minmax, randRange)));
    acList.get(i).setRul(normalizar(devolver(rul, randRul)));
    acList.get(i).setResultado(normalizar(devolver(resul, randResultado)));

    //acList.get(i).setRul(normalizar(devolver(rul, 1)));
    // acList.get(i).setResultado(normalizar(devolver(resul, 1)));

    acList.get(i).setAcShader();

    //elementos para controlar la carga en los AC
    //printArray(acList.get(i).rulRange);
    //printArray(acList.get(i).rulset);
    // printArray(acList.get(i).resultado);
  }



  for (int i=0; i< acList.size(); i++) {


    rFuturoMin[i] = int(random(rangoMinA, rangoMinB));
    rFuturoMax[i] = int(random(rangoMaxnA, rangoMaxnB));
    estadoFuturoLoc[i] =  int(random(rFuturoMin[i], rFuturoMax[i]));
    contador[i] =  int(random(listImg.length));


    float rad = random(TAU);
    locTempY.append(350 *randomGaussian()*sin(rad)+height/2);
    locTempX.append(350 *randomGaussian()*cos(rad)+width/2);
    tamTempX.append(abs(200*randomGaussian())+500);
    tamTempY.append(abs(200*randomGaussian())+500);
  }

  //---------fin setup----------------------


  // contador = int(random(listImg.length));
  image(listImg[contador[0]%listImg.length], 0, 0, width, height);
}
//    image(listImg[contador%listImg.length],width/2,height/2,width,height);




void draw() {
  background(0);


  // double a=0,b=0,c=0;
  //a=millis();



  for (int i=0; i< acList.size(); i++) {
    if (frameCount % estadoFuturoLoc[i] == 0 && unlock) {
      //podria contar frames pero me parecio menos predecible buscar un dividor entre 
      
      estadoFuturoLoc[i] =  int(random(rFuturoMin[i], rFuturoMax[i]));
      contador[i]++;


      float rad = random(TAU);

      locTempX.set(i, 350 *randomGaussian()*cos(rad)+width/2);
      locTempY.set(i, 350 *randomGaussian()*sin(rad)+height/2);
      tamTempX.set(i, abs(200*randomGaussian())+500);
      tamTempY.set(i, abs(200*randomGaussian())+500);

      //locTempX.set(i,random(width/2) *cos(rad)+width/2);
      //locTempY.set(i,random(height/2) *sin(rad)+height/2);


      //cambios en el rulset 
      /*
    for (int i=0; i< acList.size(); i++) {
       int randRange = int(random(minmax.size()));
       int randRul = int(random(rul.size()));
       int randResultado = int(random(resul.size()));
       
       acList.get(i).setRange(normalizar(devolver(minmax, randRange)));
       acList.get(i).setRul(normalizar(devolver(rul, randRul)));
       acList.get(i).setResultado(normalizar(devolver(resul, randResultado)));
       
       acList.get(i).setAcShader();
       }*/

      //cambios en el zoom
      /*
    for (int i=acList.size()-1; i>=0; i--) {
       acList.get(i).setZoomAcX(random(0.5, 2.5));
       acList.get(i).setZoomAcY(random(0.5, 2.5));
       acList.get(i). setZoomImgX(random(0.5, 2.5));
       acList.get(i).setZoomImgY(random(0.5, 2.5));
       }
       */

      //acList.get(i).resetCtn(); //resetea a loc AC
    }
  }


  //for (int i=acList.size()-1; i>=0; i--) {  //en caso de usar remove
  for (int i=0; i< acList.size(); i++) { 
    Ac acTemp = acList.get(i);
    acTemp.actualizar();

    imageMode(CENTER);


    acTemp.dibujar(listImg[(contador[i]+acTemp.id)%listImg.length], width/2, height/2, tamTempX.get(i), tamTempY.get(i));




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
