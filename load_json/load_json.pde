JSONArray values;

void setup() {

  values = loadJSONArray("data-mid.json");

  for (int i = 0; i < values.size(); i++) {
    print("\n");
    JSONObject obj = values.getJSONObject(i); 

    //int id = obj.getInt("id");
    //float  = obj.getFloat("");
    String path = obj.getString("path");
    
    int modulo = obj.getInt("modulo");
    
    float scale = obj.getFloat("scale");
    float rotate = obj.getFloat("rotate");
    
    float rndX = obj.getFloat("rndX");
    float rndY = obj.getFloat("rndY");

    float posX0 = obj.getFloat("posX0");
    float posX1 = obj.getFloat("posX1");
    float posX2 = obj.getFloat("posX2");
      
    float posY0 = obj.getFloat("posY0");
    float posY1 = obj.getFloat("posY1");
    float posY2 = obj.getFloat("posY2");
    
    float  w0= obj.getFloat("w0");
    float  w1= obj.getFloat("w1");
    float  w2= obj.getFloat("w2");

    float h0 = obj.getFloat("h0");
    float  h1= obj.getFloat("h1");
    float  h2= obj.getFloat("h2");

    float s0 = obj.getFloat("s0");
    float s1 = obj.getFloat("s1");
    float s2 = obj.getFloat("s2");
      
    float cosT0 = obj.getFloat("cosT0");
    float cosT1 = obj.getFloat("cosT1");
    float cosT2 = obj.getFloat("cosT2");

    float sinT0 = obj.getFloat("sinT0");
    float sinT1 = obj.getFloat("sinT1");
    float sinT2 = obj.getFloat("sinT2");
      
   println("path: ",path + ", " + modulo + ", " + scale, ", ",rotate, ", " ,rndX, ", " ,rndY  );
   println("pos: ", ", " + posX0 + ", " + posX1, ", ",posX2, ", " ,posY0, ", " ,posY1 + ", " ,posY2  );
   println("alto y ancho: ", ", " + w0 + ", " + w1, ", ",w2, ", " ,h0, ", " ,h1 + ", " ,h2  );
   println("s0:", ", " + s0 + ", " + s1, ", ",s2 );
   println("cos y sin:", ", " + cosT0 + ", " + cosT1, ", ",cosT2, ", " ,sinT0, ", " ,sinT1 + ", " ,sinT2  );
}
  
  
}
