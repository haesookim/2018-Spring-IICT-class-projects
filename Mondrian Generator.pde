void setup(){
  size(600,600);
  background(255);

}

void draw(){
}

void mouseClicked(){
  background(255);
  drawRect rect1 = new drawRect(int(random(5)),0,0);
  drawRect rect2 = new drawRect(int(random(11)),rect1.xpos+rect1.sizeX, rect1.ypos+rect1.sizeY);
  drawRect rect3 = new drawRect(int(random(9)),rect2.xpos+rect2.sizeX, rect2.ypos);
  drawRect rect4 = new drawRect(int(random(8)),rect1.xpos+rect1.sizeX, rect1.ypos);
  drawRect rect5 = new drawRect(int(random(10)),rect4.xpos+rect4.sizeX, rect3.ypos+rect3.ypos);
  drawRect rect6 = new drawRect(int(random(11)),rect3.xpos+rect3.sizeX, rect5.ypos);
  strokeWeight(8);
  line(0,rect4.ypos,width,rect4.ypos);
  line(0,rect2.ypos,width,rect2.ypos);
  line(rect2.xpos,0,rect2.xpos,height);
  line(0,rect6.ypos,width,rect6.ypos);
  line(0,rect3.ypos,width,rect3.ypos);
  line(rect5.xpos,0,rect5.xpos,height);
  strokeWeight(16);
  noFill();
  rect(0,0,600,600);
  
}


class drawRect{
  float sizeX = random(100,400);
  float sizeY = random(100,400);
  float xpos;
  float ypos;
  drawRect(int type, float posx, float posy){
    xpos = posx;
    ypos = posy;
    strokeWeight(8);
    if (type == 0){
      fill(255,0,0);
      rect(xpos,ypos,sizeX, sizeY);
    }
    if (type == 1){
      fill(255,255,0);
      rect(xpos,ypos,sizeX, sizeY);
    }
    if (type == 2){
      fill(0,0,255);
      rect(xpos,ypos,sizeX, sizeY);
    }
    if (type > 3 && type < 10) {
      noFill();
      rect(xpos,ypos,sizeX, sizeY);
    }
    if (type==10) {
      fill(0);
      rect(xpos,ypos,sizeX, sizeY);
    }
  }
}
