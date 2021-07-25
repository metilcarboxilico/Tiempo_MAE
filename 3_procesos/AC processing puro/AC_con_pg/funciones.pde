




StringList listDirRegex(String path_, String regex_) {
  StringList contenido= new StringList();
  String path = path_;
  File carpeta = new File(path);

  File[] archivos = carpeta.listFiles();
  if (archivos == null || archivos.length == 0) {
    System.out.println("No hay elementos dentro de la carpeta actual");
    //return;
  } else {
    for (int i=0; i< archivos.length; i++) {
      if (regex_=="dir"||regex_=="DIR") {
        if ( archivos[i].isDirectory()) {
          contenido.append(archivos[i].getName());
        }
      } else if (archivos[i].isFile()) {
        if (match(archivos[i].getName(), regex_) != null) contenido.append(archivos[i].getName());
      }
    }
  }
  return contenido;
}


/////////TABLEAS DE SENO Y COSENO/////////////////

float[] arraySeno() {
  return arraySeno(360) ;
}

float[] arraySeno(int res) {
  float[]  seno;
  //seno[int((i*4)%res)]*10) teoricamente 
  seno= new float[res];
  for (int i=0; i<res; i++) {
    if (TAU/res*i != PI ) seno[i]=sin(TAU/res*i);
    else     seno[i]=0;
  }

  return seno;
}

float[] arrayCoseno() {
  return arrayCoseno(360) ;
}

float[]  arrayCoseno(int res) {
  float[]  cos;

  //int res=360;
  //cos[int((i*4)%res)]*10) teoricamente 
  cos= new float[res];
  for (int i=0; i<res; i++) {
    //1080 // 270
    if ( TAU/res*i == PI/2 ||TAU/res*i == PI*3/2 ) cos[i]=0;  //i%90  TAU/res*i
    else    cos[i]=cos(TAU/res*i);
  }
  return cos;
}


////////////////////////////////INTERPOLACIONES///////////////////////////////////////

float[] interArray(float[] a, int cant) {
  //funcion que incluye en el array los extremos
  float[] inter = new float[a.length*cant];
  int index=0;
  for (int i = 0; i < a.length; i++) {
    float[] temp;
    if (a.length-1==i) {  
      temp= interpolar(a[i], a[0], cant) ;
    } else {
      temp= interpolar(a[i], a[i+1], cant) ;
    }
    for (int j = 0; j < temp.length; j++) {
      inter[index]=temp[j];
      index++;
    }
  }


  return inter;
}

float[] interpolar(float a, float b, int cant) {
  //funcion que incluye en el array los extremos
  int div=cant-1;
  float[] inter = new float[cant];
  for (int i = 0; i < inter.length; i++) {
    float c = lerp(a, b, (1.0/div)*i) ;
    inter[i]=(c);
  }

  return inter;
}

/*    func de prueba
 float[] interArray(float[] a, int cant) {
 //funcion que incluye en el array los extremos
 float[] inter = new float[a.length*cant];
 int index=0;
 for (int i = 0; i < a.length; i++) {
 for (int j = 0; j < cant; j++) {
 println("j: ", 1.0/div*j);
 float c ;
 if (a.length-1==i) {  
 c = lerp(a[i], a[0], (1.0/div)*j) ;
 } else {
 c = lerp(a[i], a[i+1], (1.0/div)*j) ;
 }
 inter[index]=(c);
 index++;
 }
 }
 
 
 return inter;
 }
 
 */


/*
float[] interpolar(float a, float b, int cant) {
 //funcion que suma los extremos y quedejo provisoriamente
 int div=cant+2;
 float[] inter = new float[div+1];
 for (int i = 0; i < inter.length; i++) {
 float c = lerp(a, b, (1.0/div)*i) ;
 inter[i]=(c);
 }
 
 return inter;
 }
 */


/////////////////////////////poligonos//////////////////////////////////////////

ArrayList poly(float dx, float dy, float radio, float init, int lados) {
  ArrayList<PVector> cord;
  cord=new ArrayList();
  float div = 360/lados;
  for (int a=0; a<lados; a++) {  
    float radianes=radians(a*div+init);
    float coorY= sin(radianes);
    float coorX= cos(radianes);
    cord.add(new PVector(coorX*radio+dx, coorY*radio+dy));
  }
  return cord;
}


///podria agregarle un +1 al alado y hacer que siempre sea cerrado
float[]  polyCos(float dx, float radio, float init, int lados) {
  float[]  cord=new float[lados];
  float div = 360/lados;
  for (int a=0; a<lados; a++) {  
    float radianes=radians(a*div+init);
    float coorX= cos(radianes);
    cord[a]=coorX*radio+dx;
  }
  return cord;
}

float[]  polySin(float dy, float radio, float init, int lados) {
  float[]  cord=new float[lados];
  float div = 360/lados;
  for (int a=0; a<cord.length; a++) {  
    float radianes=radians(a*div+init);
    float coorY= sin(radianes);
    cord[a]=coorY*radio+dy;
  }
  return cord;
}



//////////////////////////////MODIFICACIONES DE ARRAY///////////////////////////////////////


//    float y = map(sin(angle),-1,1,0,height/2); otra buena forma de resolverlo

/*
  int xspacing = 12; // How far apart should each horizontal position be spaced
 period = p;
 amplitude = a;
 dx = (TWO_PI / period) * xspacing;
 void calculate() {
 // Increment theta (try different values for 'angular velocity' here
 theta += 0.02;
 
 // For every x value, calculate a y value with sine function
 float x = theta;
 for (int i = 0; i < particles.length; i++) {
 particles[i].setposition(origin.x+i*xspacing,origin.y+sin(x)*amplitude);
 x+=dx;
 }
 }
 */



float[] senoArray(float[] array_, float amp, float frec) {
  return senoArray(array_, amp, frec, 0);
}
float[] senoArray(float[] array_, float amp, float frec, float offset) {
  //  int res=360;//1440 //esto puede complicarme la vida podria simplemente usar sin
  float[] array = array_.clone();
  for (int i=0; i<array.length; i++) {
    // array[2]=array[2]+seno[int((i*4)%res)*10];
    array[i]=array[i]+sin(i*frec+offset)*amp;
  }
  return array;
}
float[] cosenoArray(float[] array_, float amp, float frec) {
  return cosenoArray(array_, amp, frec, 0);
}

float[] cosenoArray(float[] array_, float amp, float frec, float offset) {
  //  int res=360;//1440 //esto puede complicarme la vida podria simplemente usar sin
  float[] array = array_.clone();
  for (int i=0; i<array.length; i++) {
    // array[2]=array[2]+cos[int((i*4)%res)*10];
    array[i]=array[i]+cos(i*frec+offset)*amp;
  }
  return array;
}


float[] noiseArray(float[] array_, float frec, float min, float max) {
  return noiseArray( array_, frec, min, max, 0) ;
}


float[] noiseArray(float[] array_, float frec, float min, float max, float offset) {
  float[] array = array_.clone();
  for (int i=0; i<array.length; i++) {
    array[i]=array[i]+map(noise(i*frec+offset), 0, 1, min, max);
    ;
  }
  return array;
}


float[] randArray(float[] array_, float min, float max) {
  float[] array = array_.clone();
  for (int i=0; i<array.length; i++) {
    array[i]=array[i]+random(min, max);
    ;
  }
  return array;
}

float[] gauArray(float[] array_, float amp) {
  float[] array = array_.clone();
  for (int i=0; i<array.length; i++) {
    array[i]=array[i]+randomGaussian()*amp;
    ;
  }
  return array;
}
