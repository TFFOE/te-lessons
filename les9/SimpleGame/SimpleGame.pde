PImage back;
Char character;
Monster monster;

Surface[] surfaces;
Obstacle[] obstacles;

void setup() {
  fullScreen();
  frameRate(60);
  back = loadImage("img/background.jpg", "jpg");
  back.resize(0, height);

  character = new Char(width - 50, 100);
  monster = new Monster(50, height - 300);

  surfaces = new Surface[] {
    new FloatingIsland(width/2, height/2, 600, 10, 0, 0),
    new Cloud(width/2 + 200, height/2 - 100, 350, 20, 5, 0),
    new IslandYou(width/2 + 200, height/2 - 100, 400, 10, 0, 6),
    new CheetahIsland(width/2 + 200, height/2 - 100, 400, 10, 5, 2),
    new Surface(width/2, height - height/10, width * 4, height/3),
  };

  obstacles = new Obstacle[] {
    new Wall(width/2, 400, 100, 250),
  };
}

void draw() {
  background(255);
  drawBackground(back);


  for (Surface surf : surfaces) {
    surf.update();
    surf.draw();
  }

  character.update();
  character.draw();

  //monster.update();
  monster.draw();
}

void keyPressed() {
  character.move(keyCode);
}

void keyReleased() {
  character.stop(keyCode);
}
