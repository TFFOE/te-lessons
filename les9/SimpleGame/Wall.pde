class Wall extends Obstacle {
  PImage image;
  Wall(float x, float y, float w, float h) {
    super(x, y, w, h);
    image = loadImage("img/wall.png");
    image.resize(int(w), int(h));
  }

  void draw() {
    image(image, x, y);
    box.draw();
  }
}
