class Character {
  float x, y;
  float vx, vy;
  int i, j;

  Character(int i, int j) {
    PVector position = grid.getCenterOf(i, j);
    this.x = position.x;
    this.y = position.y;
    this.vx = 0;
    this.vy = 0;
    this.i = i;
    this.j = j;
  }

  void draw() {
    println("draw");
  }

  void update() {
    int flag = int(random(100));
    if (flag % 100 < 2) {
      vx = random(-5, 5);
      vy = random(-5, 5);
    }
    x += vx;
    y += vy;
    
    float top = grid.getTop(i, j);
    float bottom = grid.getBottom(i, j);
    float right = grid.getRight(i, j);
    float left = grid.getLeft(i, j);
    
    if (x > right)
      x = right;
    else if (x < left)
      x = left;
      
    if (y > bottom)
      y = bottom;
    else if (y < top)
      y = top;
  }

  void setSpeed(float vx, float vy) {
    this.vx = vx;
    this.vy = vy;
  }
}
