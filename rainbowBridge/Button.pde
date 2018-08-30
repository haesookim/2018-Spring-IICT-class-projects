class Button{
  String title;
  int xpos, ypos;
  int xsize, ysize;
  boolean isActive;
  boolean isReset;
  boolean clicked;
  int clickcounter;
  
  Button(String _title, int _xpos, int _ypos){
    title = _title;
    xpos = _xpos;
    ypos = _ypos;
    xsize = 80;
    ysize = 40;
    isActive = false;
    clicked = false;
    isReset = false;
    clickcounter = 0;
    
  }
  
  void show(){
    rectMode(CENTER);
    noStroke();
    if (isReset){
      fill(#D30007);
    } else if(isActive){
      fill(#3BC150);
    }else{
      fill(127);
    }
    rect(xpos,ypos,xsize,ysize,10);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(10);
    text(title, xpos, ypos);
    
    if (mousePressed){
      if (isActive && isIn() &&!clicked){
        clicked = true;
      }
    }
  }
  
  boolean isIn(){
   if (mouseX<xpos+xsize/2 && mouseX>xpos-xsize/2 && mouseY<ypos+ysize/2 && mouseY>ypos-ysize/2){
     return true;
   }else{
     return false;
   }
  }
  
  

}
