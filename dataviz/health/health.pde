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
  float valeur = getValue();
  background( 255 );
  PShape icone = loadShape("dent.svg");
  icone.disableStyle();
  noStroke();
  fill(getFillColor());
  shape(icone, 10, 10, 200, 280);
  fill(255);
  rect(0, 10, 220, 280-280*getRate());
  stroke(85);
  strokeWeight(2);
  noFill();
  shape(icone, 10, 10, 200, 280);
  noStroke();
  fill(getTextColor());
  text((int)getValue(), 110, 100);
}


float valeurMax=100;

float value = 50;
float step = 1;

int getValue() {
  return value;
}
float getRate() {
  return value/valeurMax;
}
color getFillColor() {
  if (value/valeurMax <0.25) {
    return color(217, 59, 72);
  }
  else {
    return  color(51, 181, 229);
  }
}

color getTextColor(float valeur) {
  return color(80);
}

void incValue() {
  //println ("inc"); 
  value = value + step;
}

void decValue() {
  // println ("dec"); 
  value = value - step;
}

