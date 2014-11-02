//faire des cercles et quand on clique en afficher la tengante au point.

final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
ArrayList<Circle> circles;

void setup() { 
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "baseProject");
  circles = new ArrayList<Circle>(); 
  circles.add(new Circle(new PVector(100, 200), 50));
  circles.add(new Circle(new PVector(700, 500), 75));
  circles.add(new Circle(new PVector(800, 700), 75));
  circles.add(new Circle(new PVector(300, 300), 100));
  circles.add(new Circle(new PVector(500, 600), 100));
  circles.add(new Circle(new PVector(900, 300), 100));
  circles.add(new Circle(new PVector(400, 80), 75));
  circles.add(new Circle(new PVector(730, 100), 75));
  circles.add(new Circle(new PVector(140, 640), 75));
  circles.add(new Circle(new PVector(600, 280), 75));
  circles.add(new Circle(new PVector(280, 500), 20));
  circles.add(new Circle(new PVector(320, 680), 75));
  circles.add(new Circle(new PVector(470, 420), 60));
  circles.add(new Circle(new PVector(130, 400), 80));
  circles.add(new Circle(new PVector(470, 215), 75));
  circles.add(new Circle(new PVector(900, 550), 75));
}

void draw() 
{
  canvas.beginDraw();
  canvas.noFill();
  canvas.stroke(255);
  canvas.strokeWeight(5.0);
  canvas.strokeCap(PROJECT);
  canvas.background(0);//0,0

    for (int i = circles.size ()-1; i >= 0; i--)
  {
    Circle circle = circles.get(i);
    if  ( ! circle.isLineAppearing )
    {
      circle.shouldDraw = false;
      for (int j = circles.size ()-1; j >= 0; j--)
      {
        if ( i != j)
        {
          Circle testedCircle = circles.get(j);
          circle.testAlignment(testedCircle, new PVector(mouseX, mouseY));
        }
      }
    }
  }
  for (int i = circles.size ()-1; i >= 0; i--)
  {
    Circle circle = circles.get(i);
    circle.displayLine(new PVector(mouseX, mouseY));
  }

  for (int i = circles.size ()-1; i >= 0; i--)
  {
    Circle circle = circles.get(i);
    canvas.fill(0);
    circle.display();
  }
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
  //println(mouseX, mouseY);
} 

