void setup() {
  size(800, 800);
  background(255);
}

void draw() {
  stroke(#0099CC);
  strokeWeight(3);
  for (int i = 0; i < width; i=i+20) {
    float h = 200*sin(i*TWO_PI/width);
    line(i, height/2, i, height/2 + h);
  }
}

