class Circle 
{
  PVector position; 
  float radius; 

  Circle(PVector center, float aRadius)
  {
    this.position = center; 
    this.radius = aRadius;
  }

  void display()
  {
    canvas.ellipse(position.x, position.y, radius, radius);
  }

  void displayLine(PVector mousePosition)
  {
    //canvas.line(mousePosition.x, mousePosition.y, position.x, position.y);
    PVector line = new PVector(mousePosition.x-position.x, mousePosition.y-position.y, 0.0);
    PVector Z = new PVector(0, 0, 1);
    Z.normalize();
    line.normalize();
    PVector endPoint = line.cross(Z);
    float add = 0;
    endPoint.normalize();
    endPoint.mult(radius/2);
    endPoint.add(position);

    canvas.line(mousePosition.x, mousePosition.y, endPoint.x, endPoint.y);
    println(endPoint.x, endPoint.y);
  }
}

