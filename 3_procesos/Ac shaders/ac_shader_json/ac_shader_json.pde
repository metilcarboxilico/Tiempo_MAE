
//import processing.video.*;
import java.io.File;
PImage[] listImg;

HashMap<Integer, FloatList> minmax ;
HashMap<Integer, FloatList> rul ;
HashMap<Integer, FloatList> resul ;


String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/procesos/cargar_carpeta/data/img";
  String regex ="(.jpg|.JPG)";


ArrayList<Ac> acList;

PShader ac;
//PShader capa;
//boolean flag=false;

PGraphics pg;
PImage img, img2;
PImage salida;

PShader maskShader;
double norm =1.0/255; //estudiar el pasaje a doble?

JSONArray values;
//HACER UN HASHMAP QUE CONTENGA LOS RULSETS VIA JSON?
//el geenerador de json hacerlo en py o en java?


void setup() {
  size(1000, 800, P3D);  
  surface.setTitle("AC con video");
  surface.setLocation(100, 100);
  randomSeed(2021);
  frameRate(10);

  //cargo los rulsets desde csv
  minmax = cargarRangeRul();
  rul = cargarRul();
  resul = cargarResul();

  //genero instancias desde json
  values = loadJSONArray("data-mid-f.json");
  acList = new ArrayList<Ac>(); 
  for (int i = 0; i < values.size(); i++) {
    print("\n");
    JSONObject obj = values.getJSONObject(i); 
    acList.add(new Ac(obj) );
  }
  print(values.size());


  //   String path =   "F:/imagenes/fotos/villacrespo";


  StringList jpg;
  jpg = listDirRegex( path, regex);

  listImg = new PImage[jpg.size()] ;
  for (int i= 0; i< jpg.size(); i++) listImg[i] = loadImage(path+"/"+jpg.get(i));   // println("jpg ",i," : ",jpg.get(i));


  //seteo desde cvs

  for (int i=acList.size()-1; i>=0; i--) {
    acList.get(i).rulRange = normalizar(devolver(rul, 0));
    acList.get(i).rulset = normalizar(devolver(minmax, 0));
    acList.get(i).resultado = normalizar(devolver(resul, 0));
  }

  
  //---------fin setup----------------------
}



//float cnt=0;
int contador=0, estadoFuturo=int(random(5, 50)), estadoFuturoLoc = int(random(270, 400));
int locTempX =int(width/4*randomGaussian()+width/2), locTempY = int(height/4 *randomGaussian()+height/2);


void draw() {

  if (frameCount%estadoFuturo==0) {
    estadoFuturo= int(random(5, 50));
    contador++;
  }

  if (frameCount%estadoFuturoLoc==0) {
    locTempX =int(width/4*randomGaussian()+width/2);
    locTempY = int(height/4 *randomGaussian()+height/2 );
    estadoFuturoLoc = int(random(70, 100));
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
}




void mousePressed() {
}
void mouseReleased() {
}
