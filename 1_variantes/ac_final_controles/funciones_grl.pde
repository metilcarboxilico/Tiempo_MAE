
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




float[] devolver(HashMap hs_, int key_) {
  FloatList fListTemp = (FloatList)hs_.get(key_);
  return fListTemp.array();
}


float[] normalizar(float[] fA_) {
  return normalizar(fA_, 255);
}

float[] normalizar(float[] fA_, int nNorm) {
  double norm =1.0/nNorm;
  float ftTemp[] = fA_ ;
  for (int i =0; i< ftTemp.length; i++) {
    ftTemp[i]= (float)(ftTemp[i]*norm);
  }
  return ftTemp;
}




/* 
 HashMap<Integer, FloatList> minmax ;
 HashMap<Integer, FloatList> rul ;
 HashMap<Integer, FloatList> resul ;
 
 float rulRange[];
 float rulset[];
 float resultado[];
 
 minmax = cargarRangeRul();
 rul = cargarRul();
 resul = cargarResul();

 printArray(devolver(resul, 0));
 printArray(normalizar(devolver(resul, 0)));

  
 //resultado =normalizar(devolver(resul, 0));
//rulset =normalizar(devolver(rul, 0));
//rulRange =normalizar(devolver(minmax, 0));
 */




HashMap<Integer, FloatList> cargarRangeRul() {
  return cargarRangeRul("minmax.csv");
}
HashMap<Integer, FloatList> cargarRul() {
  return cargarRul("rulset.csv");
}
HashMap<Integer, FloatList> cargarResul() {
  return cargarResul("resul.csv");
}

HashMap<Integer, FloatList> cargarRangeRul(String ruta) {
  Table table;
  HashMap<Integer, FloatList> minmax ;
  table = loadTable(ruta, "header");
  minmax = new HashMap<Integer, FloatList>();

  println(table.getRowCount() + " minmax");

  for (TableRow row : table.rows()) {

    FloatList fListTemp;
    fListTemp = new FloatList();
    int id = row.getInt("id");
    fListTemp.append(row.getFloat("min0"));
    fListTemp.append(row.getFloat("max0"));
    fListTemp.append(row.getFloat("min1"));
    fListTemp.append(row.getFloat("max1"));
    fListTemp.append(row.getFloat("min2"));
    fListTemp.append(row.getFloat("max2"));
    fListTemp.append(row.getFloat("min3"));
    fListTemp.append(row.getFloat("max3"));
    fListTemp.append(row.getFloat("min4"));
    fListTemp.append(row.getFloat("max4"));
    fListTemp.append(row.getFloat("min5"));
    fListTemp.append(row.getFloat("max5"));

    minmax.put(id, fListTemp);
  }
  return minmax;
}


HashMap<Integer, FloatList> cargarRul(String ruta) {
  Table table;
  HashMap<Integer, FloatList> rul ;
  table = loadTable(ruta, "header");
  rul = new HashMap<Integer, FloatList>();

  println(table.getRowCount() + " rul");

  for (TableRow row : table.rows()) {

    FloatList fListTemp;
    fListTemp = new FloatList();
    int id = row.getInt("id");
    fListTemp.append(row.getFloat("rul0"));
    fListTemp.append(row.getFloat("rul1"));
    fListTemp.append(row.getFloat("rul2"));
    fListTemp.append(row.getFloat("rul3"));
    fListTemp.append(row.getFloat("rul4"));
    fListTemp.append(row.getFloat("rul5"));

    rul.put(id, fListTemp);
  }
  return rul;
}


HashMap<Integer, FloatList> cargarResul(String ruta) {
  Table table;
  HashMap<Integer, FloatList> resul ;
  table = loadTable(ruta, "header");
  resul = new HashMap<Integer, FloatList>();

  println(table.getRowCount() + " resul");

  for (TableRow row : table.rows()) {

    FloatList fListTemp;
    fListTemp = new FloatList();
    int id = row.getInt("id");
    fListTemp.append(row.getFloat("resul0"));
    fListTemp.append(row.getFloat("resul1"));
    fListTemp.append(row.getFloat("resul2"));
    fListTemp.append(row.getFloat("resul3"));
    fListTemp.append(row.getFloat("resul4"));
    fListTemp.append(row.getFloat("resul5"));

    resul.put(id, fListTemp);
    ;
  }
  return resul;
}
