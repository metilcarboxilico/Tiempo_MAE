
//import processing.video.*;
import java.io.File;

final double norm =1.0/255; //normalizacion del 255 si se usa otro rango del espacio color aqui se ajusta ejemplo rgb 100 => 1./100



JSONArray values;

PImage[] listImg;

HashMap<Integer, FloatList> minmax ;
HashMap<Integer, FloatList> rul ;
HashMap<Integer, FloatList> resul ;

ArrayList<Ac> acList;

boolean recording=false;



void setup() {
  size(1000, 800, P3D);  
  surface.setTitle("AC");
  surface.setLocation(100, 100);
  randomSeed(2021);
  frameRate(10);

  //cargo los rulsets desde csv
  minmax = cargarRangeRul();
  rul = cargarRul();
  resul = cargarResul();

  //genero instancias desde json
  values = loadJSONArray("data-mid-test.json");
  acList = new ArrayList<Ac>(); 
  for (int i = 0; i < values.size(); i++) {
    print("\n");
    JSONObject obj = values.getJSONObject(i); 
    acList.add(new Ac(obj) );
  }
  print(values.size(),"\n");


  String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/cargar_carpeta/data/img";
  //   String path =   "F:/imagenes/fotos/villacrespo";
  String regex ="(.jpg|.JPG)";


  StringList jpg;
  jpg = listDirRegex( path, regex);

  listImg = new PImage[jpg.size()] ;
  for (int i= 0; i< jpg.size(); i++) listImg[i] = loadImage(path+"/"+jpg.get(i));   // println("jpg ",i," : ",jpg.get(i));



//setDefault(float dft_)
  //seteo a ac
  for (int i=acList.size()-1; i>=0; i--) {

    acList.get(i).setRange(normalizar(devolver(minmax, 1)));
    acList.get(i).setRul(normalizar(devolver(rul, 1)));
    acList.get(i).setResultado(normalizar(devolver(resul,1)));
    
    acList.get(i).setAcShader();
    //printArray(acList.get(i).rulRange);
    //printArray(acList.get(i).rulset);
  // printArray(acList.get(i).resultado);
  }
  

  
  //---------fin setup----------------------
}



//float cnt=0;
int contador=0, estadoFuturo=int(random(5, 50)), estadoFuturoLoc = int(random(270, 400));
int locTempX =int(width/4*randomGaussian()+width/2), locTempY = int(height/4 *randomGaussian()+height/2);


void draw() {
/*
  if (frameCount%estadoFuturo==0) {
    estadoFuturo= int(random(5, 50));

  }
*/
  if (frameCount%estadoFuturoLoc==0) {
    locTempX =int(width/4*randomGaussian()+width/2);
    locTempY = int(height/4 *randomGaussian()+height/2 );
    estadoFuturoLoc = int(random(70, 100));
     contador++;
  }

  background(250);

  for (int i=acList.size()-1; i>=0; i--) {
    Ac acTemp = acList.get(i);
    acTemp.actualizar();
    //acTemp.dibujar();
    float dist=width/acList.size();
    acTemp.dibujar(listImg[(contador+acTemp.id)%listImg.length], dist*i, 0);//contador%listMovie.length
    //locTempX

    //if(acTemp.isDead()) acList.remove(i);
  }
  
   if (recording) saveFrame("output/secuencia/secuencia_####.png");
}




void keyPressed() {
  if (key  =='r'||key =='R')  recording= !recording;
  if (key == 'c'||key =='C') saveFrame("output/capturas/####.png");
}
   /*for (int i=acList.size()-1; i>=0; i--) {
    acList.get(i).
   }*/
void mousePressed() {

}
void mouseReleased() {
}
