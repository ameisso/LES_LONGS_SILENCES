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

  void setStartDate()
  {
    startDate = millis();
  }

  void draw()
  {
    PVector v = getEndPoint();
      canvas.stroke((millis()-startDate)/drawingDuration*255);
    canvas.line(startPoint.x, startPoint.y, v.x, v.y);
  }
  PVector getEndPoint()
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

