class Figure {
  char type; // Тип фигуры
  PVector pos; // Положение фигуры на экране (в пикселях)
  Square squares[] = new Square[4]; // Квадраты, из которых состоит фигура
  color clr = color(255, 255, 0); // Цвет фигуры
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

  void setFigure(int type, byte rotation) {
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
        squares[0] = new Square(-1.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
      break;

      // TODO: Коля
      // []
      // []
      // [][]
      case 'L':
        squares[0] = new Square(0.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
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
        squares[0] = new Square(0.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(-0.5 * size, -1.5 * size, size);
      break;

      //   []
      // [][][]
      case 'T':
        switch (rotation) {
          case 0:
            squares[0] = new Square(-0.5 * size, -1.5 * size, size);
            squares[1] = new Square(-1.5 * size, -0.5 * size, size);
            squares[2] = new Square(-0.5 * size, -0.5 * size, size);
            squares[3] = new Square(0.5 * size, -0.5 * size, size);
          break;
          case 1:
            squares[0] = new Square(-0.5 * size, -1.5 * size, size);
            squares[1] = new Square(-0.5 * size, 0.5 * size, size);
            squares[2] = new Square(-0.5 * size, -0.5 * size, size);
            squares[3] = new Square(0.5 * size, -0.5 * size, size);
          break;
          case 2:
            squares[0] = new Square(-0.5 * size, 0.5 * size, size);
            squares[1] = new Square(-1.5 * size, -0.5 * size, size);
            squares[2] = new Square(-0.5 * size, -0.5 * size, size);
            squares[3] = new Square(0.5 * size, -0.5 * size, size);
          break;
          case 3:
            squares[0] = new Square(-0.5 * size, -1.5 * size, size);
            squares[1] = new Square(-0.5 * size, 0.5 * size, size);
            squares[2] = new Square(-0.5 * size, -0.5 * size, size);
            squares[3] = new Square(-1.5 * size, -0.5 * size, size);
          break;
        }
      break;

      // TODO: Макс
      // [][]
      //   [][]
      case 'Z':
        squares[0] = new Square(-1.5 * size, -1.5 * size, size);
        squares[1] = new Square(-0.5 * size, -1.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
      break;
    }

    this.setColor(clr);
  }

  void rotate() {
    rotation += 1;
    if (rotation == 4)
      rotation = 0;

    this.setFigure(type, rotation);
  }

  void rotateBack() {
    rotation -= 1;
    if (rotation == -1)
      rotation = 3;

    this.setFigure(type, rotation);
  }

  void setColor(color clr) {
    this.clr = clr;
    for (Square s : squares)
      s.setColor(clr);
  }

  void setPosition(float x, float y) {
    pos.set(x, y);
  }

  void setType(char new_type) {
    type = new_type;
  }

  void move(float dx, float dy) {
    pos.add(dx, dy);
  }

  void display() {
    for (Square s : squares)
      s.moveAndDraw(pos.x, pos.y);
    stroke(0, 0, 255);
    strokeWeight(10);
    point(pos.x, pos.y);
  }
}
