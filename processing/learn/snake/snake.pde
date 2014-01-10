boolean playing;
int dir = RIGHT;
int x=50, y=50;
int i = 0;

void setup() {
  size(800, 800);
  background(255, 255, 255);
  noStroke();
  playing = true;
}

void draw() {
  if (playing) {
    switch (dir) {
    case UP:
      y = y -5;
      break;
    case DOWN:
      y = y +5;
      break;
    case RIGHT:
      x = x + 5;
      break;
    case LEFT:  
      x = x - 5;
      break;
    } 
    //---
    if (y<0 || y> height || x<0 || x> width) {
      playing = false;
    }
    loadPixels();
    if (red(pixels[y*width + x]) == 192) {
      playing = false;
    }  
    //---
    if (playing) {
      fill(192, 0, 0);
      rect(x, y, 4, 4);
    } else{
      rectMode(CENTER);
      rect(width/2, height/2, 200, 100);  
      fill(255,255,255);
      textSize(32);
      textAlign(CENTER);
      text("PERDU ", width/2, height/2);  
    }
  }
}

void keyPressed() {
  if (playing && key == CODED ) {
    if (keyCode == RIGHT || keyCode == DOWN || keyCode == LEFT ||keyCode == UP) {
      dir = keyCode;
    }
  }
}



