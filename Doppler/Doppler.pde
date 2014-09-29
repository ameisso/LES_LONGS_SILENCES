final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

boolean show = false;
int margin = 5;
int prevx, prevy;

float mainCircleRadiusMultiplier = 2;
int mainCircleGap = 8;
float mouseCircleRadiusMultiplier = 2;
int mouseCircleGap = 8;

void setup()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "Doppler");
  canvas.smooth();
  canvas.stroke(255);

  prevx = ((width/2)-(width*1/5)+int(random(0, width*2.0/5)));
  prevy = ((height/2)-(height*1/5)+int(random(0, height*2.0/5)));
}

void draw()
{
    background(0);
  canvas.beginDraw();
   canvas.stroke(255);

  canvas.background(0,0);
 
  canvas.noFill();


  DrawCircle(width/2, height/2, mainCircleRadiusMultiplier*sqrt(pow(height, 2)+pow(width, 2)), mainCircleGap);
  DrawCircle(mouseX, mouseY, mouseCircleRadiusMultiplier*sqrt(pow(height, 2)+pow(width, 2)), mouseCircleGap);

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

void DrawCircle(int xpos, int ypos, float radius, int gap)
{ 
  for (int i = 0; i < (radius / (2*gap)); i++)
  {
    canvas.ellipse(xpos, ypos, gap*(i+1), gap*(i+1));
  }
}

float rounder(float num, int factor)
{
  float p = (float)Math.pow(10, factor);
  num = num * p;
  float tmp = Math.round(num);
  return (float)tmp/p;
}

void keyPressed()
{
  if (key != CODED)
  {
    switch(key)
    {

    case 'w': 
      mainCircleGap++; 
          mouseCircleGap++; 
      break;
    case 's': 
      mainCircleGap--; 
            mouseCircleGap--; 
      break;
    }
  } 

  

  if (mainCircleRadiusMultiplier < 0) { 
    mainCircleRadiusMultiplier = 0;
  } else
    if (mainCircleGap < 1) { 
    mainCircleGap = 1;
  } else
    if (mouseCircleRadiusMultiplier < 0) { 
    mouseCircleRadiusMultiplier = 0;
  } else
    if (mouseCircleGap < 1) { 
    mouseCircleGap = 1;
  }
  redraw();
}

