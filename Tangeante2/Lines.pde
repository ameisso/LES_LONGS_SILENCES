class Line 
{
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;
  color lineColor;


  Line(float startX, float startY, float endX, float endY, float duration, color aLineColor)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = -1;
    drawingDuration= duration*1000;//duratin is in seconds
    lineColor = aLineColor;
  }

  void display()
  {
    if (this.startDate > 0)
    {
      canvas.stroke ((millis()-startDate)/drawingDuration*red(lineColor), (millis()-startDate)/drawingDuration*green(lineColor), (millis()-startDate)/drawingDuration*blue(lineColor)); 
      //canvas.stroke(255, 0, 0);
      canvas.line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
    }
  }
  void forceDisplay()
  {
    canvas.stroke(255, 0, 0);
    canvas.line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);
  }

  boolean crossCursor(PVector position)
  {
    int excurtion = 50; 
    PVector projectedPoint = getDistance(startPoint, endPoint, position);
    PVector distance = PVector.sub(position, projectedPoint);
    float dist =distance.mag();

    if (dist < excurtion)
    {
      return true;
    }
    //startDate = -1;
    return false;
  }

  boolean containsPoint(PVector[] verts, PVector position) 
  {
    float px = position.x;
    float py = position.y;
    int num = verts.length;
    int i, j = num - 1;
    boolean oddNodes = false;
    for (i = 0; i < num; i++)
    {
      PVector vi = verts[i];
      PVector vj = verts[j];
      if (vi.y < py && vj.y >= py || vj.y < py && vi.y >= py) 
      {
        if (vi.x + (py - vi.y) / (vj.y - vi.y) * (vj.x - vi.x) < px) 
        {
          oddNodes = !oddNodes;
        }
      }
      j = i;
    }
    return oddNodes;
  }

  PVector getDistance( PVector startPoint, PVector endPoint, PVector mousePoint ) {
    PVector result = new PVector(); 

    float x1 = startPoint.x;
    float y1 = startPoint.y;

    float x2 = endPoint.x;
    float y2 = endPoint.y;

    float x = mousePoint.x; 
    float y = mousePoint.y;

    float dx = x2 - x1; 
    float dy = y2 - y1; 
    float d = sqrt( dx*dx + dy*dy ); 
    float ca = dx/d; // cosine
    float sa = dy/d; // sine 

    float mX = (-x1+x)*ca + (-y1+y)*sa; 

    if ( mX <= 0 ) {
      result.x = x1; 
      result.y = y1;
    } else if ( mX >= d ) {
      result.x = x2; 
      result.y = y2;
    } else {
      result.x = x1 + mX*ca; 
      result.y = y1 + mX*sa;
    }

    dx = x - result.x; 
    dy = y - result.y; 
    result.z = sqrt( dx*dx + dy*dy ); 

    return result;
  }
}

