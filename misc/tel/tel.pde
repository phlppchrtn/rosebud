Button[] buttons = new Button[50];
ArrayList snake =  new ArrayList ();

void setup(){
    size( 400, 400 );
    smooth();    
    ellipseMode(CENTER);

    //strokeWeight( 3 );
    int x0 = 100;
    int xi = x0;
    int yi = 100 ; 
    int step = 40;
    String id;
    for (int i = 0 ; i< buttons.length ; i++){
      if (i%10==0){
        yi += step;
        xi = x0;
      }else {
        xi += step;
      }
      id = ""+i;
      buttons[i] = new Button (id, xi, yi, 20);
    }
    printImage();
}

void printImage(){
  PImage img = loadImage("http://3dpower.free.fr/Textures/Ciel/ciel01.jpg");
  image(img, 0, 0);
}

// Main draw loop
void draw(){
  noStroke();
//  smooth();
  fill (255,255,255); 
  //strokeWeight( 3 );
  for (int i = 0 ; i< buttons.length ; i++){
    buttons[i].draw();
  } 
  
  strokeWeight(10 );
  stroke(155);
  strokeJoin(ROUND);
  if (snake.size()>1){
    for (int i = 1 ; i< snake.size() ; i++){
      Button b1 = (Button) snake.get(i-1);
      Button b2 = (Button) snake.get(i);
      line (b1.x, b1.y, b2.x, b2.y);
    } 
  }
  
}
  
// Set circle's next destination
void mouseDragged(){
  for (int i = 0 ; i< buttons.length ; i++){
    if (buttons[i].contains (mouseX, mouseY)){
        println("id = " +buttons[i].id);
      buttons[i].pressed = true;
      if (!snake.contains(buttons[i])){
       snake.add(buttons[i]);
      }
      break;
    }  
  } 
}

class Button {
 String id;
 int x, y; 
 int radius;
 boolean pressed = false;
 
 Button (String id, int x, int y, int radius){
   this.id = id;
   this.x = x;
   this.y = y;
   this.radius = radius;
 }
  
 boolean contains(int _x, int _y){
    return (x>= _x - radius) && (x<= _x + radius) &&  (y>= _y - radius) && (y<= _y + radius); 
 } 

 void draw (){
   if (pressed){
     drawPressed();
//     fill (0,0,255);
   } else{
     fill (255,255,255);
   }
   ellipse (x, y, 2*radius, 2*radius);
 }
 
 void drawPressed (){
  float r1 = random(255);
  float g1 = random(255);
  float b1 = random(255);
  float dr = (random(255) - r1) / radius;
  float dg = (random(255) - g1) / radius;
  float db = (random(255) - b1) / radius;
  
  for (int r = radius; r > 0; --r) {
    fill(r1, g1, b1);
    ellipse(x, y, r, r);
    r1 += dr;
    g1 += dg;
    b1 += db;
  }
 }
}


