class Pu extends Sprite {
  float hole_radius = 350;
  PImage rotated;
  Hitbox box2;
  Pu(float x, float y) {
    super(x, y, 0, 0, "img/wall.png", 80, height);
    speed.x = -8;
    rotated = loadImage("img/wall_rotated.png");
    rotated.resize(80, height);
    box.setPosition(pos.x, pos.y + hole_radius/2 + image.height/2);
    box.setSize(image.width, image.height);
    box2 = new Hitbox(pos.x, pos.y - hole_radius/2 - image.height/2, rotated.width, rotated.height);
  }

  void draw() {
    imageMode(CENTER);
    image(image, pos.x, pos.y + hole_radius/2 + image.height/2);
    image(rotated, pos.x, pos.y - hole_radius/2 - image.height/2);
    println(box.pos, box.size);
    box.draw();
    box2.draw();
  }

  void update() {
    move();
    box.setPosition(pos.x, pos.y + hole_radius/2 + image.height/2);
    box2.setPosition(pos.x, pos.y - hole_radius/2 - image.height/2);
  }

  boolean check(Sprite rhs) {
    return box.check(rhs.box) || box2.check(rhs.box);
  }
}
