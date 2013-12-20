int sHeight=300;
int sWidth=600;
float valeur=50;
float valeurMax=100;

void setup() {
  size(sWidth, sHeight);
  frameRate(30);
  background( 255 );
  smooth();
}
void draw() {
  background(255);
  PShape icone;
  icone= loadShape("data/car.svg");
  shape(icone, 0, 0, sWidth/2, sHeight);
  icone= loadShape("data/car_blue.svg");
  float valeur = getValue();
  shape(icone, sWidth/2+(sWidth-valeur/valeurMax*sWidth)/4, (sHeight-valeur/valeurMax*sHeight)/2, valeur/valeurMax*sWidth/2, valeur/valeurMax*sHeight);
}

