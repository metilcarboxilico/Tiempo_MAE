

class CA {

  int[] cells;
  int [] ruleset ;// = new int[] {0, 0, 0, 0, 1, 0, 0, 0};

  int w=10;
  int generation=0;

  CA() {
    cells= new int [width/w];
    ruleset = new int[] {0, 1, 0, 1, 1, 0, 1, 0};

    //cells[cells.length/2]=1;
  }
  void loadGaussian() {

    for (int g=1; g < cells.length-1; g++) {

      cells[g] = round(constrain(randomGaussian(), 0, 1));
    }
    
    
  }
  
    void loadRandom() {

    for (int g=1; g < cells.length-1; g++) {

      cells[g] = int(random(2));
    }
    
    }
  void generate() {
    int[] nextGen =new int[cells.length];

    for (int c =1; c<cells.length-1; c++) {
      int left= cells[c-1];
      int me= cells[c];
      int right= cells[c+1];
      nextGen[c]=rules(left, me, right);
    }
    cells = nextGen;

    generation ++;
  }



  int rules(int a, int b, int c) {
    String s =""+a+b+c;
    int index = Integer.parseInt(s, 2);
    //println(index);
    return ruleset[index];
  }

  void display() {
    for (int c = 0; c < cells.length; c++) {
      if (cells[c]==1) fill(30);
      else fill(220);
      // float n = noise((generation+c)/100);
      rect(c * w, generation * w, w, w);
      /*
      pg.beginDraw();
       if (cells[c]==1) pg.fill(30);
       else pg.fill(220);
       // float n = noise((generation+c)/100);
       pg.rect(c * w, generation * w, w, w);
       pg.endDraw();
       */
    }
  }
}
