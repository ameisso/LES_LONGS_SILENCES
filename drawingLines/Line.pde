class Line {
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;

  Line(float startX,float startY, float endX, float endY, float drawingDuration)
  {
    startPoint = new PVector(startX,startY);
    endPoint = new PVector(endX,endY);
    startDate = millis();
  }
  
  void setStartDate()
  {
    startDate = millis();
  }

  void draw()
  {
    PVector v = getEndPoint();
  canvas.line(  startPoint.x,startPoint.y,  v.x,v.y);
  }
  PVector getEndPoint()
  {
    if (millis() > startDate+drawingDuration)
    {
     return endPoint; 
    }
    else
    {
      PVector v = new PVector(endPoint.x-startPoint.x,endPoint.y-startPoint.y);
      println(v.mag());
      return endPoint;
    }
  }
}

