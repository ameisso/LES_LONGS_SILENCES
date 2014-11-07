final int SCREEN_WIDTH  = 1000;
final int SCREEN_HEIGHT = 1000;


ArrayList<Line> lines;
//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

import oscP5.*;
import netP5.*;
OscP5 oscP5;


void setup() { 

  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "plans");
 lines = new ArrayList<Line>(); 
  lines.add  (new Line(250, 500, 250, 350, 0, 2));
  lines.add  (new Line(250, 350, 250+300*1.618, 350, 2, 8));
  lines.add  (new Line(250+300*1.618, 350, 250+300*1.618, 650, 8,12));
  lines.add  (new Line(250+300*1.618, 650, 250, 650, 12, 18));
  lines.add  (new Line(250, 650, 250, 500, 18, 20));
  lines.add  (new Line(100, 100, 160, 100, 20, 20.2));
  lines.add  (new Line(160, 100, 160, 900, 20.2, 21.2));
  lines.add  (new Line(160, 900, 100, 900, 21.2, 21.4));
  lines.add  (new Line(100, 900, 100, 100, 21.4, 22.4));
  lines.add  (new Line(100, 825, 160, 825, 22.4, 22.42));
  lines.add  (new Line(100, 775, 160, 775, 22.42, 22.44));
  lines.add  (new Line(100, 740, 160, 740, 22.44, 22.46));
  lines.add  (new Line(100, 690, 160, 690, 22.46, 22.48));
  lines.add  (new Line(100, 635, 160, 635, 22.48, 22.50));
  lines.add  (new Line(100, 570, 160, 570, 22.50, 22.52));
  lines.add  (new Line(100, 520, 160, 520, 22.52, 22.54));
  lines.add  (new Line(100, 430, 160, 430, 22.54, 22.56));
  lines.add  (new Line(100, 400, 160, 400, 22.56, 22.58));
  lines.add  (new Line(100, 350, 160, 350, 22.58, 22.60));
  lines.add  (new Line(100, 280, 160, 280, 22.60, 22.62));
  lines.add  (new Line(100, 220, 160, 220, 22.62, 22.64));
  lines.add  (new Line(100, 180, 160, 180, 22.64, 22.66));
  lines.add  (new Line(100, 130, 160, 130, 22.66, 22.68));
  lines.add  (new Line(100, 100, 160, 100, 22.68, 22.70));
  lines.add  (new Line(735.4-185.4+50, 350, 735.4-185.4+50, 285.4, 22.7, 23));
  lines.add  (new Line(735.4-185.4 +50, 285.4, 735.4-185.4, 285.4, 23, 23.3));
  lines.add  (new Line(735.4-185.4, 285.4, 735.4-185.4, 100, 23.3, 23.7));
  lines.add  (new Line(735.4-185.4, 100, 735.4+100, 100, 23.7, 24.7));
  lines.add  (new Line(735.4+100, 100, 735.4+100, 285.4, 24.7, 24.9));
  lines.add  (new Line(735.4+100, 285.4, 735.4-185.4+90, 285.4, 24.9, 25.5));
  lines.add  (new Line(735.4-185.4+90, 285.4, 735.4-185.4+90, 350, 25.7, 25.8));
  lines.add  (new Line(735.4-80, 650, 735.4-80, 650+135.4, 25.8, 26));
  lines.add  (new Line(735.4-80, 650+135.4, 735.4, 650+135.4, 26, 26.2));
  lines.add  (new Line(735.4, 650+135.4, 735.4, 900, 26.2, 26.4));
  lines.add  (new Line(735.4, 900, 735.4-185.4, 900, 26.4, 26.6));
  lines.add  (new Line(735.4-185.4, 900, 735.4-185.4, 900-116.6, 26.6, 26.8));
  lines.add  (new Line(735.4-185.4, 900-114.6, 735.4-120, 900-114.6, 26.8, 27));
  lines.add  (new Line(735.4-120, 900-114.6, 735.4-120, 650, 27, 27.2));
  lines.add  (new Line(375, 350, 375, 300, 27.2, 27.4));
  lines.add  (new Line(375, 300, 375-37, 300, 27.4, 27.6));
  lines.add  (new Line(375-37, 300, 375-37, 300-114.6, 27.8, 30));
  lines.add  (new Line(375-37, 300-114.6, 375-37+114.6, 300-114.6, 30, 30.2));
  lines.add  (new Line(375-37+114.6, 300-114.6, 375-37+114.6, 300, 30.2, 30.4));
  lines.add  (new Line(375-37+114.6, 300, 375+40, 300, 30.4, 30.6));
  lines.add  (new Line(375+40, 300, 375+40, 350, 30.6, 30.8));
  lines.add  (new Line(160, 100, 200, 100, 30.8, 31));
  lines.add  (new Line(200, 100, 200, 475, 31, 31.2));
  lines.add  (new Line(200, 475, 250, 475, 31.2, 31.4));
  lines.add  (new Line(250, 525, 200, 525, 31.4, 31.6));
  lines.add  (new Line(200, 525, 200, 900, 31.6, 31.8));
  lines.add  (new Line(200, 900, 160, 900, 31.8, 32));

  oscP5 = new OscP5(this, 9999);
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);

  canvas.strokeWeight(20.0);
  canvas.strokeCap(PROJECT);
  for (int i = lines.size ()-1; i >= 0; i--) {
    Line line = lines.get(i);
    line.draw();
  }

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 

void oscEvent(OscMessage theOscMessage)
{
  //if (theOscMessage.addrPattern().equals("/millumin/composition/cue"))
  //{
    for (int i = lines.size ()-1; i >= 0; i--)
    {
      Line line = lines.get(i);
      if (line.cuePoint.equals(theOscMessage.addrPattern()))
      {
        line.setStartDate();
      }
    }
  //}
}

