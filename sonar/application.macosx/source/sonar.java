import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import codeanticode.syphon.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sonar extends PApplet {

final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon

PGraphics canvas;
SyphonServer server;

float speed = 0;

public void setup()
{
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "sonar");
  background(0);
}

public void draw()
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
  for (int i = 0; i < 4; i++)
  {
    canvas.rotate(speed);
    speed+=0.001f;
    canvas.line(0, 0, 0, 298);
  }

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sonar" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
