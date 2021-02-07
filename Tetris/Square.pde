class Square {
  PVector pos;
  PVector size;
  color clr = color(255, 0, 0);
  
  Square(float x, float y, float s) {
    pos = new PVector(x, y);
    size = new PVector(s, s);
  }
  
  void display() {
    rectMode(CORNER);
    fill(clr);
    stroke(0);
    strokeWeight(2);
    float radius = size.x * 0.15;
    float left = pos.x + radius;
    float right = pos.x + size.x - radius;
    float top = pos.y + radius;
    float bottom = pos.y + size.y - radius;
    
    float red = red(clr);
    float green = green(clr);
    float blue = blue(clr);
    
    color light_color = color(red + 150, green + 150, blue + 150);
    color medium_color = color(red - 20, green - 20, blue - 20);
    color dark_color = color(red - 60, green - 60, blue - 60);
    rectMode(CORNERS);
    noStroke();
    rect(left, top, right, bottom);
    fill(light_color);
    quad(pos.x, pos.y,
         pos.x + size.x, pos.y,
         right, top, 
         left, top);
    fill(medium_color);
    quad(pos.x, pos.y,
         pos.x, pos.y + size.y,
         left, bottom,
         left, top);
    quad(pos.x + size.x, pos.y,
         pos.x + size.x, pos.y + size.y,
         right, bottom,
         right, top);
    fill(dark_color);
    quad(pos.x, pos.y + size.y,
         pos.x + size.x, pos.y + size.y,
         right, bottom,
         left, bottom);
  }
  
  void setPosition(float x, float y) {
    pos.set(x, y);
  }
  
  void move(float dx, float dy) {
    pos.add(dx, dy);
  }
  
  void moveAndDraw(float dx, float dy) {
    PVector old_pos = pos.copy();
    this.move(dx, dy);
    this.display();
    pos = old_pos.copy();
  }
  
  void setColor(color clr) {
    this.clr = clr; 
  }
}
//MC
