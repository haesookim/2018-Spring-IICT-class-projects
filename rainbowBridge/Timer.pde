class Timer {
  int savedTime;
  int interval;
  int timePassed;
  boolean run;

  Timer(int _interval) {
    interval = _interval;
    savedTime = millis();
    run = false;
  }

  void startTime() {
    if (!run) {
      savedTime = millis();
      run = true;
    }
  }

  boolean isFinished() {
    timePassed = millis()-savedTime;
    if (timePassed > interval) {
      run = false;
      return true;
    } else {
      return false;
    }
  }
}
