PImage back;
Char character;

Surface[] surfaces;

void setup() {
  fullScreen();
  frameRate(60);
  character = new Char(width/2, 10);
    back = loadImage("img/nebo.jpg", "jpg");
  back.resize(0, height);
  surfaces = new Surface[] { 
    new FloatingIsland(width/2, height/2 + 100, 600, 10, 2, 0),
    new Cloud(width/2 + 200, height/2 - 100, 400, 10, -2, 2),
    new FloatingIsland(width/2 + 200, height/2 - 100, 200, 10, -2, 4),
    new FloatingIsland(width/2 + 200, height/2 - 100, 100, 10, -5, 2),
     new Cloud(width/2 + 200, height/2 - 400, 350, 10, -5, 2),
    //new Surface(width/2, height - height/10, width, height/3),
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
}

void keyPressed() {
  character.move(keyCode);
}

void keyReleased() {
  character.stop(keyCode);
}
