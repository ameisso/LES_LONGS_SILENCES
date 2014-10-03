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

public class drawingLines extends PApplet {

final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;


ArrayList<Line> lines;
//Syphon

PGraphics canvas;
SyphonServer server;


public void setup() { 

  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "plans");
  lines = new ArrayList<Line>(); 
  lines.add  (new Line(100, 100, 500, 100, 0, 10));
  lines.add  (new Line(500, 100, 500, 500, 3, 4));
  lines.add  (new Line(500, 500, 100, 500, 4, 5));
  lines.add  (new Line(100, 500, 100, 100, 5, 6));
  lines.add  (new Line(500, 100, 800, 100, 4, 5));
  lines.add  (new Line(800, 100, 800, 200, 5, 6));
  lines.add  (new Line(800, 200, 600, 200, 4, 5));
  lines.add  (new Line(800, 100, 800, 200, 5, 6));
  lines.add  (new Line(800, 200, 600, 200, 4, 5));
  lines.add  (new Line(800, 200, 800, 600, 4, 5));
  lines.add  (new Line(800, 600, 100, 600, 4, 5));
  lines.add  (new Line(100, 600, 140, 530, 4, 5));
}

public void draw() {
  canvas.beginDraw();
  canvas.background(0);

  canvas.strokeWeight(3.0f);
  canvas.strokeCap(PROJECT);
  for (int i = lines.size ()-1; i >= 0; i--) {
    Line line = lines.get(i);
    line.draw();
  }

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 

class Line {
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;

  Line(float startX, float startY, float endX, float endY, float duration)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = millis();
    drawingDuration= duration*1000;//duratin is in seconds
  }
  
  Line(float startX, float startY, float endX, float endY, float startTime, float endTime)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = startTime*1000;
    drawingDuration= (endTime-startTime)*1000;//duratin is in seconds
  }

  public void setStartDate()
  {
    startDate = millis();
  }

  public void draw()
  {
    PVector v = getEndPoint();
      canvas.stroke((millis()-startDate)/drawingDuration*255);
    canvas.line(startPoint.x, startPoint.y, v.x, v.y);
  }
  public PVector getEndPoint()
  {
    if (millis() < startDate)
    {
    return startPoint;
    }
    if (millis() > startDate+drawingDuration)
    {
      return endPoint;
    } else
    {
      PVector v = new PVector(endPoint.x-startPoint.x, endPoint.y-startPoint.y);
      v.setMag((millis()-startDate)/drawingDuration*v.mag());
      v.add(startPoint);
      return v;
    }
  }
}

class Text {
  //texte en statique, on passe juste une ligne et on calcule le NB de lettres du message qui rentre dedans. Fade in Fade out 
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;
  String message = "Atelier presse. On choisit un arcticle sur un sujet \u00e0 d\u00e9battre ensemble. Et constater comme nous sommes in\u00e9gaux dans la permission qu'on se donne \u00e0 parler au public. ";

  Text(float startX, float startY, float endX, float endY, float duration)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = millis();
    drawingDuration= duration*1000;//duratin is in seconds
  }

  Text(float startX, float startY, float endX, float endY, float startTime, float endTime)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = startTime*1000;
    drawingDuration= (endTime-startTime)*1000;//duratin is in seconds
  }

  public void draw()
  {
    PVector tempEndPoint = getEndPoint();
    float messageWidth = 0;
    tempEndPoint.sub(startPoint);
    float spaceLength = tempEndPoint.mag();
   
 while (messageWidth<spaceLength)
 {
      char currentChar = message.charAt(0);
      float w = textWidth(currentChar);
      messageWidth += w;
    }
    canvas.stroke((millis()-startDate)/drawingDuration*255);
    canvas.text(message, startPoint.x, startPoint.y, tempEndPoint.x, tempEndPoint.y);
  }
  public PVector getEndPoint()
  {
    if (millis() < startDate)
    {
      return startPoint;
    }
    if (millis() > startDate+drawingDuration)
    {
      return endPoint;
    } else
    {
      PVector v = new PVector(endPoint.x-startPoint.x, endPoint.y-startPoint.y);
      v.setMag((millis()-startDate)/drawingDuration*v.mag());
      v.add(startPoint);
      return v;
    }
  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "drawingLines" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
