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

public class SimpleGame extends PApplet {

PImage back;
Char character;

Surface[] surfaces;

public void setup() {
  
  frameRate(60);
  back = loadImage("img/background.jpg", "jpg");
  back.resize(0, height);
  character = new Char(width/2, height/2);
  
  surfaces = new Surface[] { 
    new FloatingIsland(width/2, height/2 + 100, 600, 10, 2, 0),
    new FloatingIsland(width/2 + 200, height/2 - 100, 400, 10, -2, 2),
    new FloatingIsland(width/2 + 200, height/2 - 100, 200, 10, -2, 4),
    new FloatingIsland(width/2 + 200, height/2 - 100, 100, 10, -5, 2),
    new Surface(width/2, height - height/10, width, height/3),
  };
}

public void draw() {
  background(255);
  drawBackground(back);
  
  
  for (Surface surf : surfaces) {
    surf.update();
    surf.draw();
  }
  
  character.update();
  character.draw();
  
  
}

public void keyPressed() {
  character.move(keyCode);
}

public void keyReleased() {
  character.stop(keyCode);
}
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
          PApplet.parseInt(j * frame_w), // левый верхний угол кадра (x - координата)
          PApplet.parseInt(i * frame_h), //                          (y - координата)
          PApplet.parseInt(frame_w), // ширина кадра
          PApplet.parseInt(frame_h) // высота кадра
          );
        frames[index].resize(150, 0);
      }
    }
  }

  public void draw() {
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
    text(str(jumpCounter), 30, width - 30);
  }

  public void next_frame() {
    current_frame++;
    if (current_frame >= frames.length)
      current_frame = 0;
  }

  public void update() {
    standing = collision();
    x += vx;
    
    // Если не стоим на поверхности - падаем
    if (!standing) {
      y += vy;
      float gravity = 1.2f;
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

  public void move(int _keyCode) {
    switch (_keyCode) {
    // Прыжок
    case 'W':
      if (jumpCounter < maxJumps) {
        vy = -20;
        jumpCounter++;
        standing = false;
        standing_on = null;
      }
      break;

    // Движение влево
    case 'A':
      vx = -10;
      rotated = true;
      break;
    
    // Движение вправо
    case 'D':
      vx = 10;
      rotated = false;
      break;
    }
  }

  public void stop(int _keyCode) {
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

  public boolean collision() {
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
class FloatingIsland extends Surface {
  PImage image;
  
  FloatingIsland(float x, float y, float w, float h, float vx, float vy) {
    super(x, y, w, h);
    image = loadImage("img/island.png");
    this.vx = vx;
    this.vy = vy;
  }
  
  public void draw() {
    imageMode(CENTER);
    image.resize(PApplet.parseInt(w), PApplet.parseInt(height * 0.3f));
    image(image, x, y + 25);
  }
  
  public void update() {
    x += vx;
    y += vy;
    
    if (x + image.width/2 > width || x - image.width/2 < 0)
      vx *= -1;
    if (y + image.height/2 > height || y - image.height/2 < 0)
      vy *= -1;
  }
}
class Obstacle {
  float x, y;
  float w, h;
  
  Obstacle(float x, float y, float w, float h) {
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
  }
  
  public void draw() {
    rectMode(CENTER);
    fill(255, 0, 0);
    noStroke();
    rect(x, y, w, h);
  }
  
  public void update() {
    
  }
}
class Surface {
  float x, y;
  float w, h;
  float vx = 0, vy = 0;
  
  Surface(float x, float y, float w, float h) {
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
  }
  
  public void draw() {
    //rectMode(CENTER);
    //fill(255, 0, 0);
    //noStroke();
    //rect(x, y, w, h);
  }
  
  public void update() {
    
  }
}
public void drawBackground(PImage background) {
  imageMode(CORNER);
  image(background, 0, 0);
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SimpleGame" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
