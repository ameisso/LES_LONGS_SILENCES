final int SCREEN_WIDTH  = 800;
final int SCREEN_HEIGHT = 800;


ArrayList<Line> lines;
//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;


void setup() { 

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
  lines.add  (new Line(100, 600, 200, 530, 4, 5));
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);

  canvas.strokeWeight(3.0);
  canvas.strokeCap(PROJECT);
  for (int i = lines.size ()-1; i >= 0; i--) {
    Line line = lines.get(i);
    line.draw();
  }

  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
} 

