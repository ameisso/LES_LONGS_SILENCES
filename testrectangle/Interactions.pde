
void oscEvent(OscMessage theOscMessage)
{
  //println(theOscMessage.addrPattern());
  if (theOscMessage.addrPattern().equals("/rotation"))
  {
    angle += theOscMessage.get(0).floatValue()/20.0;
    // println(" "+angle);
  } 
  else if (theOscMessage.addrPattern().equals("/position"))
  {
    position. x = theOscMessage.get(1).floatValue()*width;
    position. y =height - theOscMessage.get(0).floatValue()*height;
  }
  else if (theOscMessage.addrPattern().equals("/addBall"))
  {
    balls.add  (new Ball(0, 0, 5));
  }
  else if (theOscMessage.addrPattern().equals("/ballSpeed"))
  {
    ballSpeed = theOscMessage.get(0).floatValue();
    for (int i = balls.size ()-1; i >= 0; i--)
    {
      Ball ball = balls.get(i);
      ball.acceleration.x = ballSpeed/100;
      ball.acceleration.y = ballSpeed/100;
    //  println("velocity "+ ball.velocity.x+" " + ball.velocity.y);
    }
  }

  if (theOscMessage.addrPattern().equals("/millumin/composition/cue"))
  {
    currentRectWidth += rectExtension;
    currentRectHeight += rectExtension;
    timeRectWasExtended = millis();
  }
} 

void mouseDragged()
{
  position.x = mouseX; 
  position.y = mouseY;
}

void keyPressed()
{
  if (key== 'h')
  {
    Ball ball = balls.get(0);
    if (ball.velocity.x != 0)
    {
      ball.freeze();
    }
    else
    {
      ball.restart();
    }
  }
}

