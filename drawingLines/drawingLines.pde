final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

Line test;
//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

void setup() { 
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "plans");
  test = new Line(0,0,width/2,height,100);
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);
  canvas.stroke(255);
  canvas.strokeWeight(10.0);
  canvas.strokeJoin(MITER);
  test.draw();


  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 

