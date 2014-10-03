float speed = 0;

void setup()
{
  size(800, 800, P2D);
  background(0);
}

void draw()
{
  noStroke();
  fill(0, 50); 
  rect(0, 0, width, height);
  
  stroke(255);
  noFill();
  strokeWeight(3);
  ellipse(width/2, height/2, 600, 600);
  
  stroke(255);
  strokeWeight(8);
  translate (width/2, height/2);
  for (int i = 0 ; i < 4 ; i++)
  {
    rotate(speed);
    speed+=0.001;
    line(0, 0, 0, 298);
  }
}

