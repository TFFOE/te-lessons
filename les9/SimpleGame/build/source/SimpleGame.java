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
Monster monster;

Surface[] surfaces;
Obstacle[] obstacles;

public void setup() {
  
  frameRate(60);
  back = loadImage("img/background.jpg", "jpg");
  back.resize(0, height);

  character = new Char(width - 50, 100);
  monster = new Monster(50, height - 300);

  surfaces = new Surface[] {
    new FloatingIsland(width/2, height/2, 600, 10, 0, 0),
    new Cloud(width/2 + 200, height/2 - 100, 350, 20, 5, 0),
    new IslandYou(width/2 + 200, height/2 - 100, 400, 10, 0, 6),
    new CheetahIsland(width/2 + 200, height/2 - 100, 400, 10, 5, 2),
    new Surface(width/2, height - height/10, width * 4, height/3),
  };

  obstacles = new Obstacle[] {
    new Wall(width/2, height - height/10 - 85, 100, 250),
    new Wall(width/2 + 300, height - height/10 - 85, 100, 250),
  };
}

public void draw() {
  background(255);
  drawBackground(back);


  for (Surface surf : surfaces) {
    surf.update();
    surf.draw();
  }

  for (Obstacle obs : obstacles) {
    obs.update();
    obs.draw();
  }

  character.update();
  character.draw();

  monster.update();
  monster.draw();
}

public void keyPressed() {
  character.move(keyCode);
}

public void keyReleased() {
  character.stop(keyCode);
}
float gravity = 1.2f;

class Char {
  PImage image;
  PImage frames[];
  int current_frame = 0;
  boolean order_flag = false;
  int frameTime = 50;
  int prevTime = millis();
  boolean rotated = false;
  boolean standing = false;
  boolean collided = false;

  float x, y;
  float vx, vy;
  HitBox box;
  Surface standing_on = null;

  int jumpCounter = 0;
  int maxJumps = 2;
  int jumps_to_boost = 15;
  int total_jumps = 0;
  float mult = 1;
  boolean show_boost_message = false;

  Char(int x, int y) {
    this.x = x;
    this.y = y;
    this.image = loadImage("img/char.png");

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
    box = new HitBox(x, y, frames[0].width*0.8f, frames[0].height*0.8f, 20);
  }

  public void draw() {
    if (show_boost_message) {
      fill(color(255, 255, 255, 127));
      textSize(40);
      textAlign(CENTER);
      text("Press *CONTROL* to boost", width/2, height/2);
    }

    fill(255);
    textSize(30);
    textAlign(RIGHT);
    text(str(total_jumps), width - 30, 30);

    imageMode(CENTER);
    if (vx == 0)
      current_frame = 4;

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

    if (millis() - prevTime > frameTime) {
      prevTime = millis();
      next_frame();
    }

    fill(255);
    textSize(30);
    textAlign(RIGHT);
    text(str(total_jumps), width - 30, 30);

    box.draw();
  }

  public void next_frame() {
    current_frame++;
    if (current_frame >= frames.length)
      current_frame = 0;
  }

  public void update() {
    if (mult > 1 && vx != 0)
      mult -= 0.01f;

    float old_x = x;
    float old_y = y;

    vy += gravity;
    standing = check_standing();

    x += vx;
    y += vy;
    box.update(x, y);

    if (standing_on != null) {
      vy = 0;
      y = old_y;
      x += standing_on.vx;
      y += standing_on.vy;
      box.update(x, y);
      jumpCounter = 0;

      float frame_width = this.frames[current_frame].width;
      float surface_width = standing_on.w;
      if (x + frame_width/2 > standing_on.x + surface_width/2 ||
          x - frame_width/2 < standing_on.x - surface_width/2) {
            standing_on = null;
      }
    }

    collided = check_collision();

    if (collided) {
      x = old_x;
      y = old_y;
      box.update(x, y);
    }
  }

  public void move(int _keyCode) {
    switch (_keyCode) {
    // Прыжок
    case 'W':
      if (total_jumps == jumps_to_boost) {
        total_jumps = 0;
        show_boost_message = true;
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

    case CONTROL:
    if (show_boost_message == true) {
      show_boost_message = false;
      mult += 1;
    }
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

  public boolean check_standing() {
    boolean result = false;

    for (Surface surf : surfaces) {
      if (vy > 0 &&
          y + frames[current_frame].height/2 <= surf.y &&
          y + vy + frames[current_frame].height/2 >= surf.y + surf.vy &&
          x < surf.x + surf.w/2 &&
          x > surf.x - surf.w/2) {
        result = true;
        standing_on = surf;
      }
    }
    return result;
  }

  public boolean check_collision() {

    for (Obstacle obs : obstacles) {

      if (obs.box.check_collision(this.box))
        return true;
    }
    return false;
  }
}
class CheetahIsland extends Surface {
  PImage image;
  
  CheetahIsland(float x, float y, float w, float h, float vx, float vy) {
    super(x, y, w, h);
    image = loadImage("img/islandmy.png");
    image.resize(PApplet.parseInt(w), PApplet.parseInt(height * 0.3f));
    this.vx = vx;
    this.vy = vy;
  }
  
  public void draw() {
    imageMode(CENTER);
    image(image, x, y + 80);
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
class Cloud extends Surface {
  PImage image;
  
  Cloud(float x, float y, float w, float h, float vx, float vy) {
    super(x, y, w, h);
    image = loadImage("img/cloud.png");
    image.resize(PApplet.parseInt(w), PApplet.parseInt(height * 0.2f));
    this.vx = vx;
    this.vy = vy;
  }
  
  public void draw() {
    imageMode(CENTER);
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
class FloatingIsland extends Surface implements IMovable {
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
class HitBox {
  float x, y, w, h;
  float offset_y;

  HitBox(float x, float y, float w, float h) {
    this(x, y, w, h, 0);
  }

  HitBox(float x, float y, float w, float h, float offset) {
    this.x = x;
    this.w = w;
    this.h = h;
    this.offset_y = offset;
    this.y = y + offset_y;
  }

  public void update(float x, float y) {
    this.x = x;
    this.y = y + offset_y;
  }

  public boolean check_collision(HitBox box) {
    return(
    (
      (
        ( this.left()>=box.left() && this.left()<=box.right() )||( this.right()>=box.left() && this.right()<=box.right()  )
      ) && (
        ( this.top()>=box.top() && this.top()<=box.bottom() )||( this.bottom()>=box.top() && this.bottom()<=box.bottom() )
      )
    )||(
      (
        ( box.left()>=this.left() && box.left()<=this.right() )||( box.right()>=this.left() && box.right()<=this.right()  )
      ) && (
        ( box.top()>=this.top() && box.top()<=this.bottom() )||( box.bottom()>=this.top() && box.bottom()<=this.bottom() )
      )
    )
    )||(
    (
      (
        ( this.left()>=box.left() && this.left()<=box.right() )||( this.right()>=box.left() && this.right()<=box.right()  )
      ) && (
        ( box.top()>=this.top() && box.top()<=this.bottom() )||( box.bottom()>=this.top() && box.bottom()<=this.bottom() )
      )
    )||(
      (
        ( box.left()>=this.left() && box.left()<=this.right() )||( box.right()>=this.left() && box.right()<=this.right()  )
      ) && (
        ( this.top()>=box.top() && this.top()<=box.bottom() )||( this.bottom()>=box.top() && this.bottom()<=box.bottom() )
      )
    )
  );
  }

  public float right() {
    return x + w/2;
  }

  public float left() {
    return x - w/2;
  }

  public float top() {
    return y - h/2;
  }

  public float bottom() {
    return y + h/2;
  }

  public void draw() {
    rectMode(CENTER);
    noFill();
    stroke(0, 255, 0);
    strokeWeight(3);
    rect(x, y, w, h);
  }
}
class IslandYou extends Surface {
  PImage image;
  
  IslandYou(float x, float y, float w, float h, float vx, float vy) {
    super(x, y, w, h);
    image = loadImage("img/islandYou.png");
    this.vx = vx;
    this.vy = vy;
  }
  
  public void draw() {
    imageMode(CENTER);
    image.resize(PApplet.parseInt(w), PApplet.parseInt(height * 0.3f));
    image(image, x, y + 100);
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
class Monster {
  PImage image;
  int current_frame = 0;
  PImage frames[];
  boolean order_flag = false;
  Surface standing_on = null;
  boolean standing = false;
  boolean collided = false;

  boolean rotated = false;
  float x, y;
  float vx, vy;

  HitBox box;
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
          PApplet.parseInt(j * frame_w), // левый верхний угол кадра (x - координата)
          PApplet.parseInt(i * frame_h), //                          (y - координата)
          PApplet.parseInt(frame_w), // ширина кадра
          PApplet.parseInt(frame_h) // высота кадра
          );
        frames[index].resize(200, 0);
      }
    }

    box = new HitBox(x, y, frames[0].width, frames[0].height);
  }

  public void draw() {

    if (vx == 0) {
      current_frame = 11;
      float text_w = 250;
      float text_h = 80;
      rectMode(CENTER);
      fill(255, 255, 255, 170);
      float rect_x = x;
      float rect_y = y - text_h/2 - frames[current_frame].height/2;
      noStroke();
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

  public void next_frame() {

    current_frame++;
    if (current_frame >= 10)
      current_frame = 0;
  }

  public void update() {
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

    float old_x = x;
    float old_y = y;

    vy += gravity;
    standing = check_standing();

    x += vx;
    y += vy;
    box.update(x, y);

    if (standing_on != null) {
      vy = 0;
      y = old_y;
      x += standing_on.vx;
      y += standing_on.vy;
      box.update(x, y);

      float frame_width = this.frames[current_frame].width;
      float surface_width = standing_on.w;
      if (x + frame_width/2 > standing_on.x + surface_width/2 ||
          x - frame_width/2 < standing_on.x - surface_width/2) {
            standing_on = null;
      }
    }

    collided = check_collision();

    if (collided) {
      x = old_x;
      y = old_y;
      box.update(x, y);
    }
  }

  public boolean check_standing() {
    boolean result = false;

    for (Surface surf : surfaces) {
      if (vy > 0 &&
          y + frames[current_frame].height/2 <= surf.y &&
          y + vy + frames[current_frame].height/2 >= surf.y + surf.vy &&
          x < surf.x + surf.w/2 &&
          x > surf.x - surf.w/2) {
        result = true;
        standing_on = surf;
      }
    }
    return result;
  }

  public boolean check_collision() {

    for (Obstacle obs : obstacles) {

      if (obs.box.check_collision(this.box))
        return true;
    }
    return false;
  }
}
class Obstacle {
  float x, y; // Координаты центра
  float w, h; // Ширина, высота
  HitBox box;

  Obstacle(float x, float y, float w, float h) {
   this.x = x;
   this.y = y;
   this.w = w;
   this.h = h;
   box = new HitBox(x, y, w, h);
  }

  public void draw() {
    rectMode(CENTER);
    fill(255, 0, 0);
    noStroke();
    rect(x, y, w, h);
  }

  public void update() {
    box.update(x, y);
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
class Wall extends Obstacle {
  PImage image;
  Wall(float x, float y, float w, float h) {
    super(x, y, w, h);
    image = loadImage("img/wall.png");
    image.resize(PApplet.parseInt(w), PApplet.parseInt(h));
  }

  public void draw() {
    image(image, x, y);
    box.draw();
  }
}
interface IMovable {
  public void move();
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
