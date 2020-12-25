class Packmen extends Character {

  Packmen(int x, int y) {
    super(x, y);
  }

  Packmen(int x, int y, float d) {
    super(x, y);
  }

  void draw() {
    fill(#ffff00);
    stroke(255);
    strokeWeight(5);
    stroke(0, 0, 0);
    arc(x, y, 100, 100, 0.5, 5.5, PIE);
    strokeWeight(13);
    stroke(0, 0, 0);
    point(x - 10, y - 20);
  }
}
