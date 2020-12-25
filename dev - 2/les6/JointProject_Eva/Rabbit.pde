class Rabbit extends Character {
 

  Rabbit(int x, int y) {
    super(x, y);
  }

void keyPressed(){
if (key == 'w') {
   y-=vy;
    }
    if (key == 's') {
   y+=vy;
    }
    if (key == 'a') {
   x-=vx;
    }
    if (key == 'd') {
   x+=vx;
    }
}
    void update() {
      
      if(key=='q')keyPressed();
      else if (key =='z'){
    int flag = int(random(100));
    if (flag % 100 < 5) {
      vx = random(-5, 5);
      vy = random(-5, 5);
    }
    x += vx;
    y += vy;
    
    float top = grid.getTop(i, j);
    float bottom = grid.getBottom(i, j);
    float right = grid.getRight(i, j);
    float left = grid.getLeft(i, j);
    
    if (x > right)
      x = right;
    else if (x < left)
      x = left;
      
    if (y > bottom)
      y = bottom;
    else if (y < top)
      y = top;
      

      
}
    }

  void draw() {
    fill(255);
    strokeWeight(8);
    ellipse(x,y,20,100);
    ellipse(x+30,y,20,100);
    ellipse(x+15,y+25,60,60);


  }
}
