float valeur=25;
float valeurMax=100;

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
  PShape icone = loadShape("data/dent.svg");
  icone.disableStyle();
  noStroke();
  fill(getFillColor(valeur));
  shape(icone, 10, 10, 200, 280);
  fill(255);
  rect(0, 10, 220, 280-280*valeur/valeurMax);
  stroke(85);
  strokeWeight(2);
  noFill();
  shape(icone, 10, 10, 200, 280);
  noStroke();
  fill(getTextColor(valeur));
  text((int)valeur, 110, 100);
}
color getFillColor(float valeur){
  if (valeur/valeurMax <0.25) {
    return color(217, 59, 72);
  }else{
    return  color(51, 181, 229);
  }
}

color getTextColor(float valeur){
    return color(80);
}

