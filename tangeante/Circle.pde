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

  void displayLine(PVector mousePosition)
  {
    //canvas.line(mousePosition.x, mousePosition.y, position.x, position.y);
    PVector line = new PVector(mousePosition.x-position.x, mousePosition.y-position.y, 0.0);
    PVector Z = new PVector(0, 0, 1);
    if (tangeantSide)
    {
      Z.z = -1;
    }
    Z.normalize();
    line.normalize();
    endPoint = line.cross(Z);
    float add = 0;
    endPoint.normalize();
    endPoint.mult(radius/2);
    endPoint.add(position);
    if (shouldDraw)
    {
      lineStroke = (millis()-startApparitionDate)/drawingDuration*255;
      canvas.stroke(lineStroke);
      canvas.line(mousePosition.x, mousePosition.y, endPoint.x, endPoint.y);

      if  ((millis()-startApparitionDate)>drawingDuration)
      {
        isLineAppearing = false;
      }
    }
  }

  void testAlignment(Circle testedCircle, PVector mousePosition)
  {
    PVector selfVector = new PVector (endPoint.x-mousePosition.x, endPoint.y-mousePosition.y);
    PVector otherVector = new PVector (testedCircle.endPoint.x-mousePosition.x, testedCircle.endPoint.y-mousePosition.y);
    if (PVector.angleBetween(selfVector, otherVector)< 1*PI/180.0)
    {
      shouldDraw = true;
      startApparitionDate = millis();
      isLineAppearing = true;
    }
  }
}

