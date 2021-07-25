

color pxVideo(float x_, float y_, Movie video_) {
  video_.loadPixels();
  return   video_.pixels[int(x_)+int(y_)*video_.pixelWidth];//video_.get(int(x_), int(y_));//
  //video_.get(x_, y_);
}

class Cell {

  //int[][] tablero;

  float x, y, w;


  int state, previous;

  Cell(float x_, float y_, float w_) {
    x = x_;
    y = y_;
    w = w_;

    state = int(random(2));
    previous = state;
  }

  void savePrevious() {
    previous = state;
  }

  void newState(int s) {
    state = s;
  }

  void display() { //a modificar con un return?
    color colPx=0;
    if (previous==0&&state==1)colPx=pxVideo(x, y, a);
    else if (state==1)  colPx=pxVideo(x, y, b);
    else if (previous==1 && state==0) colPx=pxVideo(x, y, c); //colPx=color(30);  //
    else  colPx=pxVideo(x, y, d); //colPx = color(pxVideo(x, y, b),100);

/*
    loadPixels();
    pixels[int(x)+int(y)*width] =colPx ;
    updatePixels();
    */
    noStroke();
    fill(colPx);
     rect(x, y, w, w);//ellipse
  }
}

class AC {

  int w = 7;
  int columns, rows;

  // Game of life tablero
  Cell[][] tablero;


  AC() {
    // Initialize rows, columns and set-up arrays
    columns = width/w;
    rows = height/w;
    tablero = new Cell[columns][rows];
    init();
  }

  void init() {
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
        tablero[i][j] = new Cell(i*w, j*w, w);
      }
    }
  }

  // The process of creating the new generation
  void generate() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        tablero[i][j].savePrevious();
      }
    }


    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {

        // Add up all the states in a 3x3 surrounding grid
        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            neighbors += tablero[(x+i+columns)%columns][(y+j+rows)%rows].previous;
          }
        }

        // A little trick to subtract the current cell's state since
        // we added it in the above loop
        neighbors -= tablero[x][y].previous;

        // Rules of Life
        if      ((tablero[x][y].state == 1) && (neighbors <  2)) tablero[x][y].newState(0);           // Loneliness
        else if ((tablero[x][y].state == 1) && (neighbors >  3)) tablero[x][y].newState(0);           // Overpopulation
        else if ((tablero[x][y].state == 0) && (neighbors == 3)) tablero[x][y].newState(1);           // Reproduction
        // else do nothing!
      }
    }
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        tablero[i][j].display();
      }
    }
  }
}
