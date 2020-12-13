class Cloud extends Surface {
  PImage image;

  Cloud(float x, float y, float w, float h, float vx, float vy) {
    super(x, y, w, h);
    image = loadImage("img/cloud.png");
    image.resize(int(w), int(height * 0.2));
    this.vx = vx;
    this.vy = vy;
  }

  void draw() {
    imageMode(CENTER);
    image(image, x, y + 25);
  }

  void update() {
    x += vx;
    y += vy;

    if (x + image.width/2 > width || x - image.width/2 < 0)
      vx *= -1;
    if (y + image.height/2 > height || y - image.height/2 < 0)
      vy *= -1;
  }
}
