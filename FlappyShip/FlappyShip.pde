Game game;

void setup() {
  fullScreen();
  frameRate(60);
  game = new Game();
}

void draw() {
  game.update();
  game.draw();
}

void keyPressed() {
  game.keyPressedProcess(key, keyCode);
}

void keyReleased() {
  game.keyReleasedProcess(key, keyCode);
}
