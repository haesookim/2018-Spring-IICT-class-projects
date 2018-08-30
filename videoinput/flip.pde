void flip(PImage cam){
  PImage buffer = new PImage(cam.width, cam.height);
  for(int i=0; i<cam.pixels.length; i++){
     buffer.pixels[i] = cam.pixels[i]; 
  }
  for(int x=0; x<cam.width; x++){
    for(int y=0; y<cam.height; y++){
      cam.pixels[y*cam.width+x] = buffer.pixels[y*cam.width+(cam.width-x-1)];
    }
  }
}
