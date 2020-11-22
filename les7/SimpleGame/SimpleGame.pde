PImage back;
Char character;

Obstacle[] obstacles;

void setup() {
  fullScreen();
  frameRate(60);
  back = loadImage("img/background.jpg", "jpg");
  back.resize(0, height);
  character = new Char(width/2, height/2);
  
  obstacles = new Obstacle[] { 
    new FloatingIsland(width/2, height/2 + 100, 600, 10, 2, 0),
    new FloatingIsland(width/2 + 200, height/2 - 100, 400, 10, -2, 2),
    new Obstacle(width/2, height/2 - 100, 300, 10),
  };
}

void draw() {
  background(255);
  drawBackground(back);
  
  
  for (Obstacle obs : obstacles) {
    if (obs instanceof FloatingIsland) {
      obs.update();
      obs.draw();
    }
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
