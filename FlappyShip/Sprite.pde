class Sprite extends GameObject {
  PImage image;

  Sprite(float x, float y, float vx, float vy, String img_path) {
    super(x, y, vx, vy);
    image = loadImage(img_path);
  }

  Sprite(float x, float y, float vx, float vy, String img_path, int size_x, int size_y) {
    super(x, y, vx, vy);
    image = loadImage(img_path);
    image.resize(size_x, size_y);
  }

  void draw() {
    imageMode(CENTER);
    image(image, pos.x, pos.y);
  }
}
