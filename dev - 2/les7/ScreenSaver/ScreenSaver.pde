Logo logo;

void setup() {
  fullScreen();
  frameRate(60);
  
  logo = new Logo(width/2, height/2);
  logo.vx = 5;
  logo.vy = 2;
}

void draw() {
  background(0);
  
  logo.update();
  logo.draw();
}
