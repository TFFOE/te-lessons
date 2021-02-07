class Figure {
  char type = 'U';
  PVector pos;
  Square squares[] = new Square[4];
  color clr = color(255, 255, 0);
  byte rotation = 0;
  
  Figure(char type, float x, float y, float size) {
    this.type = type;
    pos = new PVector(x, y);
    switch (type) {
      case 'E':
        squares[0] = new Square(-1 * size, -1 * size, size);
        squares[1] = new Square(-1 * size, -1 * size, size);
        squares[2] = new Square(0, -1 * size, size);
        squares[3] = new Square(0, -1 * size, size);
        
      break;
      case 'I':
        squares[0] = new Square(-2 * size, -1 * size, size);
        squares[1] = new Square(-1 * size, -1 * size, size);
        squares[2] = new Square(0, -1 * size, size);
        squares[3] = new Square(1 * size, -1 * size, size);
      break;
        
      case 'J':
        squares[0] = new Square(-1.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
      break;
      
      case 'L':
        squares[0] = new Square(0.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
      break;
      
      case 'O':
        squares[0] = new Square(-1 * size, -1 * size, size);
        squares[1] = new Square(-1 * size, 0, size);
        squares[2] = new Square(0, 0, size);
        squares[3] = new Square(0, -1 * size, size);
      break;
      
      case 'S':
        squares[0] = new Square(0.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(-0.5 * size, -1.5 * size, size);
      break;
      
      case 'T':
        squares[0] = new Square(-0.5 * size, -1.5 * size, size);
        squares[1] = new Square(-1.5 * size, -0.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
      break;
      
      case 'Z':
        squares[0] = new Square(-1.5 * size, -1.5 * size, size);
        squares[1] = new Square(-0.5 * size, -1.5 * size, size);
        squares[2] = new Square(-0.5 * size, -0.5 * size, size);
        squares[3] = new Square(0.5 * size, -0.5 * size, size);
      break;
    }
    
    for (Square s : squares) {
      s.setColor(clr);
    }
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
      //s.display();
      s.moveAndDraw(pos.x, pos.y);
    stroke(0, 0, 255);
    strokeWeight(10);
    point(pos.x, pos.y);
  }
}
// code max