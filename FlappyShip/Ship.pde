class Ship extends Sprite {
  Ship(float x, float y) {
    super(x, y, 0, 0, "img/ship.png", 150, 0);
  }

  void update() {
    super.update();
    constrain();
    float GRAVITY = 0.5;
    applyForce(0, GRAVITY);
  }

  void constrain() {
    if (pos.x + image.width/2 > 400)
      pos.x  = 400 - image.width/2;
    if (pos.x - image.width/2< 0)
      pos.x = 0 + image.width/2;
  }

  void applyForce(float ax, float ay) {
    speed.add(ax, ay);
  }

  void jump() {
    speed.set(0, -10);
  }
}
