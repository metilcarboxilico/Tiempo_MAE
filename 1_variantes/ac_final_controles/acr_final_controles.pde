

//import processing.video.*;

import java.io.File;
import controlP5.*;

ControlP5 cp5;
final double norm =1.0/255; //normalizacion del 255 si se usa otro rango del espacio color aqui se ajusta ejemplo rgb 100 => 1./100

/*
for(int i=0;i<rules.length();i++){
				if(sum<=rules[i]){
					resultado=resul[i];
					
					flag=false;
					break;
				}
				

*/

Accordion accordion;

Range range0, range1, range2, range3, range4, range5;

float dft=255.;
float min0=0.0, min1=0.0, min2=0.0, min3=0.0, min4=0.0, min5=180.0;
float max0=0.0, max1=0.0, max2=0.0, max3=0.0, max4=0.0, max5=255.0;
float minMaxArray[] = { min0, max0, min1, max1, min2, max2, min3, max3, min4, max4, min5, max5};


float rulset0=0.0, rulset1=0.0, rulset2=0.0, rulset3=0.0, rulset4=0.0, rulset5=0.0;
float rulsetArray[] = {rulset0, rulset1, rulset2, rulset3, rulset4, rulset5};

float resultado0=0.0, resultado1=0.0, resultado2=0.0, resultado3=0.0, resultado4=0.0, resultado5=0.0;
float resultadosArray[] = {resultado0, resultado1, resultado2, resultado3, resultado4, resultado5};


float bias0=0.0, bias1=0.0, bias2=0.0, bias3=0.0, bias4=0.0, bias5, bias6=0.0, bias7=0.0, bias8=0.0, divisor=8.0;
float biasArray[] = {bias0, bias1, bias2, bias3, bias4, bias5, bias6, bias7, bias8};




float zoomX, zoomY, zoomXac, zoomYac;


/*
resultadosArray 
float temp[]= {resultado0, resultado1, resultado2, resultado3, resultado4, resultado5};
  biasArray 
float temp[]= {bias0, bias1, bias2, bias3, bias4, bias5, bias6, bias7, bias8};
rulsetArray
float temp[]= {rulset0, rulset1, rulset2, rulset3, rulset4, rulset5};
 
*/
color label=color(255), active=color(200), back=color(20), fore=color(170), valueLabel=color(255) ;


JSONArray values;

PImage[] listImg;

HashMap<Integer, FloatList> minmax ;
HashMap<Integer, FloatList> rul ;
HashMap<Integer, FloatList> resul ;

ArrayList<Ac> acList;

boolean recording=false;


String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/procesos/cargar_carpeta/data/img";

String regex ="(.jpg|.JPG)";


void setup() {
  size(1000, 800, P3D);  
  gui();
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
  print("hay ", values.size(), " instancias de ac\n");


  StringList jpg;
  jpg = listDirRegex( path, regex);

  listImg = new PImage[jpg.size()] ;
  for (int i= 0; i< jpg.size(); i++) listImg[i] = loadImage(path+"/"+jpg.get(i));   // println("jpg ",i," : ",jpg.get(i));



  //setDefault(float dft_)
  //seteo a ac
  for (int i=acList.size()-1; i>=0; i--) {

    acList.get(i).setRange(normalizar(devolver(minmax, 1)));
    acList.get(i).setRulset(normalizar(devolver(rul, 1)));
    acList.get(i).setResultado(normalizar(devolver(resul, 1)));

    acList.get(i).setAcShader();
    //printArray(acList.get(i).rulRange);
    //printArray(acList.get(i).rulset);
    // printArray(acList.get(i).resultado);
  }



  //---------fin setup----------------------
}
void seteoForsoso(){
  for (int i=acList.size()-1; i>=0; i--) {

    acList.get(i).setRange(normalizar(devolver(minmax, 1)));
    acList.get(i).setRulset(normalizar(devolver(rul, 1)));
    acList.get(i).setResultado(normalizar(devolver(resul, 1)));

    acList.get(i).setAcShader();
    //printArray(acList.get(i).rulRange);
    //printArray(acList.get(i).rulset);
    // printArray(acList.get(i).resultado);
  }

 
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

  background(0);

  for (int i=acList.size()-1; i>=0; i--) {
    Ac acTemp = acList.get(i);
    acTemp.actualizar();
    //acTemp.dibujar();
    float dist=width/acList.size();
    acTemp.dibujar(listImg[(contador+acTemp.id)%listImg.length], dist*i, 0);//contador%listMovie.length
    //locTempX

    //if(acTemp.isDead()) acList.remove(i); //par afuturas actulizaciones
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
  //println("zoomYac ",zoomYac);
  printArray(minMaxArray);
}
