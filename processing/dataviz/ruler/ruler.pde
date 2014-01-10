float valeurMax=100;

/* @pjs preload="ruler.svg"; */

void setup() {
  size(500, 500);
  frameRate(30);
  smooth();
  PFont segoe = createFont("segoeui.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}
void draw() {
  float valeur = getValue();
  background( 255 );

  PShape icone;
  icone= loadShape("ruler.svg");

  shape(icone, 0, 0, 500, 200);
  noStroke();
  fill(255);
  rectMode(CENTER);
  for (float i=0;i<11;i=i+1) {
    rect(22+i/10*448, 32, 10, 40, 4, 4, 4, 4);
  }
  for (float i=0.5;i<10;i=i+1) {
    rect(22+i/10*448, 22, 10, 20, 4, 4, 4, 4);
  }
  fill(51, 181, 229);

  rect(22+valeur/valeurMax*448, 32, 10, 40, 4, 4, 4, 4);
  text((int)valeur, 400, 100);
}

