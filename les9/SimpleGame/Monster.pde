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
    image = loadImage("img/tucha.png");

    int size_x = 4;
    int size_y = 4;

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
      if (target_x < x - 10 ) {
        vx = -v;
        rotated = true;
      }
      else if (target_x > x + 10) {
        vx = v;
        rotated = false;
      }
      else {
        vx = 0;
      }
      float target_y = character.y;
      if (target_y < y - 10 ) {
        vy = -v;
        rotated = true;
      }
      else if (target_y > y + 10) {
        vy = v;
        rotated = false;
      }
      else {
        vy = 0;
      }
    }

    x += vx;
     y += vy;
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
