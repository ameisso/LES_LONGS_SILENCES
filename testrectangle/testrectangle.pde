//TODO : the balls shouldnt be affected by the movement of the rectangle 
final int SCREEN_WIDTH  = 1024;
final int SCREEN_HEIGHT = 768;

final float RECTANGLE_CONTRACTION_DURATION_MS = 120000;
final float ORIGINAL_RECTANGLE_WIDTH = 800;
final float ORIGINAL_RECTANGLE_HEIGHT = 300;

final float FINAL_RECTANGLE_HEIGHT = 300;
final float FINAL_RECTANGLE_WIDTH = 150;


//Syphon
import codeanticode.syphon.*;
PGraphics canvas;
SyphonServer server;

//OSC
import oscP5.*;
import netP5.*;
OscP5 oscP5;

//Sound 
import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioPlayer player2;

//SENSOR 
import processing.serial.*;
Serial serial;
int lf = 10;    // Linefeed in ASCII
String myString = null;

//General 
float angle = 0;
PVector position;
Ball ball;
Ball ball2;
float rectWidth = ORIGINAL_RECTANGLE_WIDTH; 
float rectHeight = ORIGINAL_RECTANGLE_HEIGHT;

float currentRectWidth = ORIGINAL_RECTANGLE_WIDTH;
float currentRectHeight = ORIGINAL_RECTANGLE_HEIGHT;

int rectExtension = 30;
float timeRectWasExtended = -1;
ArrayList<Ball> balls;
float ballSpeed = 1.0;


void setup() 
{  
  size(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  canvas = createGraphics(SCREEN_WIDTH, SCREEN_HEIGHT, P2D);
  server = new SyphonServer(this, "rectangle");
  oscP5 = new OscP5(this, 9999);

  position = new PVector(0, 0);

  balls = new ArrayList<Ball>(); 
  balls.add  (new Ball(position.x, position.y, 5));

  minim = new Minim(this);
  player = minim.loadFile("blep.wav");
  player2 = minim.loadFile("blip.wav");
  
  //Serial 
  println(Serial.list());
  serial = new Serial(this, Serial.list()[5], 9600);

  //remove the mute to have sounds 
  // player.mute();
  //player2.mute();
}
void draw() 
{
 while (serial.available() > 0) 
 {
    myString = serial.readStringUntil(lf);
    if (myString != null) 
    {
      angle = float(myString);
      println(myString);
    }
 }
  
  if (millis() - timeRectWasExtended > 50 && timeRectWasExtended>0)
  {
    currentRectWidth -= rectExtension;
    currentRectHeight -= rectExtension;
    timeRectWasExtended = -1;
  }


  if  (currentRectWidth > FINAL_RECTANGLE_WIDTH)
  {
    currentRectWidth = map(millis(), 0, RECTANGLE_CONTRACTION_DURATION_MS, ORIGINAL_RECTANGLE_WIDTH, 0);
  }

  if  (currentRectHeight > FINAL_RECTANGLE_HEIGHT)
  {
    currentRectHeight = map(millis(), 0, RECTANGLE_CONTRACTION_DURATION_MS, ORIGINAL_RECTANGLE_HEIGHT, 0);
  }

  canvas.beginDraw();
  canvas.background(0);
  canvas.pushMatrix();
  canvas.rectMode(CENTER);
  canvas.strokeWeight(10);
  canvas.noFill();
  canvas.translate(position.x, position.y);
  canvas.rotate(angle);

  for (int i = balls.size ()-1; i >= 0; i--)
  {
    Ball ball = balls.get(i);

    for (int j = balls.size ()-1; j >= 0; j--)
    {   
      if (i != j)
      {
        Ball ball2 = balls.get(j);
        ball.checkCollision(ball2);
      }
    }
    ball.update();
    ball.checkCollisionwithRect(0, 0, currentRectWidth, currentRectHeight); 
    ball.display();
  }

  for (int i = 0; i < 1; i++)
  {
    float rotateForce = 0.005;
    canvas.rotate(+random(-rotateForce, rotateForce));
    canvas.stroke(255);
    canvas.noFill();
    canvas.rect (0, 0, currentRectWidth, currentRectHeight);
  }

  canvas.popMatrix();
  canvas.endDraw();
  image(canvas, 0, 0);
  server.sendImage(canvas);
}


