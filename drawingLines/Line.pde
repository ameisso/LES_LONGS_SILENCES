class Line {
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;
  String cuePoint;

  Line(float startX, float startY, float endX, float endY, float duration)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = millis();
    drawingDuration= duration*1000;//duratin is in seconds
    cuePoint = "";
  }

  Line(float startX, float startY, float endX, float endY, float startTime, float endTime)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = startTime*1000;
    drawingDuration= (endTime-startTime)*1000;//duratin is in seconds
    cuePoint = "";
  }

  Line(float startX, float startY, float endX, float endY, String aCuePoint, float duration)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = -1;
    drawingDuration= duration*1000;//duratin is in seconds
    cuePoint = aCuePoint;
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
    if (startDate >0)
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
    return startPoint;
  }
}

