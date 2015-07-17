class Menu {

  Movie mov;
  float movLength;
  int buttonRadius = 50;
  int barLength = 200;

  PVector[] ButtonPos = new PVector[4];
  PVector scrollPoint = new PVector();


  float skipInterval = 0.2;


  Menu(Movie _mov) {
    mov = _mov;

    movLength = mov.duration();
  }

  void setButtonPos(int x, int y) {
    for (int i=0; i<4; i++) {
      ButtonPos[i] = new PVector(x, y+i*buttonRadius);
    }
  }

  void drawButtons() {
    detectButtonPressed();
    detectScroll();



    drawStartButton(ButtonPos[0].x, ButtonPos[0].y);
    drawPauseButton(ButtonPos[1].x, ButtonPos[1].y);
    drawStopButton(ButtonPos[2].x, ButtonPos[2].y);
    drawScrollBar(ButtonPos[3].x, ButtonPos[3].y);


    drawNextFrameButton(ButtonPos[0].x+60, ButtonPos[0].y);
    drawPreviousFrameButton(ButtonPos[0].x-60, ButtonPos[0].y);
  }

  void drawStartButton(float x, float y) {
    fill(255);
    stroke(0);
    ellipse(x, y, 50, 50);

    fill(0, 200, 0);
    noStroke();
    PVector[] pnt = new PVector[3];
    for (int i=0; i<3; i++) {
      pnt[i] = new PVector(cos(radians(120*i))*20 + x, sin(radians(120*i))*20 + y);
      // println(pnt[i]);
    }

    beginShape();
    //for(int i=0; i<3; i++) vertex(pnt[i].x ,pnt[i].y, pnt[i].z);
    vertex(pnt[0].x, pnt[0].y);
    vertex(pnt[1].x, pnt[1].y);
    vertex(pnt[2].x, pnt[2].y);
    endShape(CLOSE);
  }

  void drawPauseButton(float x, float y) {
    fill(255);
    stroke(0);
    ellipse(x, y, 50, 50);

    fill(0, 200, 0);
    noStroke();
    rect(x+5, y-15, 10, 30);
    rect(x-15, y-15, 10, 30);
  }

  void drawStopButton(float x, float y) {
    fill(255);
    stroke(0);
    ellipse(x, y, 50, 50);

    fill(200, 0, 0);
    noStroke();
    rect(x-15, y-15, 30, 30);
  }


  void drawScrollBar(float x, float y) {

    rect(x-100, y-10, 200, 6);

    float h = mov.time();
    float pos = h/movLength*barLength;
    fill(0);
    stroke(255);
    scrollPoint.x = pos + x - 100;
    scrollPoint.y = y-8;
    ellipse(scrollPoint.x, scrollPoint.y, 20, 20);
  }


  void detectButtonPressed() {
    if (mousePressed) {
      for (int i=0; i<3; i++) {
        float dis = dist(mouseX, mouseY, ButtonPos[i].x, ButtonPos[i].y);
        if (dis < buttonRadius/2) {
          switch(i) {
          case 0:
            mov.play();
            break;
          case 1:
            mov.pause();
            break;
          case 2:
            mov.stop();
            break;
          default:
            break;
          }
        }
      }


      detectNextPreviousFrameButtonPressed();
    }
  }




  void drawNextFrameButton(float x, float y) {


    fill(255);
    stroke(0);
    ellipse(x, y, 50, 50);

    fill(0, 200, 0);
    noStroke();


    PVector[][] pnt = new PVector[2][3];

    for (int i=0; i<3; i++) {
      pnt[0][i] = new PVector(cos(radians(i*120))*10 +x+50/4, sin(radians(i*120))*10+y);
      pnt[1][i] = new PVector(cos(radians(i*120))*10 +x-50/4, sin(radians(i*120))*10+y);
    }

    beginShape();
    for (int i=0; i<3; i++) vertex(pnt[0][i].x, pnt[0][i].y);
    endShape(CLOSE);

    beginShape();
    for (int i=0; i<3; i++) vertex(pnt[1][i].x, pnt[1][i].y);
    endShape(CLOSE);
  }

  void drawPreviousFrameButton(float x, float y) {
    fill(255);
    stroke(0);
    ellipse(x, y, 50, 50);

    fill(0, 200, 0);
    noStroke();


    PVector[][] pnt = new PVector[2][3];

    for (int i=0; i<3; i++) {
      pnt[0][i] = new PVector(cos(radians(180+i*120))*10 +x+50/4, sin(radians(180+i*120))*10+y);
      pnt[1][i] = new PVector(cos(radians(180+i*120))*10 +x-50/4, sin(radians(180+i*120))*10+y);
    }

    beginShape();
    for (int i=0; i<3; i++) vertex(pnt[0][i].x, pnt[0][i].y);
    endShape(CLOSE);

    beginShape();
    for (int i=0; i<3; i++) vertex(pnt[1][i].x, pnt[1][i].y);
    endShape(CLOSE);
  }

  void detectNextPreviousFrameButtonPressed() {
    float disNext = dist(mouseX, mouseY, ButtonPos[0].x+60, ButtonPos[0].y);
    float disPrevious = dist(mouseX, mouseY, ButtonPos[0].x-60, ButtonPos[0].y);

    if (disNext < 50/2) {
      float NextFrame = mov.time() + 0.2;

      mov.jump(NextFrame);
      mov.play();
      mov.pause();
    }

    if (disPrevious < 50/2) {
      float PreviousFrame = mov.time() - 0.5;
      println(mov.time());
      println(PreviousFrame);
      mov.jump(PreviousFrame);
      mov.play();
      mov.pause();
    }
  }




  void detectScroll() {
    if (mousePressed) {
      float dis = dist(mouseX, mouseY, scrollPoint.x, scrollPoint.y);
      if (dis < 20) {
        scrollPoint.x = mouseX;
        float nextPos = (mouseX + 100 - ButtonPos[3].x)/barLength*movLength;
        mov.jump(nextPos);
      }
    }
  }
}

