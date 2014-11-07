//TODO : the balls shouldnt be affected by the movement of the rectangle 


final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

import oscP5.*;
import netP5.*;

OscP5 oscP5;

float angle = 0;
PVector position;
Ball ball;
Ball ball2;

int rectWidth = 300; 
int rectHeight = 200;
int originalRectWidth = rectWidth;
int originalRectHeight = rectHeight;
int rectExtension = 10;
float timeRectWasExtended = -1;
ArrayList<Ball> balls;

void setup() 
{  
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "rectangle");
  oscP5 = new OscP5(this, 9999);

  position = new PVector(0,0);
  
  balls = new ArrayList<Ball>(); 
  balls.add  (new Ball(position.x, position.y, 20));
  balls.add  (new Ball(position.x+75, position.y+75, 10));
  

  //balls.add  (new Ball(float(mouseX-75), float(mouseY+75), 10));
}
void draw() 
{

  if (millis() - timeRectWasExtended > 50 && timeRectWasExtended>0)
  {
    rectWidth -= rectExtension;
    rectHeight -= rectExtension;
    timeRectWasExtended = -1;
  }
  canvas.beginDraw();
  canvas.background(0);
  canvas.pushMatrix();
  canvas.rectMode(CENTER);
  canvas.strokeWeight(2);
  canvas.noFill();
  canvas.translate(position.x, position.y);
  canvas.rotate(angle);

  for (int i = balls.size ()-1; i >= 0; i--)
  {
    Ball ball = balls.get(i);
    ball.checkCollisionwithRect(0, 0, originalRectWidth, originalRectHeight); 
    for (int j = balls.size ()-1; j >= 0; j--)
    {   
      if (i != j)
      {
        Ball ball2 = balls.get(j);
        ball.checkCollision(ball2);
      }
    }
    ball.update();
    ball.display();
  }


  for (int i = 0; i < 1; i++)
  {
    float rotateForce = 0.005;
    canvas.rotate(+random(-rotateForce, rotateForce));
    canvas.stroke(255);
    canvas.noFill();
    canvas.rect (random(3), random(3), rectWidth, rectHeight);
  }

  canvas.popMatrix();
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}


void oscEvent(OscMessage theOscMessage)
{
  if (theOscMessage.addrPattern().equals("/rotation"))
  {
    angle += theOscMessage.get(0).floatValue()/20.0;
   // println(" "+angle);
  } else if (theOscMessage.addrPattern().equals("/position"))
  {
     position. x = theOscMessage.get(1).floatValue()*width;
     position. y =height - theOscMessage.get(0).floatValue()*height;
  }

  if (theOscMessage.addrPattern().equals("/millumin/composition/cue"))
  {
    rectWidth += rectExtension;
    rectHeight += rectExtension;
    timeRectWasExtended = millis();
  }
} 

