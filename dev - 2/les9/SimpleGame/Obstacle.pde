class Obstacle {
  float x, y; // Координаты центра
  float w, h; // Ширина, высота
  HitBox box;

  Obstacle(float x, float y, float w, float h) {
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   box = new HitBox(x, y, w, h);
  }

  void draw() {
    rectMode(CENTER);
    fill(255, 0, 0);
    noStroke();
    rect(x, y, w, h);
  }

  void update() {
    box.update(x, y);
  }
}
