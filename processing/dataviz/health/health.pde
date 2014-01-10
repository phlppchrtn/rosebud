/* @pjs font="armalite_rifle.ttf"; */
/* @pjs preload="tooth.svg"; */

PShape icon;

void setup() {
  size(220, 300);
  frameRate(30);
  smooth();

  icon = loadShape("tooth.svg");
  icon.disableStyle();

  PFont segoe = createFont("armalite_rifle.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}
void draw() {
  background(255s);
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
  text(getLabel(), 110, 100);
}

