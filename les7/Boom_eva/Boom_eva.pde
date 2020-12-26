Grid grid = new Grid(2, 2);
W a, b, c, d, f;

Explosion chars[];
ScreenMgr smanager = new ScreenMgr(true, true);

void setup() {
  frameRate(5);

  fullScreen();
  b = new W(1, 0);

  d = new W(1, 0);
  a = new W(1, 0);
  f = new W(1, 0);
  c = new W(1, 0);
  chars = new Explosion[] {
    new Explosion(0, 0), 

  };
}

void draw() {
  background(255);
  smanager.work();
  background(255);
  grid.draw();
  b.update();
  b.draw();
  d.update();
  d.draw();
  a.update();
  a.draw();
  f.update();
  f.draw();
  c.update();
  c.draw();

  for (Explosion c : chars) {
    c.update();
    c.draw();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  smanager.mouseWheelFunc(e);
}
