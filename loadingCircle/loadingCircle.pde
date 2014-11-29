final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

float r = 300;
float w = 40;
float h = 10;
float spaceBetweenBox = 10;
int numberOfBox = 38;
int selectedBox = 0;

float lastUpdate = -1;

void setup() { 
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "loadingCircle");
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);
  canvas.stroke(255);
  canvas.noFill();
  canvas.smooth();
  canvas.strokeWeight(1);
  canvas.ellipse(width/2, height/2, 2*r, 2*r);
  canvas.rectMode(CENTER);
  canvas.stroke(255);
  canvas.strokeWeight(8);
  canvas.translate (width/2, height/2);

  float arclength = 0;
  for (int i = 0; i < 10; i++) 
  {
    arclength += w/2.0 + spaceBetweenBox/2.0;
    float theta = arclength / r;     
    canvas.pushMatrix();
    canvas.translate(r*cos(theta), r*sin(theta));
    canvas.rotate(theta);
    canvas.noStroke();
    if (i == selectedBox)
    {
      canvas.fill(255);
    } else
    {
      canvas.fill(100);
    }
    canvas.rectMode(CENTER);
    canvas.rect(0, 0, w, h);  
    canvas.popMatrix();
    arclength += w/2 + spaceBetweenBox/2.0;
  }
  if  (millis() - lastUpdate > 40)
  {
    selectedBox ++;
    if  (selectedBox > numberOfBox)
    {
      selectedBox =0;
    }
    lastUpdate = millis();
  }
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 

