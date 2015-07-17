import processing.video.*;
import gab.opencv.*;

Movie movie;
Menu  menu;
DetectMovement dm;
Detecter detecter;

final int BUTTON_NUM = 5;
Button[] button = new Button[BUTTON_NUM];

OpenCV opencv;
ArrayList<Contour> contours;
ArrayList<Contour> polygons;


void setup() {
  size(1184, 720);
  movie = new Movie(this, "Lxor2.mp4");
  movie.loop();

  menu = new Menu(movie);
  //movie.speed(5.0);
  noStroke();
  println(movie.duration());

  menu.setButtonPos(width-200, 50);


  detecter = new Detecter(this, 854, 480);

  dm = new DetectMovement();


  //Button
  button[0] = new Button(10, 490, 200, 20);
  button[0].setName("findContours");

  button[1] = new Button(10, 510+3, 200, 20);
  button[1].setName("backgroundSubtrakction");

  button[2] = new Button(10, 530+ 3*2, 200, 20);
  button[2].setName("findCannyEdges");

  button[3] = new Button(10, 550 + 3*3, 200, 20);
  button[3].setName("opticalFlow");
  button[4] = new Button(10, 580 + 3*4, 200, 20);
  button[4].setName("RESET");
}

void draw() {
  background(50);

  menu.drawButtons();
  //menu.drawScrollBar(width-200, 200);
  image(movie, 0, 0);

  for (int i=0; i<BUTTON_NUM; i++) {
    button[i].showButton();
  }



  if (button[0].sw) {
    detecter.findContours(movie);
  }
  if (button[1].sw) {
    detecter.backgroundSubtraction(movie);
  }

  if (button[2].sw) {
    detecter.findCannyEdges(movie);
  }
  if (button[3].sw) {
    detecter.opticalFlow(movie);
  }
  button[4].reset(BUTTON_NUM, button);


  dm.drawDetectScope();
  dm.showPixels(width - 320, 300);
}


//called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}

void mouseReleased() {

  for (int i=0; i<BUTTON_NUM; i++) {
    button[i].mouseReleased();
  }
}

