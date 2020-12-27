class Sprite extends GameObject {
  PImage image;
  Hitbox box;

  Sprite(float x, float y, float vx, float vy, String img_path) {
    super(x, y, vx, vy);
    image = loadImage(img_path);
  }

  Sprite(float x, float y, float vx, float vy, String img_path, int size_x, int size_y) {
    super(x, y, vx, vy);
    image = loadImage(img_path);
    image.resize(size_x, size_y);
    box = new Hitbox(x, y, image.width, image.height);
  }

  void draw() {
    imageMode(CENTER);
    image(image, pos.x, pos.y);
    box.draw();
  }
  
  void update() {
    super.update();
    box.setPosition(pos.x, pos.y);
  }

  boolean check(Sprite rhs) {
    return box.check(rhs.box);
  }
}
