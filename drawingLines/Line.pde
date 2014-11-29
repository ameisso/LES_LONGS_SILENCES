class Line {
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;
  String cuePoint;
  color lineColor;

  Line(float startX, float startY, float endX, float endY, float duration, color aLineColor)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = millis();
    drawingDuration= duration*1000;//duratin is in seconds
    cuePoint = "";
    lineColor = aLineColor;
    println(lineColor);
  }

  Line(float startX, float startY, float endX, float endY, float startTime, float endTime, color aLineColor)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = startTime*1000;
    drawingDuration= (endTime-startTime)*1000;//duratin is in seconds
    cuePoint = "";
    lineColor = aLineColor;
 
  }

  Line(float startX, float startY, float endX, float endY, String aCuePoint, float duration, color aLineColor)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = -1;
    drawingDuration= duration*1000;//duratin is in seconds
    cuePoint = aCuePoint;
    lineColor = aLineColor;
    println(lineColor);
  }

  void setStartDate()
  {
    startDate = millis();
  }

  void draw()
  {
    PVector v = getEndPoint();
    canvas.stroke ((millis()-startDate)/drawingDuration*red(lineColor),(millis()-startDate)/drawingDuration*green(lineColor),(millis()-startDate)/drawingDuration*blue(lineColor)); 

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

