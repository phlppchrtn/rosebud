/* @pjs preload="camion.svg"; */ 

void setup() {
  size(500, 300);
  frameRate(30);
  smooth();
  PFont segoe = createFont("segoeui.ttf", 120);
  textFont(segoe, 120);
  textAlign(CENTER, CENTER);
}
void draw() {
  background( 255 );
  PShape icon = loadShape("camion.svg");
  icon.disableStyle();
  noStroke();
  fill(51, 181, 229);
  shape(icon, 10, 10, 480, 280);

  fill(255);
  rect(0, 10, 500, 280-280*valeur/valeurMax);

  stroke(85);
  strokeWeight(2);
  noFill();
  shape(icon, 10, 10, 480, 280);
  noStroke();
  fill(85);
  text((int)valeur, 250, 120);
}

