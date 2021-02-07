// Объявляем объект игры
Game game;

void setup() {
  // Задаём размер окна
  size(600, 800);
  // Инициализируем объект игры
  game = new Game(10, 20);
}

void draw() {
  // Заливаем фон белым цветом
  background(255);
  
  game.update();
  game.display();
}

void keyPressed() {
  // Обработка нажатия клавиш 
}
