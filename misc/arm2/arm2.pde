/**
 * Arm. 
 * 
 * The angle of each segment is controlled with the mouseX and
 * mouseY position. The transformations applied to the first segment
 * are also applied to the second segment because they are inside
 * the same pushMatrix() and popMatrix() group.
*/

float angle1 = 0.0;
float angle2 = 0.0;
float segLength = 200;
int count = 5;
float step = 0;

void setup() {
  size(400, 400);
  frameRate(20);
  smooth(); 
  strokeWeight(20.0);
  stroke(0, 100);
}

void draw() {
  background(226);

  angle1 = step * -PI;
  angle2 = step * -PI;
  
  step = step + PI/30;
//  angle1 = (mouseX/float(width) - 0.5) * -PI;
//  angle2 = (mouseY/float(height) - 0.5) * PI;
  
  pushMatrix();
  translate(200, 200);
  for (int i=0; i<count-1;i++){
    stroke(step, step*(i+1), i+1);
    segment(segLength/count, 0, angle1/count);
  }  
  for (int i=0; i<count;i++){
    segment(segLength/count, 0, angle2/count);
  }  
  popMatrix();
}

void segment(float x, float y, float a) {
  translate(x, y);
  rotate(a);
  line(0, 0, segLength/count, 0);
}

