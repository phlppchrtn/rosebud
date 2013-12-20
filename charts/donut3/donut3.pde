float valeur1 = 50;
float valeur2 = 70;
float valeurMax = 100;

void setup() {
  smooth(); 
  size(250, 250);
  frameRate(30);
  PFont segoe;
  segoe = createFont("segoeui.ttf", 44);
  textFont(segoe, 44);
  textAlign(CENTER, CENTER);
}

void draw() {
  background( 255 );
  fill( 255 );
  stroke(85); 
  strokeWeight( 4 );
  ellipse(125, 125, 150, 150);
  strokeWeight( 16 );
  stroke(51, 181, 229);
  arc(125, 125, 150, 150, -PI/2+(valeur1/valeurMax)*2*PI, -PI/2+(valeur2/valeurMax)*2*PI);
  strokeWeight( 10 );
  fill(51, 181, 229);
  text((int)valeur1+"-"+(int)valeur2, 125, 125);
}

