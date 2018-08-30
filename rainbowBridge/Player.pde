class Player{
  boolean iswalking;
  boolean rightdirection;
  PImage[] walkanim = new PImage[8];
  PImage standsprite;
  int count;
  float xpos;
  float ypos;
  
  Player(){
    iswalking = false;
    rightdirection = true;
    xpos = width/2;
    ypos = height/2+40;
  }
  
  void move(){
    if (iswalking && rightdirection){
      imageMode(CENTER);
      image(walkanim[count%walkanim.length],xpos,ypos);
      if (frameCount%8==0){
        count++;
      }
    } else if (iswalking){
      imageMode(CENTER);
      scale(-1,1);
      image(walkanim[count%walkanim.length],-xpos,ypos);
      scale(-1,1);
      if (frameCount%8==0){
        count++;
      }
    
    } else if(rightdirection){
      imageMode(CENTER);
      image(standsprite,xpos,ypos);
    
    } else{
      imageMode(CENTER);
      scale(-1,1);
      image(standsprite,-xpos,ypos);
      scale(-1,1);
    
    }
  }
  
}
