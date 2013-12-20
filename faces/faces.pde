int sHeight=250;
int sWidth=250;
float valeurMax=100;

void setup() {
  size(sWidth, sHeight);
  frameRate(30);
}
void draw() {
  background( 255 );
  PShape icone = loadShape("data/face.svg");
  shape(icone, 0, 0, sWidth, sHeight);
  noStroke();
  fill(51, 181, 229, 150);
  rect(0, 0, getValue()/valeurMax*sWidth, sHeight);
}

