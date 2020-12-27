 class Hitbox {
  PVector pos;
  PVector size;

  Hitbox(float x, float y, float w, float h) {
    pos = new PVector(x, y);
    size = new PVector(w, h);
  }

  boolean check(Hitbox box) {
    if (this == box)
      return false;
    // a - this
    // b - box
    float ax = this.pos.x - this.size.x/2;
    float ax1 = this.pos.x + this.size.x/2;
    float ay = this.pos.y - this.size.y/2;
    float ay1 = this.pos.y + this.size.y/2;

    float bx = box.pos.x - box.size.x/2;
    float bx1 = box.pos.x + box.size.x/2;
    float by = box.pos.y - box.size.y/2;
    float by1 = box.pos.y + box.size.y/2;

    class Point2 {
      float x, y;
      float x1, y1;

      Point2(float x, float y, float x1, float y1) {
        this.x = x;
        this.y = y;
        this.x1 = x1;
        this.y1 = y1;
      }
    };

    Point2 a = new Point2(ax, ay, ax1, ay1);
    Point2 b = new Point2(bx, by, bx1, by1);

    return(
      (
        (
          ( a.x>=b.x && a.x<=b.x1 )||( a.x1>=b.x && a.x1<=b.x1  )
        ) && (
          ( a.y>=b.y && a.y<=b.y1 )||( a.y1>=b.y && a.y1<=b.y1 )
        )
      )||(
        (
          ( b.x>=a.x && b.x<=a.x1 )||( b.x1>=a.x && b.x1<=a.x1  )
        ) && (
          ( b.y>=a.y && b.y<=a.y1 )||( b.y1>=a.y && b.y1<=a.y1 )
        )
      )
    )||(
      (
        (
          ( a.x>=b.x && a.x<=b.x1 )||( a.x1>=b.x && a.x1<=b.x1  )
        ) && (
          ( b.y>=a.y && b.y<=a.y1 )||( b.y1>=a.y && b.y1<=a.y1 )
        )
      )||(
        (
          ( b.x>=a.x && b.x<=a.x1 )||( b.x1>=a.x && b.x1<=a.x1  )
        ) && (
          ( a.y>=b.y && a.y<=b.y1 )||( a.y1>=b.y && a.y1<=b.y1 )
        )
      )
    );
  }

  void draw() {
    //rectMode(CENTER);
    //noFill();
    //stroke(255, 69, 0);
    //strokeWeight(3);
    //rect(pos.x, pos.y, size.x, size.y);
  }
  
  void setSize(float w, float h) {
    size.x = w;
    size.y = h;
  }
  
  void setPosition(float x, float y) {
    pos.x = x;
    pos.y = y;
  }
}
