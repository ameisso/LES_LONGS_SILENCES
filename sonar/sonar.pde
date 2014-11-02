final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

float speed = 0;

void setup()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "sonar");
  background(0);
}

void draw()
{
  canvas.beginDraw();
 // canvas.background(0, 0);
  canvas.noStroke();
  canvas.fill(0, 50); 
  canvas.rect(0, 0, width, height);

  canvas.stroke(255);
  canvas.noFill();
  canvas.strokeWeight(3);
  canvas.ellipse(width/2, height/2, 600, 600);

  canvas.stroke(255);
  canvas.strokeWeight(8);
  canvas.translate (width/2, height/2);
  for (int i = 0; i < 2; i++)
  {
    canvas.rotate(speed);
    speed+=0.01;
    canvas.line(0, 0, 0, 298);
  }

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

