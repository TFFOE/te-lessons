class Square {
  PVector pos; // Положение квадрата на экране (в пикселях)
  float size; // Размер квадрата
  color clr = color(255, 0, 0);
  
  // Конструктор класса "Квадрат"
  Square(float x, float y, float s) {
    this.pos = new PVector(x, y);
    this.size = s;
  }

  void display() {
    rectMode(CORNER); // Задаем режим отрисовки квадрата по левой верхней точке и размерам
    fill(clr); // Заполняем квадрат заданным цветом
    stroke(0); // Черный контур
    strokeWeight(2); // Толщина контура - 2 пикселя
    
    // Здесь рисуем красивый квадрат
    float radius = size * 0.15; // Расстояние до внутреннего квадрата
    
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
    color light_color = color(red + 50, green + 50, blue + 50);
    color medium_color = color(red - 20, green - 20, blue - 20);
    color dark_color = color(red - 60, green - 60, blue - 60);
    
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
  void setPosition(float x, float y) {
    pos.set(x, y);
  }
  
  // Перемещение квадрата на заданное количество пикселей
  void move(float dx, float dy) {
    pos.add(dx, dy);
  }
  
  // Квадрат отрисовывается с заданным смещением, но его координаты не меняются
  void moveAndDraw(float dx, float dy) {
    PVector old_pos = pos.copy();
    this.move(dx, dy);
    this.display();
    pos = old_pos.copy();
  }
  
  // Задаем цвет квадрата
  void setColor(color clr) {
    this.clr = clr; 
  }
}
