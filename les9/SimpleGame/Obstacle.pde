class Obstacle {
  float x, y;
  float w, h;

  Obstacle(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void draw() {
    rectMode(CENTER);
    fill(255, 0, 0);
    noStroke();
    rect(x, y, w, h);
  }

  void update() {
  }
}
