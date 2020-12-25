Grid grid = new Grid(2, 2);
Packmen c1;

void setup() {
  fullScreen();
  c1 = new Packmen(0, 0);
}

void draw() {
  background(random(0, 255), random(0, 255), random(0, 255));
  grid.draw();
  c1.update();
  c1.draw();
}
