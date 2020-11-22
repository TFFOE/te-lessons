class Explosion { //<>//
  PImage image;
  int current_frame = 0;
  PImage frames[];
  boolean order_flag = false;
  float x, y;
  float vx, vy;

  boolean jump_flag = false;

  Explosion(int x, int y) {
    this.x = x;
    this.y = y;
    image = loadImage("img/Pers.png");

    int size_x = 3;
    int size_y = 3;

    float frame_w = (float)image.width / size_x;
    float frame_h = (float)image.height / size_y;

    // Нарезаем исходную картинку на кадры
    frames = new PImage[size_x * size_y];

    for (int i = 0; i < size_x; ++i) {
      for (int j = 0; j < size_y; ++j) {

        int index = i * size_x + j;
        frames[index] =
          image.get(int(j * frame_w), // левый верхний угол кадра (x - координата)
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
    image(frames[current_frame], x, y);
    next_frame();
  }

  void next_frame() {

    current_frame++;
    if (current_frame >= frames.length)
      current_frame = 0;
  }

  void action(int code) {
    switch (code) {
    case 'D':
      vx = 10;
      break;
    case 'A':
      vx = -10;
      break;
    case 'W':
      // Чтобы не было двойного / тройного / ... прыжка
      if (jump_flag == false) {
        vy = -35; // Начальная скорость при прыжке
        jump_flag = true;
      }
      break;
    }
  }

  void update() {
    x += vx;
    y += vy;
    vy += 2.5; // Ускорение вниз, когда падаешь после прыжка
    if (y > 330) { // Высота, после которой падение останавливается
      vy = 0;
      jump_flag = false;
    }
  }

  void stop(int code) {
    if (code == 'A' && vx < 0 || code == 'D' && vx > 0)
      vx = 0;
  }
}
