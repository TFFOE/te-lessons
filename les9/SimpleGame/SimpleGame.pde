PImage back;
Char character;
String backg = "img/nebo.jpg";
Surface[] surfaces;
Monster monster;
void setup() {
  fullScreen();
  frameRate(60);
  character = new Char(width/2, 10);
   monster = new Monster(20, height/2 + 300);
    back = loadImage(backg, "jpg");
  back.resize(0, height);
  surfaces = new Surface[] { 
    new FloatingIsland(width/2, height/2 + 100, 600, 10, 2, 0),
    new Cloud(width/2 + 200, height/2 - 100, 400, 240, -2, 2),
    new FloatingIsland(width/2 + 200, height/2 - 100, 200, 120, -2, 4),
    new FloatingIsland(width/2 + 200, height/2 - 100, 100, 120, -5, 2),
     new Cloud(width/2 + 200, height/2 - 400, 350, 240, -5, 2),

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
   monster.update();
  monster.draw();
  
}

void keyPressed() {
  character.move(keyCode);
}

void keyReleased() {
  character.stop(keyCode);
}
