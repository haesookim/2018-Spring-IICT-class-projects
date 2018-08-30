class Pet {
  //parameters for movement
  boolean iswalking;
  boolean rightdirection;
  PImage[] walkanim = new PImage[8];
  PImage standsprite;
  int count = 0;
  float xpos;
  float ypos;

  //Parameters for evaluation
  int affect;
  int trainBathroom;
  int trainPlay;

  int health;

  //Feeding timer
  Timer feedTimer = new Timer(1000);

  //name
  String name;

  Pet() {
    iswalking = false;
    rightdirection = true;
    xpos = width/2 + 30;
    ypos = height/2 + 80;
    affect = 10;
    trainBathroom= 0;
    trainPlay = 0;
    health = 50;
  }

  void move() {
    feedTimer.startTime();
    if (stage == 4 || stage == 0 || stage ==1){
      feedTimer.run = false;
    } else{
      feedTimer.run = true;
    }
    if (feedTimer.isFinished()) {
      health--;
      feedTimer.startTime();
    }
    if (iswalking && rightdirection) {
      imageMode(CENTER);
      image(walkanim[count%walkanim.length], xpos, ypos);
      if (stage != 4) {
        if (frameCount%8==0) {
          count++;
        }
      } else {
        if (frameCount%12==0) {
          count++;
        }
      }
    } else if (iswalking) {
      imageMode(CENTER);
      scale(-1, 1);
      image(walkanim[count%walkanim.length], -xpos, ypos);
      scale(-1, 1);
      if (stage != 4) {
        if (frameCount%8==0) {
          count++;
        }
      } else {
        if (frameCount%12==0) {
          count++;
        }
      }
    } else if (rightdirection) {
      imageMode(CENTER);
      image(standsprite, xpos, ypos);
    } else {
      imageMode(CENTER);
      scale(-1, 1);
      image(standsprite, -xpos, ypos);
      scale(-1, 1);
    }
  }
}
