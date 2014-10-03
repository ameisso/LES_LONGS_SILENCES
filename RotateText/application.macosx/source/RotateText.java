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

public class RotateText extends PApplet {

final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon

PGraphics canvas;
SyphonServer server;
PFont f;


float r = 300;
String message = "Atelier presse. On choisit un arcticle sur un sujet \u00e0 d\u00e9battre ensemble. Et constater comme nous sommes in\u00e9gaux dans la permission qu'on se donne \u00e0 parler au public. ";
float globalRotate = 0;
public void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "rotateText");
  f = createFont("latin", 40, true);
  textFont(f);
  // The text must be centered!
  textAlign(CENTER);
  smooth();
}

public void draw() {
  canvas.beginDraw();
  canvas.background(0,0);

  float arclength = 0;

  for (int i = 0; i < message.length (); i++)
  {
    char currentChar = message.charAt(i);
    float w = textWidth(currentChar);
    arclength += w/2;
    float theta =PI + arclength / r *millis()/20000;    

    canvas.pushMatrix();
    canvas.translate(width/2+ r*cos(theta), height/2+ r*sin(theta));

    canvas.rotate(theta+PI/2 ); // rotation is offset by 90 degrees
    canvas.fill(map(millis(), 0, 10000, 0, 255));
    canvas.textSize(30);
    canvas.text(currentChar, 0, 0);
    canvas.popMatrix();
    arclength += w/2;
  }

 // canvas.filter(BLUR, 2);
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
  println(frameRate);
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RotateText" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
