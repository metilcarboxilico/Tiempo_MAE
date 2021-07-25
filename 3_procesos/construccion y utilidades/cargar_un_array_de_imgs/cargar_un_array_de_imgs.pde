

import java.io.File;
//una libreria de java q permite utilizar archivos del sistema dentro del programa, como recar carpetas renombrarlas etc

// utilizo una ruta absoluta por que al usarjava.io.File se me complico usar rutas relativas como los ejemplos simples de procesing

String ruta = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/cargar_carpeta/data/img";

PImage[]  jpgArray ; //un array con las imagenes, declarado en un ambito global


void setup() {
  size(1000, 1000);
  StringList  directorios, contenido, jpg, png, gif; 
  //lo genero en un ambito local (setup) porq luego no la utilizare, solamente me interesa usar el jpgArray



  //genere un montol de StringList (similares a las ArrayList) para guardar los nombre  
  png= new StringList();
  gif= new StringList();
  jpg = new StringList();

  //una StringList que guarda los subdirectorios 

  directorios = new StringList();

  //otra StringList
  contenido= new StringList();

  //declaro un objeto tipo file que representaria la ruta que le indico ergo es identico a la carpeta de la ruta
  File carpeta = new File(ruta); 


  //genero una lista (array) de los archivos en ese objeto, que a su vez serian representaciones individuales de lo q contine la carpeta
  File[] archivos = carpeta.listFiles(); 




  if (archivos == null || archivos.length == 0) { 
    //si la carpeta esta vacia envio un mensaje
    println("No hay elementos dentro de la carpeta actual");
  } else {
    //si tiene elementos la recorro

    for (int i=0; i< archivos.length; i++) {
      if ( archivos[i].isDirectory()) { 
        //isDirectory() es una funcion de la libreria q devuelve true si el objeto file es un directorio
        directorios.append(archivos[i].getName());
      } else if (archivos[i].isFile()) {
        //isFile() es una funcion de la libreria q devuelve true si el objeto file es un archivo

        //match es una funcion de processing que compara un string con una cosa llamada Expresiones regulares o ReGex
        //si hay coincidencia devuelve el string sino devuleve un objeto null que en otras palabras serioa nulo o vacio
        // https://regex101.com
        //son un tipo de anotacion especial para buscar conjuntos de caracteres  
        //en este caso particular con camiar el .jpg y el mayusculas por el tipo de archivo q desamos nos lo filtrara
        //aca comparo != que sea diferente a null
        if (match(archivos[i].getName(), "(.jpg|.JPG)") != null) {
          jpg.append(archivos[i].getName());
        } else if (match(archivos[i].getName(), "(.png|.PNG)")!= null) { 
          png.append(archivos[i].getName());
        } else if (match(archivos[i].getName(), "(.gif|.GIF)")!= null) { 
          gif.append(archivos[i].getName());
          //si el objeto file no es ninguno de los anteriores lo almaceno en contenido (esto quizas no les sea util y pueden borrarlo)
          //yo lo utilizo asi por qu mi idea seria filtrar aun mas todos las posibilidades y enviar esto en un HashMap para otros fines
        } else { 
          contenido.append(archivos[i].getName());
        }
      }
    }
  }
  
  //una vez terminado el filtrado y teninendo una lista de los jpgs genero un array del mismo tamaño
  jpgArray= new PImage[jpg.size()];

  for (int i=0; i<jpg.size(); i++) {
    // println("jpg: ", i, " ", jpg.get(i));
    
    try {//atajo posibles errores en la carga 
    
      jpgArray[i]= loadImage(ruta+"/"+jpg.get(i));
      //aca uso la ruta le agrego una barra y el nombre de la imagen a agregar 
    }
    catch(NullPointerException e) { // este error si todo esta bien declarado no deberia saltar
      println("no se pudo cargar: ", jpg.get(i)); //aviso q tal imagen no se pudo cargar
    }
  }
}

void draw() {
 // background(175);
  
  // recorro el array de imagens
  for (PImage i : jpgArray) {
    //lo ubico en una posicion random y calculo su ancho y algo multiplicado por algu nvalor entre 0.5 y 1
    image(i, random(width), random(height), i.width *random(.5, 1), i.height *random(.5, 1));
  }

//anulo el loop de la imagen
  noLoop();
}

void mousePressed() {
  
  //dibujo otra vez las iamgenes 
  redraw();
}

void keyPressed() {

  if (key == 'c'||key =='C') {
    saveFrame("output/capturas/####.png");
  }
}
