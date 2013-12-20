private float[] data;
private float midvalue; 
private float delta;
void setup() {
  size(400, 400);
  smooth();
  strokeWeight(0);
  //stroke(0, 100);
  noLoop();
  
  data = new float[6];
  data [0] =5;
  data [1] = 15;
  data[2] = 8;
  data[3] = 12;
  data[4] = 19;
  data[5] = 76;
  midvalue = 8;
  delta = 5;
}

    
public void draw() {
  background(255,255,255);
  //      float min = Float.NaN;
  float max = 0;
  for (int i = 0; i < data.length; i++) {
	//          min = min(min, data[i].floatValue());
    max = max(max, data[i]);
  }
  final float ratio = 0.80*height / max;
  final float weight = width /data.length;

  noStroke();
  fill(212);
  rect (0, height - ratio*midvalue-delta, width, 2*delta);
  bar(ratio, weight);
  line(ratio, weight);
  stroke (50,50,185);
  line (0, height - ratio * midvalue, width, height - ratio*midvalue);
}

private void line(float ratio, float weight){
  fill(123);
  stroke(124);
  for (int i = 0; i < data.length; i++) {
    ellipse(weight*(0.25/2+0.4) + i * weight, height - ratio * data[i], 2,2);
  }

  noFill();
  stroke(54);
  beginShape();
  for (int i = 0; i < data.length; i++) {
    vertex(weight*(0.25/2+0.4) + i * weight, height - ratio * data[i]);
  }
  endShape();
}

private void bar(float ratio, float weight){
  fill(155, 60, 60);
  for (int i = 0; i < data.length; i++) {
    rect(weight*0.25/2 + i * weight, height, 0.8*weight, - ratio * data[i]);
  }
}
