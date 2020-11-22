class W extends Character {
  PImage image;
  int current_frame = 0;
  PImage frames[];
  boolean order_flag = false;
  W(int x, int y) {
    super(x, y);
    image = loadImage("img/bat.png");

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
          image.get(int(j * frame_w), // левый верхний угол кадра (x - координата)
          int(i * frame_h), //                          (y - координата)
          int(frame_w), // ширина кадра
          int(frame_h) // высота кадра
          );
        frames[index].resize(70, 0);
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
}
