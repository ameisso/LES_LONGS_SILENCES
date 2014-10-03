class Text {
  //texte en statique, on passe juste une ligne et on calcule le NB de lettres du message qui rentre dedans. Fade in Fade out 
  PVector startPoint, endPoint;
  float drawingDuration;
  float startDate;
  String message = "Atelier presse. On choisit un arcticle sur un sujet à débattre ensemble. Et constater comme nous sommes inégaux dans la permission qu'on se donne à parler au public. ";

  Text(float startX, float startY, float endX, float endY, float duration)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = millis();
    drawingDuration= duration*1000;//duratin is in seconds
  }

  Text(float startX, float startY, float endX, float endY, float startTime, float endTime)
  {
    startPoint = new PVector(startX, startY);
    endPoint = new PVector(endX, endY);
    startDate = startTime*1000;
    drawingDuration= (endTime-startTime)*1000;//duratin is in seconds
  }

  void draw()
  {
    PVector tempEndPoint = getEndPoint();
    float messageWidth = 0;
    tempEndPoint.sub(startPoint);
    float spaceLength = tempEndPoint.mag();
   
 while (messageWidth<spaceLength)
 {
      char currentChar = message.charAt(0);
      float w = textWidth(currentChar);
      messageWidth += w;
    }
    canvas.stroke((millis()-startDate)/drawingDuration*255);
    canvas.text(message, startPoint.x, startPoint.y, tempEndPoint.x, tempEndPoint.y);
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

