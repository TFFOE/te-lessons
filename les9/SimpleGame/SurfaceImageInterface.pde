class MovableSurfaceWithImage extends Surface {
  PImage image;
  float vx, vy;
  float offset = 0;

    MovableSurfaceWithImage(float x, float y, float w, float h, float vx, float vy, float vertical_offset) {
      super(x, y, w, h);
      this.vx = vx;
      this.vy = vy;
      this.offset = vertical_offset;
    }
    
    void loadSurfaceImage(String path, int w, int h) throws Exception {
      image = loadImage(path);
      if (image == null) {
          throw new Exception("Файл не найден");
      }
      image.resize(w, h);
    }

    void drawImage(float x, float y) {
      imageMode(CENTER);
      image(image, x, y);
    }
    
    void update() {
      x += vx;
      y += vy;
      if (x + image.width/2 > width || x - image.width/2 < 0)
        vx *= -1;
      if (y + image.height/2 > height || y - image.height/2 < 0)
        vy *= -1;
    }
    
    void draw() {
      drawImage(x, y + offset);
    }
}
