/* @pjs preload="face.svg"; */

PShape icon; 
void setup() {
  size(250, 250);
  noLoop(30);

  icon = loadShape("face.svg");

  background( 255 );
}

void draw() {
  shape(icon, 0, 0, width, height);

  noStroke();
  fill(51, 181, 229, 150); //blue with opacity
  rect(0, 0, getRate()*width, height);
}

