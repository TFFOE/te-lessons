class Crocodile extends Character {


  Crocodile(int x, int y) {
    super(x, y);
  }

  void mouseClicked() {
    x = mouseX;
    y = mouseY;
  }
  void update() {
    if (mousePressed) {
      
      mouseClicked();
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
    } else {
      int flag = int(random(100));
      if (flag % 100 < 5) {
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
  }


  void draw() {
    fill(#00cc00);
    strokeWeight(8);
    ellipse(x, y, 50, 50);
    line(x+18, y-22, x+108, y-5);
    line(x+108, y-5, x+115, y+12);
    line(x+115, y+12, x+18, y+22);
    line(x+115, y+12, x+110, y+30);
    line(x+110, y+30, x+100, y+14);
    fill(#00cc00);
    stroke(0);
    strokeWeight(5);
    circle(x-8, y-22, 20);
    fill(0);
    ellipse(x-8, y-22, 5, 10);
  }
}
