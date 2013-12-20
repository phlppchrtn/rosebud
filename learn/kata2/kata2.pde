void setup() {
  size(800, 800);
  background(255);
}

void draw() {
  strokeWeight(1);  
  stroke(125);
  fill(125);
  line(0, 0, width, height);	
  line(width, 0, 0, height);  
  //---
  strokeWeight(5);
  stroke(#0099CC);
  fill(#CC0000);
  rectMode(CENTER);
  rect (width/2, height/2, 200, 100);
  //---
  fill(255, 150);
  ellipse(width/2, height/2, 400, 400);
}

