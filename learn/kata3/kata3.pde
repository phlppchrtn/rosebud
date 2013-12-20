void setup() {
  size(800, 800);
  background(255);
}

void draw() {
  noStroke();
  fill(255, 45);
  rect(0, 0, width, height);
  //---
  strokeWeight(5);
  stroke(#0099CC);
  fill(#CC0000);
  rect (mouseX, mouseY, 200, 100);
}

