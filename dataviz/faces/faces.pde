/* @pjs preload="face.svg"; */ 

void setup() {
  size(250, 250);
  frameRate(30);
}
void draw() {
  background( 255 );
  PShape icon = loadShape("face.svg");
  shape(icon, 0, 0,width, height);
 
  noStroke();
  fill(51, 181, 229, 150);
  rect(0, 0, getRate()*width, height);
}



