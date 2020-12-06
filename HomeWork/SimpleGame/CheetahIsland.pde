class CheetahIsland extends Surface {
  PImage image;
  
  CheetahIsland(float x, float y, float w, float h, float vx, float vy) {
    super(x, y, w, h);
    image = loadImage("img/islandmy.png");
    this.vx = vx;
    this.vy = vy;
  }
  
  void draw() {
    imageMode(CENTER);
    image.resize(int(w), int(height * 0.3));
    image(image, x, y + 80);
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
