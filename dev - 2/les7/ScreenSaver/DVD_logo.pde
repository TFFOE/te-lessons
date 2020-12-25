class Logo {
  float x, y;
  float vx, vy;
  PImage image;
  String path = "img/logo.png";
  
  Logo(float x, float y) {
    this.x = x;
    this.y = y;
    image = loadImage(path);
    image.resize(250, 0);
  }
  
  void update() {
    x += vx;
    y += vy;
    
    float w = image.width;
    float h = image.height;
    
    if (x + w/2 > width || x - w/2 < 0) {
      setRandomColor();
      vx *= -1;
    }
    
    if (y + h/2 > height || y - h/2 < 0) {
      setRandomColor();
      vy *= -1; 
    }
  }
  
  void setRandomColor() {
    PImage base_image = loadImage(path);
    base_image.resize(250, 0);
    color clr = color(int(random(0, 255)), int(random(0, 255)), int(random(0,255)));
    base_image.loadPixels();
    for (int i = 0; i < base_image.pixels.length; ++i) {
      if (alpha(base_image.pixels[i]) != 0) {
        base_image.pixels[i] = clr;
      }
    }
    image = base_image;
  }
  
  void draw() {
    imageMode(CENTER);
    image(image, x, y);
  }
}
