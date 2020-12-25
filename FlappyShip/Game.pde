class Game {
  boolean paused = true;
  boolean gameover = false;

  GameObject[] objects;
  Ship player;

  PImage background;
  Game() {
    background = loadImage("img/background.png");
    background.resize(width, 0);

    player = new Ship(200, height/2);
    objects = new GameObject[]{
      player,
    };
  }

  void update() {
    if (paused || gameover) return;

    for (GameObject obj : objects) {
      obj.update();
    }

    if (checkIfGameOver()) {
      gameover = true;
      return;
    }
  }

  void draw() {
    imageMode(CORNER);
    image(background, 0, 0);

    for (GameObject obj : objects) {
      obj.draw();
    }

    if (gameover) {
      drawGameOverScreen();
    }
    else if (paused) {
      drawPauseScreen();
    }
  }

  boolean checkIfGameOver() {
    if (player.pos.y - player.image.height/2 - 50 > height)
      return true;
    return false;
  }

  void keyPressedProcess(char _key, int _keyCode) {
    if (_key != CODED)
      switch (_key) {
        case 'P':
        case 'p':
          paused = true;
          break;

        case ' ':
          start();
          player.jump();
          break;
        case 'D':
        case 'd':
          start();
          player.pos.x = player.pos.x + 25;
          if (player.pos.x > 500){
            player.pos.x = 500;
          }
          break;
        case 'A':
        case 'a':
          start();
          player.pos.x = player.pos.x - 25;
          if (player.pos.x < 50){
            player.pos.x = 150;
          }
          break;

        case 'f':
        case 'F':
          start();
          break;
      }
    else
      switch (_keyCode) {
      }
  }

  void start() {
    if (gameover) {
      reset();
    }
    else if (paused)
    {
      paused = false;
    }
  }

  void reset() {
    paused = true;
    gameover = false;
    player.moveTo(200, height/2);
  }


  void togglePause() {
    paused = !paused;
  }

  void drawPauseScreen() {
    fill(0, 0, 0, 128);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width, height);

    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Game on pause. Press SPACE to continue...", width/2, height/2);
  }

  void drawGameOverScreen() {
    fill(128, 0, 0, 128);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width, height);

    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("You lose! Press 'F' to restart.", width/2, height/2);
  }

}
