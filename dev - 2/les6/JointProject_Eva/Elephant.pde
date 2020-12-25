class Elephant extends Character {
 

  Elephant(int x, int y) {
    super(x, y);
  }



  void draw() {
    fill(#999966);
    strokeWeight(8);
    ellipse(x,y,50,50);
   stroke(0);  
   fill(#999966);
line(x+18,y-25,x+50,y-50);
line(x+50,y-50,x+50,y+40);
line(x+50,y+40,x+18,y+25);  
line(x-18,y+25,x-50,y+50);
line(x-50,y+50,x-50,y-40);
line(x-50,y-40,x-18,y-25); 
line(x+10,y+10,x+10,y+60); 
line(x+10,y+60,x-20,y+60+40); 
line(x-20,y+100,x-30,y+90);
line(x-30,y+90,x-10,y+60);
line(x-10,y+60,x-10,y+10);
fill(0);
circle(x-11,y-8,5);
circle(x+11,y-8,5);
  }
}
