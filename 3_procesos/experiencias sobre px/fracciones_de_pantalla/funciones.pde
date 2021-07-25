

color pxVideo(int x_, int y_, Movie video_) {
  video_.loadPixels();
  return   video_.pixels[x_+y_*video_.pixelWidth];
//video_.get(x_, y_);
  
}
