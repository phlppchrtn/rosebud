float valeur=50;
float valeurMax=1;

/* @pjs preload="car.svg"; */
/* @pjs preload="car_blue.svg"; */

void setup() {
  size(300, 600);
  frameRate(30);
  background( 255 );
  smooth();
}
void draw() {
  background(255);
  PShape icone = loadShape("car.svg");
  shape(icone, 0, 0, width/2, height);
  icone= loadShape("car_blue.svg");
  float rate = getValue()/valeurMax;
  shape(icone, width/2+(width-rate*width)/4, (height-rate*height)/2, rate*width/2, rate*height);
}

