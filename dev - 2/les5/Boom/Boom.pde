Grid grid = new Grid(1, 1);
Explosion chars[];
ScreenMgr smanager = new ScreenMgr(true, true);

void setup() {
  
  //size(800, 600);
  fullScreen();
  frameRate(50);
  
  chars = new Explosion[] {
    new Explosion(0, 0),
    new Explosion(0, 0),
    new Explosion(0, 0),
    new Explosion(0, 0)
  };
  for (Explosion c : chars) {
     c.current_frame = int(random(49)); 
  }
}

void draw() {
  smanager.work();
  background(0);
  grid.draw();
  
  for (Character c : chars) {
    c.update();
    c.draw();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  smanager.mouseWheelFunc(e);
}
