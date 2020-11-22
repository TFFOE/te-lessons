Grid grid = new Grid(3, 3);


Character chars[];

ScreenMgr smanager = new ScreenMgr(true, true);

void setup() {
  
  //size(800, 600);
  fullScreen();
  frameRate(50);
  
  chars = new Character[] {
    new Circle(0, 0),
    new Packman(0, 1),
    new Crocodile(1, 0),
    new Elephant(1, 1),
    new Rabbit(2, 2),
    new Bat(2, 0, "img/boom.png"),
  };
}

void draw() {
  
  smanager.work();
  
  background(0);
  grid.draw();
  
  //c1.update();
  //c2.update();
  //c3.update();
  //c4.update();

  //c1.draw();
  //c2.draw();
  //c3.draw();
  //c4.draw();
  for (Character c : chars) {
    c.update();
    c.draw();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  smanager.mouseWheelFunc(e);
}
