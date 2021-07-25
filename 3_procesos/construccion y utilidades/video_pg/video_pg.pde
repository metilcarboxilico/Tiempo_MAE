import processing.video.*;


// tomado el esquema de https://forum.processing.org/two/discussion/9811/display-video-frames-within-pgraphics

PGraphics pg;
PImage img;
Movie movie;
 
 
void setup() 
{
  size(960,540,FX2D);
 
//img = loadImage("iStock_000015044044Small.jpg");
  movie = new Movie(this, "b.mp4");
  movie.loop();
  movie.read();
   pg = createGraphics(movie.width, movie.height);
}
 
void movieEvent(Movie m) {
  m.read();
}
 
void draw() 
{
  pg.beginDraw();
  //pg.image(img, 0, 0, width, height);
  pg.image(movie, 0, 0, width/2, height/2);
    //pg.resize(int(movie.width/4), int(movie.height/4));

  pg.endDraw();
  image(pg, 0, 0); 
}
