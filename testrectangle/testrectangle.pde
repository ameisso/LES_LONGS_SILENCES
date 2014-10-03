void setup() 
{  
  size(800, 600, P2D);
}
void draw() 
{
  background(0);
  float angle = 2*PI/6;
  pushMatrix();
  rectMode(CENTER);
  strokeWeight(10);
  noFill();
  stroke(100);
      translate(mouseX, mouseY);
  rotate(angle);
  //rect (mouseX, mouseY, 200, 300);
  for (int i = 0 ; i < 10 ; i++)
  {
    float roatateForce = 0.005;

    rotate(+random(-roatateForce, roatateForce));
    rect (random(3), random(3), 200, 300);
  }
  popMatrix();
  line(100, 0, 100, 100);
  // rotate(-PI/2);
}

