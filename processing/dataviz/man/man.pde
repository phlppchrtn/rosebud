/* @pjs preload="man.svg"; */

PShape icon;

void setup() {
  size(400, 600);

  icon = loadShape("man.svg");
  icon.disableStyle();

  frameRate(30);
  background(255);
  noStroke();
}

void draw() {
  float iconWidth = 0.05*width ; //20 men per line
  float iconHeight = 0.05*width * icon.height/icon.width;

  float x=0;
  float y=0; 
  for (int i = 0; i < 100; i++) {
    fill(getColor(i+1));
    shape(icon, x, y, 0.9*iconWidth, 0.9*iconHeight);
    x = x + iconWidth; 
    if (x > (width -iconWidth)) {
      x=0;
      y=y+iconHeight; 
    }
  }
}

