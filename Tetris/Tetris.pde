Game game;

void setup() {
  size(600, 800);
  game = new Game(10, 20);
}

void draw() {
  background(255);
  
  game.update();
  game.display();
}

void keyPressed() {
  // Обработка нажатия клавиш 
}
// MC
