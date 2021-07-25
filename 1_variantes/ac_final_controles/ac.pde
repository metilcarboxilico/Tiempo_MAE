
class Ac {
    
    
    int w = int(random(width));
    int h = int(random(height));
    int id;
    
    boolean isRulRange = false;
    float posX, posY;
    float zoomAcX = 1.0, zoomAcY = 1.0, zoomImgX = 1.0, zoomImgY = 1.0;
    
    
    float vida;
    //float reductorVida = -0.5;// a futuro lo incorporare en el json
    float cnt = 0.0;
    
    PShader maskShader;
    PShader ac;
    
    PGraphics pg;
    PGraphics base;
    PImage salida;
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float dft = (float)(norm *-  255 *0.31 );
    
    float bias[] = {1.0, 1.0, 1.0, 1.0, //para 
        1.0,1.0, 1.0, 1.0, 
    0.0 };
    float divisor = 8.0;
    
    int   modulo;
    
    
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    float sclrand;
    float rndX;
    float rndY;
    
    float posX0;
    float posX1;
    float posX2;
    
    float posY0;
    float posY1;
    float posY2;
    
    float  w0;
    float  w1;
    float  w2;
    
    float h0;
    float  h1;
    float  h2;
    
    float s0;
    float s1;
    float s2;
    
    float cosT0;
    float cosT1;
    float cosT2;
    
    
    float sinT0;
    float sinT1;
    float sinT2;
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //;float minmax[]=
    float rulRange[] = {(float)(norm * 0),(float)(norm * 100), 
           (float)(norm * 220),(float)(norm * 255), 
           (float)(norm * 200),(float)(norm * 255), 
           (float)(norm * 200),(float)(norm * 255), 
           (float)(norm * 200),(float)(norm * 255), 
           (float)(norm * 200),(float)(norm * 255)};
    
    //float rulset[];
    float resultado[] = {
       (float)(norm * 0.1 * random(160)), 
           (float)(norm * random(180)), 
           (float)(norm * random(110, 180)), 
           (float)(norm * random(220, 255)), 
           (float)(norm * random(255)), 
           (float)(norm * random(45))
        };
    
    float rulset[] = {
       (float)(norm * 30),(float)(norm * 70), 
           (float)(norm * 100),(float)(norm * 165), 
           (float)(norm * 210),(float)(norm * 220)
        };
    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    Ac(JSONObject json_) {
        
        pg = createGraphics(w, h, P2D);
        pg.noSmooth();
        base = createGraphics(w, h, P2D);
        base.noSmooth();
        
        posX = random(width / 2);//setearlo desde json
        posY = random(height / 2);
        
        salida = createImage(w, h, RGB);
        
        //seteo por via json del
        setJSON(json_);
        
        maskShader = loadShader("mask json mid.glsl");
        maskShader.set("resolution", float(w), float(h));
        
        setMask();
    }
    //resetShader();
    
    
    void setAcShader() {
        //seteo del sahder del automata celular
        
        setShader();
        ac.set("resolution", float(pg.width), float(pg.height));  
        
        ac.set("rules", rulset);
        ac.set("dft", dft);
        ac.set("sclrand", sclrand);
        ac.set("rndX", rndX);
        ac.set("rndY", rndY);
        ac.set("modulo", 3);
        
        ac.set("bias", bias);
        
        ac.set("divisor", divisor);
    }
    
    
    void actualizar() {
        
        cnt += 20;
        //vida += reductorVida *randomGaussian();
        ac.set("time", millis() / 1000.0);
        ac.set("frame", float(frameCount));
        ac.set("iniciar", cnt); //si es <50 se activa el AC
        
        maskShader.set("time", millis() / 1000.0);
    }
    
    
    
    
    void dibujar(PImage img_) {
        this.dibujar(img_, posX, posY, w, h);
    }
    
    
    void dibujar(PImage img_, float x_, float y_) {
        //dibujar(img_, x_,  y_, 100, 100 ); 
        this.dibujar(img_, x_, y_, w, h);
    }
    
    
    void dibujar(PImage img_, float x_, float y_, float w_, float h_) {
        //background(170);
        
        pg.beginDraw();
        pg.background(0);
        pg.shader(ac);
        pg.rect(0, 0, pg.width, pg.height);
        pg.endDraw();
        //creo q vot a tenerque poner todo dentro de otro pg
        //shader(maskShader); 
        
        //salida = createImage(w, h, RGB);
        salida.copy(img_, 0,0, pg.width, pg.height, 0, 0, int(pg.width * zoomImgX), int(pg.height * zoomImgY));
        
        salida.mask(pg);
        
        base.beginDraw();
        base.background(0);
        base.shader(maskShader);
        base.endDraw();
        
        base.mask(base);
        
        //aunque parezca poco ideal me ahorre crear un pg 
        //y pronto pensare como afectar correctamente el canal alfa dentro del shader, 
        base.beginDraw();
        base.image(salida, 0, 0, pg.width * zoomAcX, pg.height * zoomAcY);
        base.endDraw();
        
        //base.mask(base);
        image(base, x_, y_, w_, h_);
    }
    
    //para evitar confusiones deberia nombrar los set q modifican una val change y los q setean al shader set
    
    void setDivisor(float k_) {
        this.divisor = k_;
        this.ac.set("divisor", divisor);
    }
    void setDivisor() {
        this.ac.set("divisor", divisor);
    }
    
    void setBias(float[] bias_) {
        this.bias = bias_;
        this.ac.set("bias", bias);
    }
    void setBias() {
        this.ac.set("bias", bias);
    }
    void setDefault() {
        ac.set("dft", dft);
    }
    void setDefault(float dft_) {
        dft = dft_;
        ac.set("dft", dft);
    }
    void setDefaultNorm(float dft_) {
        dft = (float)(norm * dft_);
        ac.set("dft", dft);
    }
    
    
    void setAcToRange() {
        this.isRulRange = true;
        this.setShader();
        this.reShader();
        
    }
    void setAcInvert() {
        this.isRulRange = !isRulRange;
        
        this.setShader();
        this.reShader();
    }
    void setAcToSimple() {
        this.isRulRange = false;
        this.setShader();
        this.reShader();
        
    }
    
    void reShader() {
        pg.beginDraw();
        pg.resetShader();
        pg.endDraw();
    }
    void setRange(float[] fA_) {
        rulRange = fA_;
        //ac.set("rules", rulset); 
        
    }
    /*
    void setRul(float[] fA_) { //podria omitirlo y usar rulset
    rulset =fA_;
}
    */
    void resetCtn(){
     cnt=0; 
    }
    
    void setResultado(float[] fA_) {
        resultado = fA_;
        
    }
    
    void setRulset() {
        ac.set("rules", rulset); 
    }
    void setRulset(float[] fA_) {
        rulset = fA_;
    }
    
    
    void seteoResRange() { 
        if (isRulRange) { 
            ac.set("minmax", rulRange);
        } else {
            ac.set("resul", resultado);
        }
    }
    
    void setZoomAcX(float k_) {
        this.zoomAcX = k_;
    } 
    void setZoomAcY(float k_) {
        this.zoomAcY = k_;
    }
    void setZoomImgX(float k_) {
        this.zoomImgX = k_;
    }
    void setZoomImgY(float k_) {
        this.zoomAcY = k_;
    }
    
    
    
    
    
    boolean isDead() {
        if (vida <= 0) {
            return true;
        } else {
            return false;
        }
    }
    
    
    
    //----------------seteos fundamentales-------------------
    
    void setShader() { 
        if (isRulRange) { 
            ac = loadShader("ac arrayrand.glsl");
            ac.set("minmax", rulRange);
        } else {
            ac = loadShader("ac array.glsl");
            ac.set("resul", resultado);
        }
    }
    
    
    void setMask() {
        
        maskShader.set("sclrand", sclrand);
        
        maskShader.set("rndX", rndX);
        maskShader.set("rndY", rndY);
        
        maskShader.set("posX0", posX0);
        maskShader.set("posX1", posX1);
        maskShader.set("posX2", posX2);
        
        maskShader.set("posY0", posY0);
        maskShader.set("posY1", posY1);
        maskShader.set("posY2", posY2);
        
        maskShader.set("w0", w0);
        maskShader.set("w1", w1);
        maskShader.set("w2", w2);
        
        maskShader.set("h0", h0);
        maskShader.set("h1", h1);
        maskShader.set("h2", h2);
        
        maskShader.set("s0", s0);
        maskShader.set("s1", s1);
        maskShader.set("s2", s2);
        
        maskShader.set("cosT0", cosT0);
        maskShader.set("cosT1", cosT1);
        maskShader.set("cosT2", cosT2);
        
        maskShader.set("sinT0", sinT0);
        maskShader.set("sinT1", sinT1);
        maskShader.set("sinT2", sinT2);
    }
    
    void setJSON(JSONObject obj) {
        
        id = obj.getInt("id");
        
        sclrand = obj.getFloat("sclrand");
        rndX = obj.getFloat("rndX");
        rndY = obj.getFloat("rndY");
        
        posX0 = obj.getFloat("posX0");
        posX1 = obj.getFloat("posX1");
        posX2 = obj.getFloat("posX2");
        
        posY0 = obj.getFloat("posY0");
        posY1 = obj.getFloat("posY1");
        posY2 = obj.getFloat("posY2");
        
        w0 = obj.getFloat("w0");
        w1 = obj.getFloat("w1");
        w2 = obj.getFloat("w2");
        
        h0 = obj.getFloat("h0");
        h1 = obj.getFloat("h1");
        h2 = obj.getFloat("h2");
        
        s0 = obj.getFloat("s0");
        s1 = obj.getFloat("s1");
        s2 = obj.getFloat("s2");
        
        cosT0 = obj.getFloat("cosT0");
        cosT1 = obj.getFloat("cosT1");
        cosT2 = obj.getFloat("cosT2");
        
        sinT0 = obj.getFloat("sinT0");
        sinT1 = obj.getFloat("sinT1");
        sinT2 = obj.getFloat("sinT2");
    }
    
    
    ///////////////////////FIN AC/////////////////////////////////////////////
}
