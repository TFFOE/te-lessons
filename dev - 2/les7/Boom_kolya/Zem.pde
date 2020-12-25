class Zem {
  int x;
  int y;
  PImage image;

  Zem(int x, int y) {
    this.x = x;
    this.y = y;
    image = loadImage("img/Background.png");
  }

  void draw() {
    imageMode(CENTER);
    image(image, y, x);
}
}
