int mode = 0;
void setup() {
  size(400, 400);
  smooth();
  background(255);
  frameRate(10);
}

void draw() {
  pushMatrix();
  translate(random(0, width), random(0, height));
  rotate(random(-PI/2, PI/2));
  scale(random(0.5, 4));

  if (mode == 0) {
    drawCircle();
  }
  else if (mode == 1) {
    drawWord();
  }
  else if (mode == 2) {
    drawMan();
  }
  popMatrix();
}  

void mouseClicked() {
  mode = (mode+1) %3;
}

void drawCircle() {
  noStroke();
  fill(random(0, 255), random(0, 255), random(0, 255), 100);
  ellipse(0, 0, 20, 20);
}

void drawWord() {
  PFont fontA = loadFont("CourierNew36.vlw");
  textFont(fontA, 36);
  fill(random(0, 255), random(0, 255), random(0, 255), 100);
  text("word", 15, 50);
}


void drawMan() {
  stroke(random(0, 255), random(0, 255), random(0, 255), 100);
  strokeWeight(10);
  strokeCap(ROUND);
  //  strokeJoin(ROUND);
  line (0, 100, 20, 70);
  line (40, 100, 20, 70);
  line (20, 70, 20, 45);
  line (0, 60, 40, 60);
  line (20, 70, 20, 45);
  ellipseMode(CENTER);
  ellipse(20, 45, 5, 5);
}  

