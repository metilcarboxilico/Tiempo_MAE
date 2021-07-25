








/*

 import java.math.*;
 import java.text.DecimalFormat;
 
 DecimalFormat df = new DecimalFormat("###.####");
 
 
 //nf(num, digits)
 float temp =random(4000);
 json.setFloat("sclrand", float(df.format(random(4000))));
 temp =random(0,50);
 
 */


  JSONArray values;
  float test;
  int n= 5;

//siempre el mismo random

void setup() {

  //noiseSeed(2021);
  //randomSeed(2021);


  values = new JSONArray();

}
void draw(){
  
 
  for (int i = 0; i < n; i++) {

    JSONObject json = new JSONObject();
    /*
    random();
     randomGaussian();
     noise(i);
     */
    json.setInt("id", i);

    test =truncate(random(4500), 100000000);
    json.setFloat("sclrand", test );
    println("1", test);
    float  testa = truncate(random(0, 50), 100000000);
    println("2", testa);

    json.setFloat("rndX", testa);
    float   tests =random(55, 140);
        println("3", tests);

    tests= truncate(tests, 100000000);
    println("3", tests);

    json.setFloat("rndY", tests);
    // test =truncate(random(4000), 100000000);
    json.setFloat("posX0", truncate(randomGaussian()*0.5+0.5, 1000));
    json.setFloat("posX1", truncate(randomGaussian()*0.5+0.5, 1000));
    json.setFloat("posX2", truncate(randomGaussian()*0.5+0.5, 1000));

    json.setFloat("posY0", truncate(randomGaussian()*0.5+0.5, 1000));
    json.setFloat("posY1", truncate(randomGaussian()*0.5+0.5, 1000));
    json.setFloat("posY2", truncate(randomGaussian()*0.5+0.5, 1000));

    json.setFloat("w0", truncate(randomGaussian()*0.5+0.5+0.3, 1000));
    json.setFloat("w1", truncate(randomGaussian()*0.5+0.5+0.3, 1000));
    json.setFloat("w2", truncate(randomGaussian()*0.5+0.5+0.3, 1000));

    json.setFloat("h0", randomGaussian()*0.5+0.3);
    json.setFloat("h1", randomGaussian()*0.5+0.3);
    json.setFloat("h2", randomGaussian()*0.5+0.3);

    json.setFloat("s0", randomGaussian()*0.1);
    json.setFloat("s1", randomGaussian()*0.51);
    json.setFloat("s2", randomGaussian()*0.31);

    json.setFloat("cosT0", randomGaussian()+0.32);
    json.setFloat("cosT1", randomGaussian()+0.2);
    json.setFloat("cosT2", randomGaussian()-0.52);

    json.setFloat("sinT0", randomGaussian()+0.52);
    json.setFloat("sinT1", randomGaussian()-0.32);
    json.setFloat("sinT2", randomGaussian()+0.52);

    values.setJSONObject(i, json);
  }

  saveJSONArray(values, "data/anew.json");
  
  noLoop();
}

//en ambos no soluciono que en el json se guarde como un double,
//pero creo q que al usar dobule y long logre evitar la sobrecarga del random

float truncate(float a_, int k_) {
  //con menos de 5 cifras de significancia me devuelve numeros con notacion cientifica E-4 etc 
  float s=a_*k_;
  int b=int(s);
     float r= float(b)/k_;
  return r;
}
float truncate(float a_, long k_) {
  //con menos de 5 cifras de significancia me devuelve numeros con notacion cientifica E-4 etc 
  double s=a_*k_;
  long b=(long)s;
  double r= (double)b/k_;
  return (float)r;
}
