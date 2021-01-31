class Game {
  Figure figure;
  ArrayList<Figure> dead_figures;
  PVector size;
  float square_size;
  int timer;
  int[][] map;
    
  Game(int size_x, int size_y) {
    square_size = height / size_y;
    //figure = new Figure('O', 200, 100, square_size);
    size = new PVector(size_x, size_y);
    
    map = new int[size_x][size_y];
    for (int i = 0; i < size_x; i++)
      for (int j = 0; j < size_y; j++)
        map[i][j] = 0;
    
    createFigureAt(0, 0);
    
    timer = millis();
  }
  
  void display() {
    draw_field();
    figure.display();
  }
  
  void createFigureAt(int x, int y) {
    float _x = width/2 - square_size * size.x/2 + x * square_size;
    // x = (_x - width/2 + square_size * size.x/2) / square_size;
    float _y = 0 + y * square_size;
    // y = _y / square_size;
    stroke(0, 255, 0);
    strokeWeight(10);
    point(_x, _y);
    
    int figure_type = (int)random(7);
    figure_type = 6;
    switch (figure_type) {
      // I
      case 0:
        figure = new Figure('I', _x + 2 * square_size, _y + square_size, square_size);
      break;
      // J
      case 1:
        figure = new Figure('J', _x + 1.5 * square_size, _y + 1.5 * square_size, square_size);
      break;
      // L
      case 2:
        figure = new Figure('L', _x + 1.5 * square_size, _y + 1.5 * square_size, square_size);
      break;
      // O
      case 3:
        figure = new Figure('O', _x + square_size, _y + square_size, square_size);
      break;
      // S
      case 4:
        figure = new Figure('S', _x + 1.5 * square_size, _y + 1.5 * square_size, square_size);
      break;
      // T
      case 5:
        figure = new Figure('T', _x + 1.5 * square_size, _y + 1.5 * square_size, square_size);
      break;
      // Z
      case 6:
        figure = new Figure('Z', _x + 1.5 * square_size, _y + 1.5 * square_size, square_size);
      break;
    }
    
    for (Square sq : figure.squares) {
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = y = (int)((sq.pos.y + figure.pos.y)/ square_size);
      println(new_x, new_y);
    }
  }
  
  void draw_field() {
    // Рисуем рамку игрового поля
    float field_width = square_size * size.x;
    float right_border = width/2 + field_width/2;
    float left_border = width/2 - field_width/2;
    
    noFill();
    stroke(0);
    strokeWeight(5);
    rectMode(CENTER);
    rect(width/2, height/2, field_width, height);
    
    strokeWeight(1);
 
    // Рисуем вертикальные линии
    for (float i = left_border; i <= right_border; i += square_size) {
      line(i, 0, i, height);
    }
    
    // Рисуем горизонтальные линии
    for (float i = 0; i <= height; i += square_size) {
      line(left_border, i, right_border, i);
    }
  }
  
  void update() {
    int interval = 1500;
    
    if (millis() - timer >= interval) {
      timer = millis();
      figure.move(0, square_size);
    }
  }
}
