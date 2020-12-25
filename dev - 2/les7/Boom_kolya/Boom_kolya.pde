Explosion chars[];
ScreenMgr smanager = new ScreenMgr(true, true);
Explosion cl;
Zem ck;
void setup() {
  size(900, 600);
  cl = new Explosion(100, 330);
  ck = new Zem(0, 0);
}

void draw() {
  smanager.work();
  background(255);
  ck.draw();
  cl.update();
  cl.draw();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  smanager.mouseWheelFunc(e);
}

void keyPressed() {
  cl.action(keyCode);
}

void keyReleased() {
  cl.stop(keyCode);
}
