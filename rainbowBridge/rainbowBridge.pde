
//basic settings
int stage = 0;
PFont pixel;
boolean stageDone = false;
boolean gameOver = false;
boolean aspet = false;
String output = "";
int threshold = 30;
boolean canmove = true;
boolean dothis = true;

//timers
Timer timeTitle;
Timer time;
Timer stayTimer;

//save the choices
//play = 1, train = 2, work = 3 feed = 4
int[] trainChoice = new int[10];
int[] affectChoice = new int[10];
int arraycounter = 0;
int counter = 10;

//background
PImage housebkg;
PImage shopbkg;
PImage bridgebkg;
float xpos;
float ypos;

//playercharacter
Player play;

//petcharacter
Pet pet;

//buttons
Button trainBtn;
Button feedBtn;
Button playBtn;
Button workBtn;
Button chooseBtn;
Button talkBtn;
Button stayBtn;

//reset Button
Button resetBtn;
Button restartBtn;

void setup() {
  size(900, 600);
  background(0);
  pixel = loadFont("RNTG-Larger-48.vlw");
  timeTitle = new Timer(2000);
  time = new Timer(3000);
  stayTimer = new Timer(10000);

  //initialize classes
  play = new Player();
  pet = new Pet();

  //initialize sprites
  for (int i = 0; i<8; i++) {
    play.walkanim[i] = loadImage("sprite-charwalk_"+i+".png");
    pet.walkanim[i] = loadImage("sprite-petwalk_"+i+".png");
  }
  play.standsprite = loadImage("sprite-charstand.png");
  pet.standsprite = loadImage("Dog_Walk.png");
  housebkg = loadImage("housebkg.png");
  shopbkg = loadImage("shopbkg.png");
  bridgebkg = loadImage("bridgebkg.png");

  //initialize background location
  xpos = 900;
  ypos = height/2;

  //initialize buttons
  chooseBtn = new Button("I'LL HAVE YOU", 350, 100);
  talkBtn = new Button("TALK", 550, 100);
  chooseBtn.xsize = 120;

  trainBtn = new Button("TRAIN", 150, 100);
  feedBtn = new Button("FEED", 350, 100);
  playBtn = new Button("PLAY", 550, 100);
  workBtn = new Button("WORK", 750, 100);
  stayBtn = new Button("STAY", 550, 100);

  resetBtn = new Button("RESET", 70, 50);
  resetBtn.isReset = true;
  resetBtn.isActive = true;
  restartBtn = new Button("RESTART", width/2, 530);
  restartBtn.isReset = true;
  restartBtn.isActive = true;
}

//initialize stages
Stage begin = new Stage("Chapter 1. Beginnings", 0);
Stage adapt = new Stage("Chapter 2. Adaptations", 1);
Stage affect = new Stage("Chapter 3. Affection", 2);
Stage goodbye = new Stage("Chapter 4. Goodbyes", 3);

void draw() {

  //draw and animate background
  background(0);
  imageMode(CENTER);

  if (timeTitle.isFinished()) {
    resetBtn.show();
    if (stage==2 || stage==3) {
      xpos = constrain(xpos, 0, 900);
      image(housebkg, xpos, ypos);
      trainBtn.show();
      feedBtn.show();
      playBtn.show();
      workBtn.show();

      textAlign(CENTER, CENTER);
      textFont(pixel, 20);
      text("Choices remaining:" + counter, width/2, 50);
      textAlign(LEFT);
      textFont(pixel, 15);
      text("Health Level:" + pet.health, 100, 480);
      text("Bathroom Training: " + pet.trainBathroom, 100, 500);
      text("Play Training: " + pet.trainPlay, 100, 520);
      text("Affection: " + pet.affect, 100, 540);
    } else if (stage == 1) {
      xpos = constrain(xpos, 100, 900);
      chooseBtn.show();
      talkBtn.show();
      image(shopbkg, xpos, ypos);
    } else if (stage ==4) {
      xpos = constrain(xpos, 0, 900);
      workBtn.xpos = 350;
      workBtn.show();
      stayBtn.show();
      image(housebkg, xpos, ypos);
    } else {
      image(bridgebkg, width/2, height/2);
    }
  } else if (stage ==0) {
    image(bridgebkg, width/2, height/2);
  }
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == RIGHT) xpos -= 2;
      if (keyCode == LEFT) xpos += 2;
    }
  }

  //gameover flag
  if (pet.health <0 || pet.affect < 0) {
    gameOver = true;
  }

  //check if gameover flag stands and send to ending
  if (gameOver) {
    stage = 5;
  }

  switch (stage) {
  case 0:
    startScreen();
    break;
  case 1:
    begin.show();
    beginnings();
    break;
  case 2:
    adapt.show();
    adaptation();
    break;
  case 3:
    affect.show();
    affection();
    break;
  case 4:
    goodbye.show();
    goodbye();
    break;
  case 5:
    gameEnd();
    break;
  }
}

void startScreen() {

  textAlign(CENTER);
  textFont(pixel, 30);
  text("Rainbow Bridge", width/2, height/2-100);
  textFont(pixel, 20);
  text("Click Anywhere to begin", width/2, height/2);
}


void keyPressed() {
  //move
  if (canmove) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        play.iswalking = true;
        play.rightdirection = false;
        pet.iswalking = true;
        pet.rightdirection = false;
      } else if (keyCode == RIGHT) {
        play.iswalking = true;
        play.rightdirection = true;
        pet.iswalking = true;
        pet.rightdirection = true;
      }
    }
  }
}

void keyReleased() {
  if (canmove) {
    if (key == CODED) {
      if (keyCode == LEFT || keyCode == RIGHT) {
        play.iswalking = false;
        pet.iswalking = false;
      }
    }
  }
}

//clicks

void mouseClicked() {
  //  code for reset button
  if (resetBtn.isIn()||restartBtn.isIn()) {
    reset();
  } else if (stage == 0) {
    timeTitle.startTime();
    stage = 1;
  }

  //stage 1
  if (talkBtn.isActive && talkBtn.isIn()) {
    talkBtn.clickcounter++;
  }

  //stage 2
  if (stage==2) {
    if (playBtn.isActive && playBtn.isIn()) {
      trainChoice[arraycounter] = 1;
      pet.trainPlay +=2;
      pet.affect +=2;
      arraycounter ++;
      counter--;
    }
    if (trainBtn.isActive && trainBtn.isIn()) {
      trainChoice[arraycounter] = 2;
      pet.trainBathroom +=2;
      pet.affect--;
      arraycounter ++;
      counter--;
    }
    if (workBtn.isActive && workBtn.isIn()) {
      trainChoice[arraycounter] = 3;
      pet.affect -=2;
      arraycounter ++;
      counter--;
    }
    if (feedBtn.isActive && feedBtn.isIn()) {
      trainChoice[arraycounter] = 4;
      pet.health +=10;
      arraycounter++;
      counter--;
    }
  }

  //stage 3
  if (stage==3) {
    if (playBtn.isActive && playBtn.isIn()) {
      affectChoice[arraycounter] = 1;
      pet.trainPlay +=2;
      pet.affect +=2;
      arraycounter ++;
      counter--;
    }
    if (trainBtn.isActive && trainBtn.isIn()) {
      affectChoice[arraycounter] = 2;
      pet.trainBathroom +=2;
      pet.affect--;
      arraycounter ++;
      counter--;
    }
    if (workBtn.isActive && workBtn.isIn()) {
      affectChoice[arraycounter] = 3;
      pet.affect -=2;
      arraycounter ++;
      counter--;
    }
    if (feedBtn.isActive && feedBtn.isIn()) {
      affectChoice[arraycounter] = 4;
      pet.health +=10;
      arraycounter++;
      counter--;
    }
  }

  //stage 4

  if (stage==4) {
    if (workBtn.isActive && workBtn.isIn()) {
      stage++;
    }
    if (stayBtn.isActive && stayBtn.isIn()) {
      stage++;
    }
  }
}

//beginnings stage interactions
void beginnings() {
  //conversation with shop owner
  if (xpos < 850 && xpos > 750) {
    talkBtn.isActive = true;
  } else {
    talkBtn.isActive = false;
  }
  if (talkBtn.isActive) {
    textAlign(LEFT);
    textFont(pixel, 20);
    text(output, 100, 500);
  }

  switch(talkBtn.clickcounter) {
  case 1:
    output = "We have a wide varity of pets here.";
    break;
  case 2:
    output = "See which one fits you best, and take him home!";
    break;
  case 3:
    output = "You'll have to see which one you can take home.";
    break;
  case 4:
    output = "Make sure you take good care of your pet when you do!";
    break;
  case 5: 
    output = "Feed him well, and make sure to train and play with him!";
    break;
  case 6:
    output = "";
    talkBtn.clickcounter = 0;
    break;
  }

  //take him home
  if (xpos < 130) {
    chooseBtn.isActive = true;
  } else {
    chooseBtn.isActive = false;
  }

  //give him a name
  if (chooseBtn.clicked) {
    textAlign(LEFT);
    textFont(pixel, 20);
    text("I'll have you.", 100, 500);
    time.startTime();
    if (time.isFinished()) {
      stage++;
      stageDone = true;
      chooseBtn.clicked = false;
    }
  }
}


//adaptation stage interactions
void adaptation() {
  //location for feedbutton
  if (xpos < 200 && xpos > 130) {
    feedBtn.isActive = true;
  } else {
    feedBtn.isActive = false;
  }
  //location for bathroom training
  if (xpos<430 && xpos>350) {
    trainBtn.isActive = true;
  } else {
    trainBtn.isActive = false;
  }

  //work or play
  if (xpos>850) {
    workBtn.isActive = true;
    playBtn.isActive = true;
  } else if (xpos<750 && xpos>650) {
    playBtn.isActive = true;
    workBtn.isActive = false;
  } else {
    playBtn.isActive = false;
    workBtn.isActive = false;
  }

  if (counter == 0) {
    counter = 10;
    arraycounter = 0;
    stageDone = true;
    stage++;
  }
}

//affection stage interactions
void affection() {
  if (xpos < 200 && xpos > 130) {
    feedBtn.isActive = true;
  } else {
    feedBtn.isActive = false;
  }

  //work or play
  if (xpos>850) {
    workBtn.isActive = true;
    playBtn.isActive = true;
  } else if (xpos<750 && xpos>650) {
    playBtn.isActive = true;
    workBtn.isActive = false;
  } else {
    playBtn.isActive = false;
    workBtn.isActive = false;
  }

  //bathroom event
  if (counter == 6 && pet.trainBathroom < 10) {
    if (dothis) {
      canmove = false;
      pet.feedTimer.run = false;
      time.startTime();
      pet.affect -=5;
      pet.health +=3;
    }
    if (!time.isFinished()) {
      fill(0);
      rect(width/2, 500, width, 130);
      fill(255);
      textAlign(LEFT);
      textFont(pixel, 20);
      text("He peed on the floor.", 100, 500);
      text("You have to scold him. Affection is deducted by 5.", 100, 550);
      xpos = constrain(xpos, xpos, xpos);
    } else {
      canmove=true;
      pet.feedTimer.run = true;
      xpos = constrain(xpos, 0, 900);
    }
    dothis = false;
  }
  
  if(counter==5){
    dothis = true;
  }

  if (counter == 3) {
    if (dothis) {
      canmove = false;
      pet.feedTimer.run = false;
      time.startTime();
      pet.health -=17;
    }
    if (!time.isFinished()) {
      fill(0);
      rect(width/2, 500, width, 130);
      fill(255);
      textAlign(LEFT);
      textFont(pixel, 20);
      text("He caught a virus somewhere.", 100, 500);
      text("He has to go to the hospital. Health is deducted by 20.", 100, 550);
      xpos = constrain(xpos, xpos, xpos);
    } else {
      canmove = true;
      pet.feedTimer.run = true;
      xpos = constrain(xpos, 0, 900);
    }
    dothis = false;
  }

  if (counter == 0) {
    stage++;
    stageDone = true;
    counter = 10;
  }
}
//goodbye stage interactions

void goodbye() {
  canmove = true;
  workBtn.isActive = true;
  stayTimer.startTime();
  if (stayTimer.isFinished() && pet.affect > threshold) {
    stayBtn.isActive = true;
    stayTimer.run = true;
  } else{
    stayBtn.isActive = false;
  }
}

void gameEnd() {
  pet.health = 100;
  canmove = false;
  restartBtn.show();
  if (pet.affect > threshold && !gameOver) {
    textFont(pixel, 30);
    text("Good Ending", width/2, height/2-100);
    play.move();
    pet.move();
    play.iswalking = true;
    play.rightdirection = true;
    pet.iswalking = true;
    pet.rightdirection = true;
  } else if (pet.affect > 0 && !gameOver) {
    textFont(pixel, 30);
    text("Normal Ending", width/2, height/2-100);
    pet.move();
    pet.iswalking = true;
    pet.rightdirection = true;
  } else {
    background(0);
    textFont(pixel, 30);
    text("Game Over", width/2, height/2-100);
    image(pet.standsprite, width/2, height/2);
    restartBtn.show();
  }
}

void reset() {
  //initialize settings
  stage = 0;
  stageDone = false;
  gameOver = false;
  aspet = false;
  output = "";

  ////initialize timers
  timeTitle = new Timer(2000);
  time = new Timer(3000);
  stayTimer = new Timer(10000);

  //initialise choices
  for (int i = 0; i<10; i++) {
    trainChoice[i] = 0;
    affectChoice[i] = 0;
  }
  counter = 10;
  arraycounter=0;

  //initialize buttonclicks
  chooseBtn.clicked = false;
  workBtn.xpos = 750;

  // go back to the same location
  xpos = 900;
  ypos = height/2;

  //initialize pet
  pet.affect = 10;
  pet.trainBathroom = 0;
  pet.trainPlay = 0;
  pet.health = 50;

  //initialize movement
  canmove = true;
  play.iswalking = false;
  pet.iswalking = false;
  
  //initialize events
  dothis = true;
}
