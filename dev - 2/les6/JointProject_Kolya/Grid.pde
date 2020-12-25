class Grid {
  int w, h;
  Grid(int w, int h) {
    this.w = w;
    this.h = h;
  }
  
  void draw() {
    stroke(0);
    strokeWeight(1);
    for (int i = 1; i < h; ++i) {
      line(width/h * i, 0, 
       width/h * i, height);
    }
    for (int i = 1; i < w; ++i) {
      line(0,     height/w * i, 
           width, height/w * i);
    }
  }
  
  PVector getCenterOf(int i, int j) {
    if (i > w - 1) i = w - 1;
    if (j > h - 1) j = h - 1;
    if (i < 0) i = 0;
    if (j < 0) j = 0;
    float x = (j + 0.5) * width/h;
    float y = (i + 0.5) * height/w;
    return new PVector(x, y);
  }
  
  float getTop(int i, int j) {
    return i * height/w;
  }
  float getBottom(int i, int j) {
    return getTop(i + 1, j);
  }
  float getRight(int i, int j) {
    return getLeft(i, j + 1);
  }
  float getLeft(int i, int j) {
    return j * width/h;
  }
}
