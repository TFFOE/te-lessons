import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Tetris extends PApplet {

// Объявляем объект игры
Game game;

public void setup() {
  // Задаём размер окна
  
  // Инициализируем объект игры
  game = new Game(10, 20);
}

public void draw() {
  // Заливаем фон белым цветом
  background(255);

  game.update();
  game.display();
}

public void keyPressed() {
  game.keyPressed(key, keyCode);
}

public void keyReleased() {
  game.keyReleased(key, keyCode);
}
class Figure {
  char type; // Тип фигуры
  PVector pos; // Положение фигуры на экране (в пикселях)
  Square squares[] = new Square[4]; // Квадраты, из которых состоит фигура
  int clr = color(255, 255, 0); // Цвет фигуры
  byte rotation; // Поворот фигуры
  float size;

  // Конструктор класса "Фигура"
  Figure(char type, float x, float y, float size) {
    this.type = type;
    this.size = size;
    pos = new PVector(x, y);
    rotation = 0; // Задаем начальный поворот фигуры

    this.setFigure(type, rotation);

    this.setColor(clr);
  }

  public void setFigure(int type, byte rotation) {
    switch (type) {
      case 'I':
        switch (rotation) {
          case 0:
            squares[0] = new Square(-2 * size, -1 * size, size);
            squares[1] = new Square(-1 * size, -1 * size, size);
            squares[2] = new Square(0, -1 * size, size);
            squares[3] = new Square(1 * size, -1 * size, size);
          break;
          case 1:
            squares[0] = new Square(0, -2 * size, size);
            squares[1] = new Square(0, -1 * size, size);
            squares[2] = new Square(0,  0 * size, size);
            squares[3] = new Square(0,  1 * size, size);
          break;
          case 2:
            squares[0] = new Square(-2 * size, 0, size);
            squares[1] = new Square(-1 * size, 0, size);
            squares[2] = new Square(0, 0, size);
            squares[3] = new Square(1 * size, 0, size);
          break;
          case 3:
            squares[0] = new Square(-1 * size, -2 * size, size);
            squares[1] = new Square(-1 * size, -1 * size, size);
            squares[2] = new Square(-1 * size,  0 * size, size);
            squares[3] = new Square(-1 * size,  1 * size, size);
          break;
        }
      break;

      // TODO: Ярослав
      //   []
      //   []
      // [][]
      case 'J':
        squares[0] = new Square(-1.5f * size, -1.5f * size, size);
        squares[1] = new Square(-1.5f * size, -0.5f * size, size);
        squares[2] = new Square(-0.5f * size, -0.5f * size, size);
        squares[3] = new Square(0.5f * size, -0.5f * size, size);
      break;

      // TODO: Коля
      // []
      // []
      // [][]
      case 'L':
        squares[0] = new Square(0.5f * size, -1.5f * size, size);
        squares[1] = new Square(-1.5f * size, -0.5f * size, size);
        squares[2] = new Square(-0.5f * size, -0.5f * size, size);
        squares[3] = new Square(0.5f * size, -0.5f * size, size);
      break;

      // [][]
      // [][]
      case 'O':
        squares[0] = new Square(-1 * size, -1 * size, size);
        squares[1] = new Square(-1 * size, 0, size);
        squares[2] = new Square(0, 0, size);
        squares[3] = new Square(0, -1 * size, size);
      break;

      // TODO: Ева
      //   [][]
      // [][]
      case 'S':
        squares[0] = new Square(0.5f * size, -1.5f * size, size);
        squares[1] = new Square(-1.5f * size, -0.5f * size, size);
        squares[2] = new Square(-0.5f * size, -0.5f * size, size);
        squares[3] = new Square(-0.5f * size, -1.5f * size, size);
      break;

      //   []
      // [][][]
      case 'T':
        switch (rotation) {
          case 0:
            squares[0] = new Square(-0.5f * size, -1.5f * size, size);
            squares[1] = new Square(-1.5f * size, -0.5f * size, size);
            squares[2] = new Square(-0.5f * size, -0.5f * size, size);
            squares[3] = new Square(0.5f * size, -0.5f * size, size);
          break;
          case 1:
            squares[0] = new Square(-0.5f * size, -1.5f * size, size);
            squares[1] = new Square(-0.5f * size, 0.5f * size, size);
            squares[2] = new Square(-0.5f * size, -0.5f * size, size);
            squares[3] = new Square(0.5f * size, -0.5f * size, size);
          break;
          case 2:
            squares[0] = new Square(-0.5f * size, 0.5f * size, size);
            squares[1] = new Square(-1.5f * size, -0.5f * size, size);
            squares[2] = new Square(-0.5f * size, -0.5f * size, size);
            squares[3] = new Square(0.5f * size, -0.5f * size, size);
          break;
          case 3:
            squares[0] = new Square(-0.5f * size, -1.5f * size, size);
            squares[1] = new Square(-0.5f * size, 0.5f * size, size);
            squares[2] = new Square(-0.5f * size, -0.5f * size, size);
            squares[3] = new Square(-1.5f * size, -0.5f * size, size);
          break;
        }
      break;

      // TODO: Макс
      // [][]
      //   [][]
      case 'Z':
        squares[0] = new Square(-1.5f * size, -1.5f * size, size);
        squares[1] = new Square(-0.5f * size, -1.5f * size, size);
        squares[2] = new Square(-0.5f * size, -0.5f * size, size);
        squares[3] = new Square(0.5f * size, -0.5f * size, size);
      break;
    }

    this.setColor(clr);
  }

  public void rotate() {
    rotation += 1;
    if (rotation == 4)
      rotation = 0;

    this.setFigure(type, rotation);
  }

  public void rotateBack() {
    rotation -= 1;
    if (rotation == -1)
      rotation = 3;

    this.setFigure(type, rotation);
  }

  public void setColor(int clr) {
    this.clr = clr;
    for (Square s : squares)
      s.setColor(clr);
  }

  public void setPosition(float x, float y) {
    pos.set(x, y);
  }

  public void setType(char new_type) {
    type = new_type;
  }

  public void move(float dx, float dy) {
    pos.add(dx, dy);
  }

  public void display() {
    for (Square s : squares)
      s.moveAndDraw(pos.x, pos.y);
    // stroke(0, 0, 255);
    // strokeWeight(10);
    // point(pos.x, pos.y);
  }
}
int TICK_DURATION_DEFAULT = 500;
int TICK_DURATION_BOOSTED = 50;

int tick_duration = TICK_DURATION_DEFAULT;

class Game {
  Figure figure;
  ArrayList<Figure> dead_figures;
  PVector size;
  float square_size;
  int timer;
  int[][] map;

  Game(int size_x, int size_y) {
    dead_figures = new ArrayList<Figure>();
    square_size = height / size_y;
    size = new PVector(size_x, size_y);

    map = new int[size_x][size_y];
    for (int i = 0; i < size_x; i++)
      for (int j = 0; j < size_y; j++)
        map[i][j] = 0;

    createFigureAt(PApplet.parseInt(size.x/2), -2);

    timer = millis();
  }

  public void display() {
    draw_field();
    for (Figure f : dead_figures)
      f.display();
    figure.display();
    draw_map();
  }

  public void figureToMap() {
    for (Square sq : figure.squares) {
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);

      map[new_x][new_y] = 1;
    }
  }

  public void createFigureAt(int x, int y) {
    float _x = width/2 - square_size * size.x/2 + x * square_size;
    float _y = 0 + y * square_size;

    stroke(0, 255, 0);
    strokeWeight(10);
    point(_x, _y);

    int figure_type = (int)random(7);

    //==================
    // ДЛЯ ТЕСТА
    //==================
    // figure_type = 5;
    //==================
    switch (figure_type) {
      // I
      case 0:
        figure = new Figure('I', _x + 2 * square_size, _y + square_size, square_size);
      break;
      // J
      case 1:
        figure = new Figure('J', _x + 1.5f * square_size, _y + 1.5f * square_size, square_size);
      break;
      // L
      case 2:
        figure = new Figure('L', _x + 1.5f * square_size, _y + 1.5f * square_size, square_size);
      break;
      // O
      case 3:
        figure = new Figure('O', _x + square_size, _y + square_size, square_size);
      break;
      // S
      case 4:
        figure = new Figure('S', _x + 1.5f * square_size, _y + 1.5f * square_size, square_size);
      break;
      // T
      case 5:
        figure = new Figure('T', _x + 1.5f * square_size, _y + 1.5f * square_size, square_size);
      break;
      // Z
      case 6:
        figure = new Figure('Z', _x + 1.5f * square_size, _y + 1.5f * square_size, square_size);
      break;
    }
  }

  public void respawnFigure() {
    dead_figures.add(figure);
    int random_x = 2 + (int)random(size.x - 4);
    createFigureAt(random_x, -2);
  }

  // Проверяет столкновение фигуры с окружением
  public boolean checkFigureCollision() {
    for (Square sq : figure.squares) {
      // Вычисляем координаты фигуры на поле
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);
      println(new_x, new_y);
      if (new_x >= size.x || new_x < 0)
          return true;
    }
    return false;
  }

  // Возвращает TRUE, если текущая фигура сталкивается с предыдущими фигурами
  // или нижней границей поля
  public boolean checkBottom() {
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

  public boolean checkMap() {
    for (Square sq : figure.squares) {
      // Вычисляем координаты фигуры на поле
      int new_x = (int)((sq.pos.x + figure.pos.x - width/2 + square_size * size.x/2) / square_size);
      int new_y = (int)((sq.pos.y + figure.pos.y)/ square_size);

      // Проверка на столкновение с "мёртвыми" фигурами
      if (new_x >= 0 && new_x < size.x &&
          new_y >= 0 && new_y < size.y &&
          map[new_x][new_y] == 1)
        return true;
    }
    return false;
  }

  public void keyPressed(char _key, int _keyCode) {
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
  }

  public void keyReleased(char _key, int _keyCode) {
    if (_key == CODED) {
      switch (_keyCode) {
        case DOWN:
          tick_duration = TICK_DURATION_DEFAULT;
        break;
      }
    }
  }

  public int moveFigure(int dx, int dy) {
    float pdx = dx * square_size;
    float pdy = dy * square_size;

    PVector current_pos = figure.pos.copy();

    figure.move(pdx, pdy);

    int respawn = 0;
    if (checkBottom() || checkMap())
      respawn = 1;
    if (checkFigureCollision() || !checkBottom() && checkMap()) {
      figure.setPosition(current_pos.x, current_pos.y);
    }

    return respawn;
  }

  public void rotateFigure() {
    figure.rotate();
    if (checkFigureCollision())
        figure.rotateBack();
  }

  public void draw_field() {
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

  public void update() {
    if (millis() - timer >= tick_duration) {
      timer = millis();
      int respawn = moveFigure(0, 1);
      println(figure.pos.x, figure.pos.y, respawn);

      if (respawn == 1) {
        figureToMap();
        respawnFigure();
      }

    }
  }

  public void draw_map() {
    for (int i = 0; i < size.x; ++i) {
      for (int j = 0; j < size.y; ++j) {
        if (map[i][j] == 0) {
          noFill();
        }
        else if (map[i][j] == 1) {
          fill(0);
        }
        rectMode(CORNER);
        rect(width - 11 * square_size + i * square_size, j * square_size, square_size, square_size);
      }
    }

  }
}
class Square {
  PVector pos; // Положение квадрата на экране (в пикселях)
  float size; // Размер квадрата
  int clr = color(255, 0, 0);
  
  // Конструктор класса "Квадрат"
  Square(float x, float y, float s) {
    this.pos = new PVector(x, y);
    this.size = s;
  }

  public void display() {
    rectMode(CORNER); // Задаем режим отрисовки квадрата по левой верхней точке и размерам
    fill(clr); // Заполняем квадрат заданным цветом
    stroke(0); // Черный контур
    strokeWeight(2); // Толщина контура - 2 пикселя
    
    // Здесь рисуем красивый квадрат
    float radius = size * 0.15f; // Расстояние до внутреннего квадрата
    
    // Координаты левой верхней точки внутреннего квадрата
    float left = pos.x + radius;
    float top = pos.y + radius;
    
    // Координаты правой нижней точки внутреннего квадрата
    float right = pos.x + size - radius;
    float bottom = pos.y + size - radius;
    
    // Раскладываем основной цвет на отдельные компоненты
    float red = red(clr);
    float green = green(clr);
    float blue = blue(clr);
    
    // Вычисляем оттенки для отрисовки граней квадрата
    int light_color = color(red + 150, green + 150, blue + 150);
    int medium_color = color(red - 20, green - 20, blue - 20);
    int dark_color = color(red - 60, green - 60, blue - 60);
    
    // Задаем режим отрисовки квадрата по левой верхней и правой нижней точкам
    rectMode(CORNERS);
    noStroke();
    
    // Рисуем внутренний квадрат основным цветом
    rect(left, top, right, bottom);
    
    // Верхняя часть
    fill(light_color);
    quad(pos.x, pos.y,
         pos.x + size, pos.y,
         right, top, 
         left, top);
         
    // Левая часть
    fill(medium_color);
    quad(pos.x, pos.y,
         pos.x, pos.y + size,
         left, bottom,
         left, top);
         
    // Правая часть
    quad(pos.x + size, pos.y,
         pos.x + size, pos.y + size,
         right, bottom,
         right, top);
         
    // Нижняя часть
    fill(dark_color);
    quad(pos.x, pos.y + size,
         pos.x + size, pos.y + size,
         right, bottom,
         left, bottom);
  }
  
  // Перемещение квадрата в заданную позицию
  public void setPosition(float x, float y) {
    pos.set(x, y);
  }
  
  // Перемещение квадрата на заданное количество пикселей
  public void move(float dx, float dy) {
    pos.add(dx, dy);
  }
  
  // Квадрат отрисовывается с заданным смещением, но его координаты не меняются
  public void moveAndDraw(float dx, float dy) {
    PVector old_pos = pos.copy();
    this.move(dx, dy);
    this.display();
    pos = old_pos.copy();
  }
  
  // Задаем цвет квадрата
  public void setColor(int clr) {
    this.clr = clr; 
  }
}
  public void settings() {  size(1200, 800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Tetris" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
