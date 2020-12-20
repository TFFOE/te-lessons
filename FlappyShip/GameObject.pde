class GameObject {
  PVector pos;
  PVector speed;

  GameObject(float x, float y, float vx, float vy) {
    pos = new PVector(x, y);
    speed = new PVector(vx, vy);
  }

  void moveTo(float x, float y) {
    pos.set(x, y);
  }

  void move() {
    pos.add(speed);
  }

  void setSpeed(float vx, float vy) {
    speed.set(vx, vy);
  }

  void update() {
    move();
  }

  void draw() {}
}
