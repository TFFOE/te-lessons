class Monster {
  PImage image;
  int current_frame = 0;
  PImage frames[];
  boolean order_flag = false;
  Surface standing_on = null;
  boolean standing = false;

  boolean rotated = false;
  float x, y;
  float vx, vy;
  
  Monster(float x, float y) {
    this.x = x;
    this.y = y;
    image = loadImage("img/monster.png");

    int size_x = 5;
    int size_y = 3;

    float frame_w = (float)image.width / size_x;
    float frame_h = (float)image.height / size_y;

    // Нарезаем исходную картинку на кадры
    frames = new PImage[size_x * size_y];

    for (int i = 0; i < size_y; ++i) {
      for (int j = 0; j < size_x; ++j) {

        int index = i * size_x + j;
        frames[index] =
          image.get(
          int(j * frame_w), // левый верхний угол кадра (x - координата)
          int(i * frame_h), //                          (y - координата)
          int(frame_w), // ширина кадра
          int(frame_h) // высота кадра
          );
        frames[index].resize(200, 0);
      }
    }
  }

  void draw() {

    if (vx == 0) {
      current_frame = 11;
      float text_w = 250;
      float text_h = 80;
      rectMode(CENTER);
      fill(255, 255, 255, 170);
      float rect_x = x;
      float rect_y = y - text_h/2 - frames[current_frame].height/2;
      rect(rect_x, rect_y, text_w, text_h);
      textAlign(LEFT, TOP);
      fill(0);
      textSize(40);
      text("Скинь код", rect_x - text_w/2 + 20, rect_y - text_h/2 + 20);
    }

    imageMode(CENTER);
    if (rotated) {
      pushMatrix();
      translate(-frames[current_frame].width/4 + x, y);
      scale(-1, 1); // You had it right!
      image(frames[current_frame], 0, 0);
      popMatrix();
    } 
    else {
      image(frames[current_frame], x, y);
    }
    next_frame();



    if (abs(character.x - x) < 100 &&
        abs(character.y - y) < 100)
        {
          textAlign(CENTER, CENTER);
          textSize(100);
          fill(255, 0, 0);
          background(0);
          text("GAME OVER", width/2, height/2);
          noLoop();
        }
  }

  void next_frame() {

    current_frame++;
    if (current_frame >= 10)
      current_frame = 0;
  }
  
  void update() {
    standing = collision();
    {
      float target_x = character.x;
      if (target_x < x - 15 ) {
        vx = -3;
        rotated = true;
      }
      else if (target_x > x + 15) {
        vx = 3;
        rotated = false;
      }
      else {
        vx = 0;
      }
    }

    x += vx;

    // Если не стоим на поверхности - падаем
    if (!standing) {
      y += vy;
      float gravity = 1.2;
      vy += gravity;
    }
    // Если коснулись поверхности - не падаем, сбрасываем счетчик прыжков
    else {
      vy = 0;
    }
    
    if (standing_on != null) {
      x += standing_on.vx;
      y += standing_on.vy;
    }
  }
  
  boolean collision() {
    boolean result = false;

    for (Surface surf : surfaces) {
      if (vy > 0 &&
          y + frames[current_frame].height/2 < surf.y && 
          y + vy + frames[current_frame].height/2 > surf.y &&
          x < surf.x + surf.w/2 && 
          x > surf.x - surf.w/2) {
        result = true;
        standing_on = surf;
      }
    }
    return result;
  }
}
