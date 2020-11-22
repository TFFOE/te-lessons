class Circle extends Character {

  Circle(int x, int y) {
    super(x, y);
  }

  void draw() {
    fill( #ff00ff);
    strokeWeight(8);
    ellipse(x, y, 50, 50);
    stroke(0);                  
    line(x-20, y-20, x-10, y-50);
    line(x-10, y-50, x, y-25);
    line(x, y-25, x+20, y-50);
    line(x+20, y-50, x+20, y-20);
  }
}
