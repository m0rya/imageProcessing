class Button {
  String name;
  PVector position;
  int wh;
  int ht;

  boolean sw =false;


  Button(int x, int y, int wh, int ht) {

    position = new PVector(x, y);
    this.wh = wh;
    this.ht = ht;
  }

  void setName(String s) {
    name = s;
  }

  void showButton() {
    fill(0, 150);
    strokeWeight(0);
    rect(position.x, position.y, wh, ht);

    fill(255);
    text(name, position.x+10, position.y+15);

    if (sw) {
      fill(255, 0, 0, 150);
      rect(position.x, position.y, wh, ht);
    }
  }

  void reset(int num, Button[] button) {
    if (mousePressed) {
      if (mouseX>position.x && mouseX<position.x+wh && mouseY>position.y && mouseY<position.y+ht) {
        for (int i=0; i<num; i++) {
          button[i].on_off(false);
        }
      }
    }
  }

  void mouseReleased() {
    if (mouseX>position.x && mouseX<position.x+wh && mouseY>position.y && mouseY<position.y+ht) {
      sw =! sw;
    }
  }

  public void on_off(boolean bool) {
    sw = bool;
  }
}

