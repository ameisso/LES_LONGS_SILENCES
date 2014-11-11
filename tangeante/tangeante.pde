//faire des cercles et quand on clique en afficher la tengante au point.

final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
ArrayList<Circle> circles;

import oscP5.*;
import netP5.*;

OscP5 oscP5;

PVector position;

void setup()
{ 
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "baseProject");
  circles = new ArrayList<Circle>(); 
  initCircles();

  oscP5 = new OscP5(this, 9999);
  position = new PVector(width/2, height/2);
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
          circle.testAlignment(testedCircle, position);
        }
      }
    }
  }
  for (int i = circles.size ()-1; i >= 0; i--)
  {
    Circle circle = circles.get(i);
    circle.displayLine(position);
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
} 

void keyPressed()
{
  if (key == 'r')
  {
    initCircles();
  }
}
void initCircles()
{
  circles.clear();
  circles.add(new Circle(new PVector(200, 300), 200));
  circles.add(new Circle(new PVector(700, 500), 75));
  /*circles.add(new Circle(new PVector(800, 700), 75));
  circles.add(new Circle(new PVector(300, 300), 100));
  /* circles.add(new Circle(new PVector(500, 600), 100));
   circles.add(new Circle(new PVector(900, 300), 100));
   circles.add(new Circle(new PVector(400, 80), 75));
   circles.add(new Circle(new PVector(730, 100), 75));
   circles.add(new Circle(new PVector(140, 640), 75));
   circles.add(new Circle(new PVector(600, 280), 75));
   circles.add(new Circle(new PVector(280, 500), 150));
   circles.add(new Circle(new PVector(320, 680), 75));
   circles.add(new Circle(new PVector(470, 420), 60));
   circles.add(new Circle(new PVector(130, 400), 80));
   circles.add(new Circle(new PVector(470, 215), 75));
   circles.add(new Circle(new PVector(900, 550), 75));*/

  /*int circleMaxSize = 100;
   int circleMinSize = 50;
   int circleMaxStep = 60;
   float circlesDensity = 0.4;
   for (int i = 0; i < width; i+= random (circleMaxSize, circleMaxStep))
   {
   for (int j = 0; j < height; j+= random (circleMaxSize, circleMaxStep))
   {
   float circleSize = random(circleMinSize-circlesDensity*circleMinSize, circleMaxSize );
   if (circleSize > circleMinSize)
   {
   circles.add(new Circle(new PVector(i, j), circleSize));
   }
   }
   }*/
}

void oscEvent(OscMessage theOscMessage)
{
  if (theOscMessage.addrPattern().equals("/position"))
  {
    position. x = theOscMessage.get(1).floatValue()*width;
    position. y =height - theOscMessage.get(0).floatValue()*height;
  }
} 

void mouseDragged()
{
  position.x = mouseX; 
  position.y = mouseY;
}

