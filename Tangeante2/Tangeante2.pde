final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
ArrayList<Circle> circles;
ArrayList<Line> lines;
import oscP5.*;
import netP5.*;

OscP5 oscP5;

PVector position;
boolean forceLineDisplay = false;
void setup()
{ 
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "baseProject");
  circles = new ArrayList<Circle>(); 
  lines = new ArrayList<Line>();
  initCircles();
  initLines();
  oscP5 = new OscP5(this, 9999);
  position = new PVector(width/2, height/2);
}


void draw() 
{

  //initCircles();
  //initLines();
  canvas.beginDraw();
  canvas.noFill();
  canvas.stroke(255);
  canvas.strokeWeight(5.0);
  canvas.strokeCap(PROJECT);
  canvas.background(0);//0,0

    for (int i = circles.size ()-1; i >= 0; i--)
  {
    Circle circle = circles.get(i);
    canvas.fill(0);
    circle.display();
  }

  for (int i = lines.size ()-1; i >= 0; i--)
  {
    Line line = lines.get(i);
    if (line.crossCursor(position))
    {
      if (line.startDate < 0)
      {
        line.startDate = millis();
      }
      line.display();
    }
  }

  if (forceLineDisplay)
  {
    for (int i = lines.size ()-1; i >= 0; i--)
    {
      Line line = lines.get(i);
      line.forceDisplay();
    }
  }
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 


void initCircles()
{
  circles.clear();
  circles.add(new Circle(new PVector(200, 300), 200));
  circles.add(new Circle(new PVector(133, 459), 145));
  circles.add(new Circle(new PVector(469, 198), 373));
  circles.add(new Circle(new PVector(338, 490), 265));
  circles.add(new Circle(new PVector(517, 521), 94));
  circles.add(new Circle(new PVector(740, 101), 201));
  circles.add(new Circle(new PVector(809, 286), 195));
  circles.add(new Circle(new PVector(659, 435), 231));
  circles.add(new Circle(new PVector(599, 636), 184));
  circles.add(new Circle(new PVector(821, 626), 263));
}

void initLines()
{
  lines.clear();
  color red = color (255, 0, 0);
  lines.add  (new Line(250, 500, 250, 350, 2, red));
  lines.add  (new Line(108, 93, 498, 462, 2, red));
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

void keyPressed()
{
  if (key == 'r')
  {
    initCircles();
  } else if (key =='c')
  {
    forceLineDisplay = !forceLineDisplay;
  }
}

