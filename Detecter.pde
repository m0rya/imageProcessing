
class Detecter {
  OpenCV cv;
  PVector screen;


  //findContours
  ArrayList<Contour> contours;
  ArrayList<Contour> polygons;

  Detecter(PApplet app, int w, int h) {
    cv = new OpenCV(app, w, h);
    screen = new PVector(w, h);

    //backgroundSubtraction
    cv.startBackgroundSubtraction(5, 3, 0.5);
  }

  void backgroundSubtraction(Movie mov) {
    cv.loadImage(mov);

    cv.updateBackground();
    cv.dilate();
    cv.erode();
    noFill();
    stroke(255, 0, 0);
    strokeWeight(3);
    for (Contour contour : cv.findContours ()) {
      contour.draw();
    }
  }




  void findContours(Movie mov) {
    cv.loadImage(mov);
    cv.gray();
    cv.threshold(70);
    PImage dst = cv.getOutput();

    contours = cv.findContours();
    image(dst, 0, 0);
    noFill();
    strokeWeight(3);
    for (Contour contour : contours) {
      stroke(0, 255, 0);
      contour.draw();

      stroke(255, 0, 0);
      beginShape();
      for (PVector point : contour.getPolygonApproximation ().getPoints()) {
        vertex(point.x, point.y);
      }
      endShape();
    }
  }



  void findCannyEdges(Movie mov) {
    cv.loadImage(mov);
    cv.findCannyEdges(20, 75);
    image(cv.getSnapshot(), 0, 0);
  }
  
  void opticalFlow(Movie mov){
   
    cv.loadImage(mov);
    cv.calculateOpticalFlow();
    stroke(255,0,0,100);
    cv.drawOpticalFlow();
    
    PVector aveFlow = cv.getAverageFlow();
    int flowScale = 50;
    
    stroke(255);
    strokeWeight(2);
    line(screen.x/2, screen.y/2, screen.x/2+aveFlow.x*flowScale, screen.y/2 + aveFlow.y*flowScale);
    
  }
    
  
  void imageDiff(Movie mov){
    
  }
}

