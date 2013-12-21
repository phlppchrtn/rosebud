/* @pjs preload="dent.svg"; */

void setup() {
  size(220, 300);
  frameRate(30);
  smooth();
  PFont segoe = createFont("segoeui.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}
void draw() {
  background( 255 );
  PShape icon = loadShape("dent.svg");
  
  icon.disableStyle();
  noStroke();
  fill(getFillColor());
  shape(icon, 10, 10, 200, 280);

  fill(255);
  rect(0, 10, 220, 280-280*getRate());

  stroke(85);
  strokeWeight(2);
  noFill();
  shape(icon, 10, 10, 200, 280);

  noStroke();
  fill(getTextColor());
  text((int)getValue(), 110, 100);
}


