import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class FlappyShip extends PApplet {

Game game;

public void setup() {
  
  game = new Game();
}

public void draw() {
  game.update();
  game.draw();
}

public void keyPressed() {
  game.keyPressedProcess(key, keyCode);
}
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

  public void update() {
    if (paused || gameover) return;

    for (GameObject obj : objects) {
      obj.update();
    }

    if (checkIfGameOver()) {
      gameover = true;
      return;
    }
  }

  public void draw() {
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

  public boolean checkIfGameOver() {
    if (player.pos.y - player.image.height/2 - 50 > height)
      return true;
    return false;
  }

  public void keyPressedProcess(char _key, int _keyCode) {
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

        case 'f':
        case 'F':
          start();
          break;
      }
    else
      switch (_keyCode) {
      }
  }

  public void start() {
    if (gameover) {
      reset();
    }
    else if (paused)
    {
      paused = false;
    }
  }

  public void reset() {
    paused = true;
    gameover = false;
    player.moveTo(200, height/2);
  }


  public void togglePause() {
    paused = !paused;
  }

  public void drawPauseScreen() {
    fill(0, 0, 0, 128);
    noStroke();
    rectMode(CORNER);
    rect(0, 0, width, height);

    fill(255);
    textSize(50);
    textAlign(CENTER, CENTER);
    text("Game on pause. Press SPACE to continue...", width/2, height/2);
  }

  public void drawGameOverScreen() {
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
class GameObject {
  PVector pos;
  PVector speed;

  GameObject(float x, float y, float vx, float vy) {
    pos = new PVector(x, y);
    speed = new PVector(vx, vy);
  }

  public void moveTo(float x, float y) {
    pos.set(x, y);
  }

  public void move() {
    pos.add(speed);
  }

  public void setSpeed(float vx, float vy) {
    speed.set(vx, vy);
  }

  public void update() {
    move();
  }

  public void draw() {}
}
class Ship extends Sprite {
  Ship(float x, float y) {
    super(x, y, 0, 0, "img/ship.png", 200, 0);
  }

  public void update() {
    super.update();

    float GRAVITY = 0.5f;
    applyForce(0, GRAVITY);
  }

  public void applyForce(float ax, float ay) {
    speed.add(ax, ay);
  }

  public void jump() {
    speed.set(0, -15);
  }
}
class Sprite extends GameObject {
  PImage image;

  Sprite(float x, float y, float vx, float vy, String img_path) {
    super(x, y, vx, vy);
    image = loadImage(img_path);
  }

  Sprite(float x, float y, float vx, float vy, String img_path, int size_x, int size_y) {
    super(x, y, vx, vy);
    image = loadImage(img_path);
    image.resize(size_x, size_y);
  }

  public void draw() {
    imageMode(CENTER);
    image(image, pos.x, pos.y);
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "FlappyShip" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
