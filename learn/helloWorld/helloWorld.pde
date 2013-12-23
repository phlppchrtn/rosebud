void setup() {
  //taille de la zone de dessin
  size(400, 300);
}

int x = 0;
int y = 0;
int xIncr = 1;
int yIncr = 1;

void draw() {
  background(0, 0, 0); //noir  
  fill(x%255, y%255, (x*y)%255);
  textSize(18);
  text("Hello World", x, y);


  if (x >= width) {
    xIncr = -1;
  } 
  else if (x <= 0) {
    xIncr = 1;
  }
  if (y >= height) {
    yIncr = -1;
  } 
  else if (y <= 0) {
    yIncr = 1;
  }
  x = x + xIncr;
  y = y + yIncr;
}


