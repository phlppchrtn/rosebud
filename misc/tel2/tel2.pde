Button[] buttons = new Button[9];
ArrayList snake = new ArrayList();

int mode = 0;
//0 rien 
//1 dragged
//2 OK
//3 Fail
String password= "0124678";

void setup(){
    size( 400, 400 );
    background (#EEEEEE);

    smooth();    
    ellipseMode(CENTER);

    //strokeWeight( 3 );
    int x0 = 100;
    int xi = x0;
    int yi = 100 ; 
    int step = 80;
    String id;
    for (int i = 0 ; i< buttons.length ; i++){
      if (i%3==0){
        yi += step;
        xi = x0;
      }else {
        xi += step;
      }
      id = ""+i;
      buttons[i] = new Button (id, xi, yi, 30);
    }
    printImage();
}

void printImage(){
  PImage img = loadImage("http://3dpower.free.fr/Textures/Ciel/ciel01.jpg");
  image(img, 0, 0);
}

// Main draw loop
void draw(){
  background (#EEEEEE);

  noStroke();
  for (int i = 0 ; i< buttons.length ; i++){
    buttons[i].draw(true);
  } 

  drawSnake();  

  noStroke();
  for (int i = 0 ; i< buttons.length ; i++){
    buttons[i].draw(false);
  } 
}
void drawSnake(){
  strokeWeight(30 );
  stroke(155, 120);
  strokeJoin(ROUND);
  if (snake.size()>1){
    for (int i = 1 ; i< snake.size() ; i++){
      Button b1 = (Button) snake.get(i-1);
      Button b2 = (Button) snake.get(i);
      line (b1.x, b1.y, b2.x, b2.y);
    } 
  }
}

void mouseReleased() {
    if (mode != 1) {
      return;  
    }

  String target =  "";
  for (int i = 0 ; i< snake.size() ; i++){
       target = target + ((Button) snake.get(i)).id;
  }  
   println("target = " +target);

  if (target.equals(password)){
    mode = 2 ; //OK
  } else{
    mode = 3; //fail
  }
}  

  
void mouseDragged(){
  if (mode == 0 || mode == 1 ) {
    mode = 1;
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

 void draw (boolean up){
   color selectedColor; 
   if (pressed && mode == 2){
    selectedColor = #99CC00;  //OK
   }  else if (pressed && mode == 3){
    selectedColor = #FF4444;  //FAIL
   }  else if (pressed){
    selectedColor = #33B5E5; //dragged
   } else{
    selectedColor = #666666; 
   }
   if (up){ 
     fill (selectedColor);
     ellipse (x, y, 2*radius, 2*radius);
  
     fill (#EEEEEE);
     ellipse (x, y, 2*radius - 10, 2*radius - 10);
   }else{
     //centre
     fill (selectedColor);
     ellipse (x, y, 30, 30);
   }
 }
 
}

