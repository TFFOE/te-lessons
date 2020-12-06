class Char {
  PImage image;
  int current_frame = 0;
  PImage frames[];
  boolean order_flag = false;
  float x, y;
  float vx, vy;

  int frameTime = 50;
  int prevTime = millis();

  int jumpCounter = 0;
  int maxJumps = 2;

  boolean rotated = false;
  boolean standing = false;

  Surface standing_on = null;

  int jumps_to_boost = 15;
  int total_jumps = 0;
  
  float mult = 1;

  Char(int x, int y) {
    this.x = x;
    this.y = y;
    image = loadImage("img/char.png");

    int size_x = 5;
    int size_y = 2;

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
        frames[index].resize(150, 0);
      }
    }
  }

  void draw() {
    imageMode(CENTER);
    if (vx == 0)
      current_frame = 4;
    
    if (rotated) {
      pushMatrix();
      translate(-frames[current_frame].width/4 + x, y);
      scale(-1, 1); // You had it right!
      image(frames[current_frame], 0, 0);
      popMatrix();
    } else {
      image(frames[current_frame], x, y);
    }
       
    if (millis() - prevTime > frameTime) {
      prevTime = millis();
      next_frame();
    }
    
    fill(255);
    textSize(30);
    textAlign(RIGHT);
    text(str(total_jumps), width - 30, 30);
  }

  void next_frame() {
    current_frame++;
    if (current_frame >= frames.length)
      current_frame = 0;
  }

  void update() {
    if (y > 1000){
      text("Game Over",width/2,height/2);
      noLoop();
    }
    standing = collision();
    x += vx;
    if (mult > 1 && vx != 0)
      mult -= 0.01;
    
    // Если не стоим на поверхности - падаем
    if (!standing) {
      y += vy;
      float gravity = 1.2;
      vy += gravity;
    }
    // Если коснулись поверхности - не падаем, сбрасываем счетчик прыжков
    else {
      vy = 0;
      jumpCounter = 0;
    }
    
    if (standing_on != null) {
      x += standing_on.vx;
      y += standing_on.vy;
    }
  }

  void move(int _keyCode) {
    switch (_keyCode) {
    // Прыжок
    case 'W':
      if (total_jumps == jumps_to_boost) {
        mult += 1;
        total_jumps = 0;
      }
      if (jumpCounter < maxJumps) {
        vy = -20 * mult;
        jumpCounter++;
        total_jumps++;
        standing = false;
        standing_on = null;
      }
      break;

    // Движение влево
    case 'A':
      vx = -10 * mult;
      rotated = true;
      break;
    
    // Движение вправо
    case 'D':
      vx = 10 * mult;
      rotated = false;
      break;
    }
  }

  void stop(int _keyCode) {
    switch (_keyCode) {
    case 'A':
      if (vx < 0)
        vx = 0;
      break;

    case 'D':
      if (vx > 0)
        vx = 0;
      break;
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
