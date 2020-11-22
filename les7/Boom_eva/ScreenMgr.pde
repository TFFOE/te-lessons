class ScreenMgr {
  // Скорость изменения масштаба
  float d_scale = 0.1;
  
  boolean SCALING;
  boolean TRANSLATING;
  
  float scaleFactor = 1;
  float prev_x = mouseX, prev_y = mouseY;
  float current_traslate_x, current_traslate_y;

  ScreenMgr(boolean scale_flag, boolean translate_flag) {
    SCALING = scale_flag;
    TRANSLATING = translate_flag;
  }

  void mouseWheelFunc(float e) {
    if (SCALING) {
      if (e > 0) {
        scaleFactor -= d_scale;
      } else if (e < 0) {
        scaleFactor += d_scale;
      }
    }
  }

  void work() {
    if (SCALING) translate(width/2, height/2);

    if (TRANSLATING) {
      if (mousePressed) {
        float dx = mouseX - prev_x;
        float dy = mouseY - prev_y;
        current_traslate_x += dx;
        current_traslate_y += dy;
      }
      translate(current_traslate_x, current_traslate_y);

      prev_x = mouseX;
      prev_y = mouseY;
    }
    if (SCALING) {
      scale(scaleFactor);
      translate(-width/2, -height/2);
    }
  }
}
