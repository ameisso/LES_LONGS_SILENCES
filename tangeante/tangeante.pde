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
  circles.add(new Circle(new PVector(200, 200), 50));
  circles.add(new Circle(new PVector(200, 500), 75));
  circles.add(new Circle(new PVector(200, 700), 75));
  circles.add(new Circle(new PVector(200, 300), 100));
  circles.add(new Circle(new PVector(200, 600), 100));
  circles.add(new Circle(new PVector(200, 800), 100));
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

    circle.displayLine(new PVector(mouseX, mouseY));
    canvas.fill(255);
        circle.display();
  }

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 

