Game game;

void setup() {
  fullScreen();
  game = new Game();
}

void draw() {
  game.update();
  game.draw();
}

void keyPressed() {
  game.keyPressedProcess(key, keyCode);
}
