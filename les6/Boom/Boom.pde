Grid grid = new Grid(2, 2);
Explosion chars[];
ScreenMgr smanager = new ScreenMgr(true, true);

void setup() {
  
  size(800, 600);
  frameRate(20);
  // fullScreen();
  
  chars = new Explosion[] {
    new Explosion(0, 0),
  };
}

void draw() {
  smanager.work();
  background(0);
  grid.draw();
  
  for (Explosion c : chars) {
    c.update();
    c.draw();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  smanager.mouseWheelFunc(e);
}
