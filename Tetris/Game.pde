int TICK_DURATION_DEFAULT = 500;
int TICK_DURATION_BOOSTED = 50;

int tick_duration = TICK_DURATION_DEFAULT;

class Game {
  Figure figure;
  PVector size;
  float square_size;
  int timer;
  int[][] map;
  color[][] clrs;
  int score = 0;

  // 0 - игра запущена
  // 1 - игра ждет перезапуска
  int state = 0;

  Game(int size_x, int size_y) {
    square_size = height / size_y;
    size = new PVector(size_x, size_y);

    map = new int[size_x][size_y];
    for (int i = 0; i < size_x; i++)
      for (int j = 0; j < size_y; j++)
        map[i][j] = 0;

    clrs = new color[size_x][size_y];

    createFigureAt(int(size.x/2), -2);

    timer = millis();
  }

  void display() {
    switch (state) {
    case 0:
      draw_field();
      draw_dead_figures();
      figure.display();
      draw_score();
      break;

    case 1:
      drawGameoverScreen();
      break;
    }
  }

  void drawGameoverScreen() {
    background(0);
    fill(#2EFE64);
    textSize(80);
    textAlign(CENTER, BOTTOM);
    text("ГАМОВЕР", width/2, height/2);
    
    fill(#d63e6e);
    textSize(40);
    textAlign(CENTER, TOP);
    text("press SPACE to restart", width/2, height/2);
  }

  void draw_score() {
    fill(0);
    textSize(30);
    textAlign(RIGHT, TOP);
    text(score, width - 20, 10);
  }

  void draw_dead_figures() {
    for (int i = 0; i < size.x; ++i) {
      for (int j = 0; j < size.y; ++j) {
        if (map[i][j] == 1) {
          Square sq = new Square(width/2 - square_size * size.x/2 + i * square_size, j * square_size, square_size);
          sq.setColor(clrs[i][j]);
          sq.display();
        }
      }
    }
  }

  boolean figureToMap() {    
    for (Square sq : figure.squares) {
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);

      if (new_y < 0)
        return true;

      map[new_x][new_y] = 1;
      clrs[new_x][new_y] = sq.clr;
    }

    return false;
  }

  void createFigureAt(int x, int y) {
    float _x = width/2 - square_size * size.x/2 + x * square_size;
    float _y = 0 + y * square_size;

    int figure_type = (int)random(7);

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

    int red = (int)random(255);
    int green = (int)random(255);
    int blue = (int)random(255);
    figure.setColor(color(red, green, blue));
  }

  void respawnFigure() {
    int random_x = 3 + (int)random(size.x - 6);
    createFigureAt(random_x, -2);
  }

  // Проверяет столкновение фигуры с окружением
  boolean checkSides() {
    for (Square sq : figure.squares) {
      // Вычисляем координаты фигуры на поле
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      // int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);

      if (new_x >= size.x || new_x < 0)
        return true;
    }
    return false;
  }

  boolean checkBottom() {
    for (Square sq : figure.squares) {
      // Вычисляем координаты фигуры на поле
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);

      // Проверка на нижнюю границу
      if (new_y >= size.y)
        return true;
    }
    return false;
  }

  boolean checkMap() {
    for (Square sq : figure.squares) {
      // Вычисляем координаты фигуры на поле
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);

      // Проверка на нижнюю границу
      if (new_y >= 0 && new_y < size.y && 
        new_x >= 0 && new_x < size.x && 
        map[new_x][new_y] == 1)
        return true;
    }
    return false;
  }

  void keyPressed(char _key, int _keyCode) {
    if (_key == CODED) {
      switch (_keyCode) {
      case UP:
        rotateFigure();
        break;
      case DOWN:
        tick_duration = TICK_DURATION_BOOSTED;
        break;
      case RIGHT:
        moveFigure(1, 0);
        break;
      case LEFT:
        moveFigure(-1, 0);
        break;
      }
    }
    else {
      switch (_key) {
        case ' ':
          restartGame();
        break;
      }
    }
  }

  void restartGame() {
    for (int i = 0; i < size.x; i++)
      for (int j = 0; j < size.y; j++) {
        map[i][j] = 0;
        clrs[i][j] = 0;
        state = 0;
        respawnFigure();
      }
  }

  void keyReleased(char _key, int _keyCode) {
    if (_key == CODED) {
      switch (_keyCode) {
      case DOWN:
        tick_duration = TICK_DURATION_DEFAULT;
        break;
      }
    }
  }

  boolean moveFigure(int dx, int dy) {
    boolean respawn = false;
    float pdx = dx * square_size;
    float pdy = dy * square_size;

    PVector current_pos = figure.pos.copy();

    figure.move(pdx, pdy);

    if (checkBottom() || checkMap())
      respawn = true;

    if (checkSides() || checkMap() || checkBottom()) {
      figure.setPosition(current_pos.x, current_pos.y);
    }

    return respawn;
  }

  void rotateFigure() {
    figure.rotate();
    if (checkSides() || checkMap())
      figure.rotateBack();
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

  void removeLines() {
    int removed_lines_count = 0;
    for (int j = 0; j < size.y; ++j) {
      boolean remove_this_line = true;
      for (int i = 0; i < size.x; ++i) {
        if (map[i][j] == 0) {
          remove_this_line = false;
          break;
        }
      }

      if (remove_this_line == false)
        continue;

      removed_lines_count++;

      for (int k = j; k > 0; --k) {
        for (int i = 0; i < size.x; ++i) {
          map[i][k] = map[i][k-1];
          clrs[i][k] = clrs[i][k-1];
        }
      }
      for (int i = 0; i < size.x; ++i)
        map[i][0] = 0;
    }
    switch(removed_lines_count) {
    case 1: 
      score += 100; 
      break;
    case 2: 
      score += 300; 
      break;
    case 3: 
      score += 700; 
      break;
    case 4: 
      score += 1500; 
      break;
    }
  }

  void update() {
    if (state == 0 && millis() - timer >= tick_duration) {
      timer = millis();
      boolean respawn = moveFigure(0, 1);
      println(figure.pos.x, figure.pos.y);

      if (respawn == true) {
        boolean gameover = figureToMap();
        if (gameover) {
          state = 1;
          return;
        }
        removeLines();

        respawnFigure();
      }
    }
  }
}
