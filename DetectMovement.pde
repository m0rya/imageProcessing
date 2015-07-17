class DetectMovement {
  int scopeLength = 60;

  PVector ScopePos = new PVector(0, 0);


  void drawDetectScope() {
    moveScopePos();

    noFill();
    strokeWeight(1);
    stroke(255, 0, 0);
    rectMode(CORNER);
    rect(ScopePos.x, ScopePos.y, scopeLength, scopeLength);

    rectMode(CORNER);
  }

  void setScopePos() {
  }

  void moveScopePos() {
    if (mousePressed) {
      float dis = dist(mouseX, mouseY, ScopePos.x, ScopePos.y);

      if (dis < 100) {
        ScopePos.x = mouseX;
        ScopePos.y = mouseY;
      }
    }
  }


  void showPixels(int x, int y) {

    loadPixels();

    rectMode(CENTER);
    noStroke();
    for (int i=0; i<scopeLength-1; i++) {
      for (int j=0; j<scopeLength-1; j++) {

        int pos = int(ScopePos.x+i+1 + (ScopePos.y+j+1)*width);
        color c = pixels[pos];

        fill(c);
 
        rect(x+i*5, y+j*5, 5, 5);
      }
    }

    rectMode(CORNER);
  }
  
  
  
  
  void setDetectBase(){
  }
  
  
  void detectStart(){
  }
  
  
  
  
}

