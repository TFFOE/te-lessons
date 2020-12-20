class Ship extends Sprite {
  Ship(float x, float y) {
    super(x, y, 0, 0, "img/ship.png", 200, 0);
  }

  void update() {
    super.update();

    float GRAVITY = 0.5;
    applyForce(0, GRAVITY);
  }

  void applyForce(float ax, float ay) {
    speed.add(ax, ay);
  }

  void jump() {
    speed.set(0, -15);
  }
}
