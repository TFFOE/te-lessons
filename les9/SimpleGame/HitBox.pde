class HitBox {
  float x, y, w, h;

  HitBox(float x, float y, float w, float h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  void update(float x, float y) {
    this.x = x;
    this.y = y;
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
}
