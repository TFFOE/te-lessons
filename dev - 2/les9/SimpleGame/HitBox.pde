class HitBox {
  float x, y, w, h;
  float offset_y;

  HitBox(float x, float y, float w, float h) {
    this(x, y, w, h, 0);
  }

  HitBox(float x, float y, float w, float h, float offset) {
    this.x = x;
    this.w = w;
    this.h = h;
    this.offset_y = offset;
    this.y = y + offset_y;
  }

  void update(float x, float y) {
    this.x = x;
    this.y = y + offset_y;
  }

  boolean check_collision(HitBox box) {
    return(
    (
      (
        ( this.left()>=box.left() && this.left()<=box.right() )||( this.right()>=box.left() && this.right()<=box.right()  )
      ) && (
        ( this.top()>=box.top() && this.top()<=box.bottom() )||( this.bottom()>=box.top() && this.bottom()<=box.bottom() )
      )
    )||(
      (
        ( box.left()>=this.left() && box.left()<=this.right() )||( box.right()>=this.left() && box.right()<=this.right()  )
      ) && (
        ( box.top()>=this.top() && box.top()<=this.bottom() )||( box.bottom()>=this.top() && box.bottom()<=this.bottom() )
      )
    )
    )||(
    (
      (
        ( this.left()>=box.left() && this.left()<=box.right() )||( this.right()>=box.left() && this.right()<=box.right()  )
      ) && (
        ( box.top()>=this.top() && box.top()<=this.bottom() )||( box.bottom()>=this.top() && box.bottom()<=this.bottom() )
      )
    )||(
      (
        ( box.left()>=this.left() && box.left()<=this.right() )||( box.right()>=this.left() && box.right()<=this.right()  )
      ) && (
        ( this.top()>=box.top() && this.top()<=box.bottom() )||( this.bottom()>=box.top() && this.bottom()<=box.bottom() )
      )
    )
  );
  }

  float right() {
    return x + w/2;
  }

  float left() {
    return x - w/2;
  }

  float top() {
    return y - h/2;
  }

  float bottom() {
    return y + h/2;
  }

  void draw() {
    rectMode(CENTER);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    rect(x, y, w, h);
  }
}
