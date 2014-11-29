class Ball
{
  PVector position;
  PVector velocity;

  float r, m;

  Ball(float x, float y, float r_)
  {
    position = new PVector(x, y);
    velocity = new PVector(x, y);
    velocity.x=3;
    velocity.y=1;
    r = r_;
    m = r*.1;
  }

  void update()
  {
    position.add(velocity);
  }


  void checkCollision(Ball other)
  {
    PVector bVect = PVector.sub(other.position, position);
    float bVectMag = bVect.mag();

    if (bVectMag < r + other.r) {
      // get angle of bVect
      float theta  = bVect.heading();
      // precalculate trig values
      float sine = sin(theta);
      float cosine = cos(theta);
      PVector[] bTemp = {
        new PVector(), new PVector()
        };

        bTemp[1].x  = cosine * bVect.x + sine * bVect.y;
      bTemp[1].y  = cosine * bVect.y - sine * bVect.x;

      PVector[] vTemp = {
        new PVector(), new PVector()
        };

        vTemp[0].x  = cosine * velocity.x + sine * velocity.y;
      vTemp[0].y  = cosine * velocity.y - sine * velocity.x;
      vTemp[1].x  = cosine * other.velocity.x + sine * other.velocity.y;
      vTemp[1].y  = cosine * other.velocity.y - sine * other.velocity.x;
      PVector[] vFinal = {  
        new PVector(), new PVector()
        };

        vFinal[0].x = ((m - other.m) * vTemp[0].x + 2 * other.m * vTemp[1].x) / (m + other.m);
      vFinal[0].y = vTemp[0].y;

      vFinal[1].x = ((other.m - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + other.m);
      vFinal[1].y = vTemp[1].y;

      bTemp[0].x += vFinal[0].x;
      bTemp[1].x += vFinal[1].x;

      PVector[] bFinal = {
        new PVector(), new PVector()
        };

        bFinal[0].x = cosine * bTemp[0].x - sine * bTemp[0].y;
      bFinal[0].y = cosine * bTemp[0].y + sine * bTemp[0].x;
      bFinal[1].x = cosine * bTemp[1].x - sine * bTemp[1].y;
      bFinal[1].y = cosine * bTemp[1].y + sine * bTemp[1].x;

      other.position.x = position.x + bFinal[1].x;
      other.position.y = position.y + bFinal[1].y;

      position.add(bFinal[0]);
      velocity.x = cosine * vFinal[0].x - sine * vFinal[0].y;
      velocity.y = cosine * vFinal[0].y + sine * vFinal[0].x;
      other.velocity.x = cosine * vFinal[1].x - sine * vFinal[1].y;
      other.velocity.y = cosine * vFinal[1].y + sine * vFinal[1].x;
    }
  }


  void checkCollisionwithRect(float centerX, float centerY, float rectWidth, float rectHeight) 
  {
    if  (position.x > centerX+rectWidth/2.0-r || position.x < centerX - rectWidth/2.0 + r)
    {
      velocity.x *= -1;
      if ( position.x > centerX+rectWidth/2.0-r)//anti bump
      {
        position.x -= 1;
      } else
      {
        position.x += 1;
      }
      player2.rewind();
      player2.play();
    }
    if  (position.y > centerY+rectHeight/2.0-r || position.y < centerY - rectHeight/2.0 + r)
    {
      velocity.y *= -1;
      if ( position.y > centerX+rectHeight/2.0-r)//anti bump
      {
        position.y -= 1;
      } else
      {
        position.y += 1;
      }
      player.rewind();
      player.play();
    }
  }
  void display() {
    canvas.noStroke();
    canvas.fill(50);
    //canvas.ellipse(position.x, position.y, r*2, r*2);
    canvas.rect(position.x, position.y, r*2, r*2);
  }
}

