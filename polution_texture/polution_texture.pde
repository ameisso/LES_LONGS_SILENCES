

Circle[] circles;   //call class w/ capital letter, decl. objects

float sineValue; float cosineValue; float count;
float radiusMod; float bMod;

int number = 4024;
int pollute = 0;

void setup(){
  size(1024,768);
  colorMode(HSB, 360, 100, 100);
  smooth();
  
  frameRate(35);
  
  circles = new Circle[number]; //make x places for objects
  
  for(int i = 0; i < number; i++){
    circles[i] = new Circle(random(0,width), random(0,height), random(30,100));
  }
}

void draw(){
  sineValue = sin(radians(count));
  cosineValue = cos(radians(count));
  
  radiusMod = map(sineValue, -1, 1, .7, 1.5);
  bMod = map(sineValue, -1, 1, 70, 100);
  //background(190,90,bMod/3);
  background(190,90,70);
  interference();
  
  for(int i = 0; i < number; i++){
    circles[i].display(); circles[i].move();
    //circles[i].x+=sineValue; circles[i].y+=cosineValue;
  }
  
  filter(BLUR, random(0,2));
  count++;
}

void mousePressed(){
  for(int i = 0; i < circles.length; i++){
    circles[i].moveAway();
  }
  pollute=0;
}

void mouseReleased(){
  pollute=0;
}

void factories(){
  for(int i = 0; i < width; i+=5){
    fill(360,0,0,20);
    float rando = random(5,height/4);
    rect(i, height-rando, random(5,35), rando);
  }
}

void interference(){
  for(int i = 0; i < width; i+=5){
    fill(360,0,0,map(((mouseX+mouseY)/2), 0, ((width+height)/2), 1, 10));
    float rando = random(5,height/4);
    //rect(i, height-rando, random(5,35), rando);
    rect(i,0,random(35,100), height);
  }
}

void makeNoise(){
    for(int posx = 0; posx < width; posx++){
    for(int posy = 0; posy < height; posy++){
      fill(random(0,360),random(20,100),80, 20); noStroke();
      rect(posx,posy,random(2,10), random(2,10));
    }
  }
}

class Circle {
  // fields
  float x, y, diam;
  float vx, vy, gravity, friction;
  float direction = 1;
  float glow; float num = 1;
  float dx, dy;
  float increment;
  float easing = .075;
  
  // constructor (inits fields)
  Circle(float xpos, float ypos, float dia){
    x = xpos; y = ypos; diam = dia;
    vx= xpos; vy = xpos;
    friction = -.6;
    gravity = .04;
    
  }
  
  // methods
  void display(){
    //fill(190, 90, bMod, 5);
    //fill(190, 100, map(mouseY, 0, height, 30, 100), 5); 
    //fill(360,0,15,map(((mouseX+mouseY)/2), 0, ((width+height)/2), 2, 4));
    fill(360,0,15,3);
    noStroke(); //stroke(0, 100);
    ellipse(x,y,diam*radiusMod,diam*radiusMod);
  }
  
  void move(){
    if(x > width || y > height || x < 0 || y < 0){
      direction*=-1;
      physics();
    }
    
    if(dist(x, y, mouseX, mouseY) < 200 && dist(x, y, mouseX, mouseY) > 50 ){
      if(mousePressed) { moveAway(); }
      else{ moveTo(); }
    }
    
    if(random(1,2) > 1.7){
      moveAway();
    }
    
    x+=sineValue; y+=cosineValue;
    //x+=noise(random(0,100)*width); y+=noise(random(0,100)*height);
    x+=direction/2; y+=direction/3;
  }
  
  void moveTo(){
    dx = mouseX - x;
    dy = mouseY - y;
    
    x = x + dx*easing + noise(random(0,100)*width*100);
    y = y + dy*easing + noise(random(0,100)*height);
    //x+=noise(random(0,100)*width*100); y+=noise(random(0,100)*height);
  }
  
  void moveAway(){
    //direction = -1;
    dx = (mouseX - x)*-1;
    dy = (mouseY - y)*-1;
    
    if(x > width || y > height || x < 0 || y < 0){
        //for(int i = 0; i < number; i++){
    circles[int(random(1,circles.length))] = new Circle(random(0,width), random(0,height), random(10,100));
  //}
}
    else{
    x = x + dx*easing + noise(random(0,100)*width*100);
    y = y + dy*easing + noise(random(0,100)*height);
    }
  }
  void physics(){
    vy += gravity;
    x =+ vx;
    y += vy;
    
    if(y > height){
      y = height;
      vy*=friction;
    }
    
    if(x > width){
      x = width;
      vx*=friction;
  }
  vx++;
 }
}
