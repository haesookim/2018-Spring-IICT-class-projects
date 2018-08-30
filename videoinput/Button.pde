class Button {
  String title;
  int xpos, ypos;
  int xsize, ysize;
  boolean clicked;

  Button(String _title, int _xpos, int _ypos) {
    title = _title;
    xpos = _xpos;
    ypos = _ypos;
    xsize = 80;
    ysize = 40;
    clicked = false;
  }

  void show() {
    rectMode(CENTER);
    noStroke();
    fill(0);
    rect(xpos, ypos, xsize, ysize, 10);
    textAlign(CENTER, CENTER);
    fill(255);
    textSize(12);
    text(title, xpos, ypos);

    if (mousePressed) {
      if (isIn()) {
        clicked = !clicked;
      }
    }
  }

  boolean isIn() {
    if (mouseX<xpos+xsize/2 && mouseX>xpos-xsize/2 && mouseY<ypos+ysize/2 && mouseY>ypos-ysize/2) {
      return true;
    } else {
      return false;
    }
  }
}
