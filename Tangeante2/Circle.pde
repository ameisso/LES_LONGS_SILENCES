class Circle 
{
  PVector position; 
  float radius; 
  boolean tangeantSide;
  boolean shouldDraw = false;
  PVector endPoint ;
  float startApparitionDate = 0;
  boolean isLineAppearing = false;
  float drawingDuration = 10000;
  float lineStroke = 0;

  Circle(PVector center, float aRadius)
  {
    this.position = center; 
    this.radius = aRadius;
    if  (random(1) > 0.5)
    {
      tangeantSide = true;
    } else 
    {
      tangeantSide = false;
    }
    this.endPoint = new PVector(0, 0);
  }

  void display()
  {
    canvas.stroke(255);
    canvas.ellipse(position.x, position.y, radius, radius);
  }
}
