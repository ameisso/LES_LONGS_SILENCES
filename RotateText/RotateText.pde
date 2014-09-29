final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;
PFont f;


float r = 300;
String message = "Atelier presse. On choisit un arcticle sur un sujet à débattre ensemble. Et constater comme nous sommes inégaux dans la permission qu'on se donne à parler au public. ";
float globalRotate = 0;
void setup() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "rotateText");
  f = createFont("latin", 40, true);
  textFont(f);
  // The text must be centered!
  textAlign(CENTER);
  smooth();
}

void draw() {
  canvas.beginDraw();
  canvas.background(0);

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

