
void setup() {
  
  noiseSeed(2021);
  randomSeed(2021);
  
  JSONArray values;

  int n= 20;

  values = new JSONArray();

  for (int i = 0; i < n; i++) {

    JSONObject json = new JSONObject();
/*
    random();
    randomGaussian();
    noise(i);
    */
    json.setInt("id", i);

    json.setFloat("sclrand", random(4000));

    json.setFloat("rndX", random(0,50));
    json.setFloat("rndY", random(55,140));

    json.setFloat("posX0", random(-1.2,1.2));
    json.setFloat("posX1", random(-1.2,1.2));
    json.setFloat("posX2", random(-1.2,1.2));

    json.setFloat("posY0", random(-1.2,1.2));
    json.setFloat("posY1", random(-1.2,1.2));
    json.setFloat("posY2", random(-1.2,1.2));

    json.setFloat("w0", random(-1.2,1.2));
    json.setFloat("w1", random(-1.2,1.2));
    json.setFloat("w2", random(-1.2,1.2));

    json.setFloat("h0", random(-1.2,1.2));
    json.setFloat("h1", random(-1.,1.2));
    json.setFloat("h2", random(-1.2,1.));

    json.setFloat("s0",  randomGaussian()*1+ random(-1.,1.));
    json.setFloat("s1",  randomGaussian()*2+ random(-0.5,0.5));
    json.setFloat("s2", randomGaussian()*1+random(-.2,0.2));

    json.setFloat("cosT0",randomGaussian()*0.5+ random(-1,1));
    json.setFloat("cosT1", randomGaussian()*1+ random(-1,1));
    json.setFloat("cosT2", randomGaussian()*2+ random(-1,1));

    json.setFloat("sinT0", randomGaussian()*2+ random(-1,1));
    json.setFloat("sinT1", randomGaussian()*2+ random(-1,1));
    json.setFloat("sinT2", randomGaussian()*1+ random(-1,1));

    values.setJSONObject(i, json);
  }

  saveJSONArray(values, "data/new.json");
}
