class Stage {
  String title;
  int stagenum;

  Stage(String _title, int num) {
    title = _title;
    stagenum = num;
  }

  void show() {
    if (!timeTitle.isFinished()) {
      textAlign(CENTER);
      textFont(pixel, 30);
      text(title, width/2, height/2);
    } else if (stagenum == 0) {
      play.move();
    } else {
      play.move();
      pet.move();
    }

    if (stageDone && timeTitle.isFinished()) {
      xpos = 900;
      timeTitle.startTime();
      stageDone = false;
    }
  }
}
