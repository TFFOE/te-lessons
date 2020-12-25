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

    if (rotated) {
      pushMatrix();
      translate(frames[current_frame].width/2 + x, y);
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
  }

  void next_frame() {
    current_frame++;
    if (current_frame >= frames.length)
      current_frame = 0;
  }

  void update() {
    standing = collision();
        
    x += vx;
    if (!standing) {
      y += vy;
      float gravity = 1.2;
      vy += gravity;
    }
    else {
      vy = 0;
      jumpCounter = 0;
    }
    
    if (y > height * 0.8) {
      vy = 0;
      y = height * 0.8;
      jumpCounter = 0;
      standing = true;
    }
  }

  void move(int _keyCode) {
    switch (_keyCode) {
    case 'W':
      if (jumpCounter < maxJumps) {
        vy = -20;
        jumpCounter++;
        standing = false;
      }
      break;

    case 'A':
      vx = -10;
      rotated = true;
      break;

    case 'D':
      vx = 10;
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

    for (Obstacle obs : obstacles) {
      if (obs instanceof FloatingIsland)
      {
        if (vy > 0 && 
            y + frames[current_frame].height/2 < obs.y && 
            y + vy + frames[current_frame].height/2 > obs.y &&
            x - frames[current_frame].width/2 < obs.x + obs.w/2 && 
            x + frames[current_frame].width/2 > obs.x - obs.w/2) {
          result = true;
        }
      }
    }
    
    return result;
  }
}
