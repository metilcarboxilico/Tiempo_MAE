

//import java.io.FileFilter;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

size(1000, 1000);
//hacer esto una funcion? o una clase?
String path = "F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/cargar_carpeta/data/img";
StringList  directorios, contenido, jpg, png, gif;

png= new StringList();
gif= new StringList();
jpg = new StringList();
directorios = new StringList();
contenido= new StringList();
File carpeta = new File(path);

/*
String[] listado = carpeta.list();
 //generar un string
 if (listado == null || listado.length == 0) {
 System.out.println("No hay elementos dentro de la carpeta actual");
 return;
 }*/

File[] archivos = carpeta.listFiles();
if (archivos == null || archivos.length == 0) {
  System.out.println("No hay elementos dentro de la carpeta actual");
  //return;
} else {
  /* for (int i=0; i< listado.length; i++) {
   System.out.println(listado[i]);
   }*/
  //SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  for (int i=0; i< archivos.length; i++) {
    if ( archivos[i].isDirectory()) {
      directorios.append(archivos[i].getName());
    } else if (archivos[i].isFile()) {

      if (match(archivos[i].getName(), "(.jpg|.JPG)") != null) jpg.append(archivos[i].getName());
      else if (match(archivos[i].getName(), "(.png|.PNG)")!= null) png.append(archivos[i].getName());
      else if (match(archivos[i].getName(), "(.gif|.GIF)")!= null) gif.append(archivos[i].getName());
      else contenido.append(archivos[i].getName());
    }
    
    
    // File archivo = archivos[i];
    /*System.out.println(String.format("%s (%s) - %d - %s", 
     archivo.getName(), 
     archivo.isDirectory() ? "Carpeta" : "Archivo", //de esta ternaria  //a su ves exites isFile
     archivo.length(), 
     sdf.format(archivo.lastModified())
     ));*/
  }

  for (int i=0; i<directorios.size(); i++) {
    println("directorios: ", i, " ", directorios.get(i));
  }

  //String filtrar= join(contenido.array(), " "); 
  //println(filtrar);
  //printArray( match(filtrar, "(\\S*.jpg|\\S*.JPG)"));

  //PImage f = loadImage("F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/cargar_carpeta/data/img/"+"sfs.jpg");
  // image(f, random(width), random(height));
  PImage  n ;
      String ruta ="F:/Documentos/programacion/processing/sketchs/mae/proyectos mae/tiempo/cargar_carpeta/data/img/";

    for (int i=0; i<jpg.size(); i++) {
    // println("jpg: ", i, " ", jpg.get(i));
    try {

      n= loadImage(ruta+jpg.get(i));   
      image(n, random(100, width-100), random(100, height-100), random(100, 200), random(100, 200));
    }
    catch(NullPointerException e) {
      println("no se pudo cargar: ", jpg.get(i));
    }
  } 
  /*
  for (int i=0; i<png.size(); i++) {
   println("png: ", i, " ", png.get(i));
   } 
   for (int i=0; i<gif.size(); i++) {
   println("gif: ", i, " ", gif.get(i));
   }
   
   */
}



/*
//expresiones Regulares (regex)
 https://regex101.com
 son un tipo de anotacion especial para buscar conjuntos de caracteres 
 
 /(\S*.jpg|\S*.JPG)/gm
 /(\S*.png|\S*.PNG)/gm
 /(\S*.gif|\S*.GIF)/gm
 (.*.jpg|.*.JPG)
 (.*.png|.*.PNG)
 (.*.gif|.*.GIF)
 */


/*//archivos = carpeta.listFiles(filtro);
 
 FileFilter filtro = new FileFilter() {
 @Override //https://es.stackoverflow.com/questions/156432/para-que-sirve-la-línea-override-en-java/156487
 public boolean accept(File arch) {
 return arch.isFile(); // y podria hacerlo para isDirectorio o cosas mas complejas
 }
 };
 
 */


//un join o solo un path+"/"+subDir en un sub directorios?

//isDirectory()
//isFile()
//listFiles()



/*

 canExecute(): devuelve un true o false en función de si el archivo es ejecutable o no.
 canRead(): si tienes acceso de lectura o no
 canWrite(): si puedes escribir en él o no
 createNewFile(): crea un nuevo archivo vacío con el nombre que se le indique.
 delete(): borra el archivo o directorio
 exists(): determina si el archivo representado por File en la ruta que le hayamos pasado existe o no.
 getName(): el nombre del archivo o carpeta
 getParent(): devuelve una cadena con la ruta de la carpeta "madre" del archivo o carpeta actuales.
 isDirectory(): indica si el objeto actual representa a una carpeta o no
 isFile():  indica si el objeto actual representa a un archivo
 isHidden(): si es un elemento oculto en el sistema de archivos
 length(): el tamaño del archivo en bytes. Si no existe o no tienes permiso devuelve un 0. En el caso de carpetas en Linux/Mac con sistema de archivos ext3/ext4 siempre devuelve 4096 ya que este es el tamaño de un bloque en Linux y es el mínimo que puede ocupar cualquier enlace en disco, como una carpeta (4KB).
 list(): los nombres de los archivos y carpetas hijos de una carpeta.
 listFiles(): como el anterior pero devolviendo objetos File para cada archivo o carpeta.
 mkdir(): crea una carpeta
 renameTo(): renombra el archivo o carpeta
 
 */
