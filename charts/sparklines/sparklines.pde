private float[] data;
private float midvalue; 
private float delta;
float max = Float.NaN;
float min = Float.NaN;
private int count = 66;

void setup() {
  size(400, 400);
  smooth();
  noLoop();

  //  scale(1,-1.2);
  initData();  
  calc();
}

private void initData() {
  data = new float[count];
  for (int i = 0; i<count; i++) {
    data [i] =15 + random(0, 20);
  }
}  

private void calc() {
  float total = 0;
  float totalOfSquares = 0; 

  for (int i = 0; i < data.length; i++) {
    min = min(min, data[i]);
    max = max(max, data[i]);
    total += data[i];
    totalOfSquares += sq(data[i]);
  }
  midvalue = total/count;
  delta = sqrt((totalOfSquares - sq(total)/count)/(count - 1));
}

public void draw() {
  background(255, 255, 255);
  noStroke();
  fill(212);
  //rect (0, height - ratio*(midvalue+delta), width, 2*ratio*delta);
  //bar();
  final float yratio = 0.80f*height / max;
  final float xratio = width /data.length;
  translate(0, height*0.9);
  scale(1, -1);
  //  scale(xratio, yratio);

  //  bar(xratio, yratio);
  //  line(xratio, yratio, true);
  noStroke();
  //stroke(204, 102, 0);
  //strokeWeight(2);
  //  fill(155, 60, 60);
  //  fill(#C1DBF5);
  fill(#E3ECF5);
  line(xratio, yratio, true);

  stroke(#316DA7);
  stroke(#81ADD8);
  noFill();
  strokeWeight(3);
  strokeCap(ROUND);
  strokeJoin(ROUND);
  line(xratio, yratio, false);

  // bar(xratio, yratio);

  strokeWeight(1);
  stroke (50, 50, 185);

  /*  fill(#CCCCCC);
   rect (0.5*xratio, height - yratio * (midvalue-delta), (data.length - 1)*xratio, height - yratio * (midvalue+delta));
   */
  // line (0.5*xratio, height - yratio * midvalue, (data.length - 1)*xratio, height - yratio*midvalue);
  stroke(#CCCCCC);
  strokeWeight(1);
  line (0, 0, data.length*xratio, 0);
}

private void bar(float xratio, float yratio) {
  //  fill(155, 60, 60);
  for (int i = 0; i < data.length; i++) {
    rect((0.05 + i)*xratio, 0, (0.90)*xratio, data[i]*yratio);
  }
}

private void line(float xratio, float yratio, boolean fill) {
  int lastIdx = data.length -1;
  beginShape();
  if (fill) {
    vertex((0.5)*xratio, 0);
    vertex(0.5 *xratio, data[0]*yratio);
  }
  /*curve*/  vertex(0.5 *xratio, data[0]*yratio);
  for (int i = 0; i < data.length; i++) {
    // ellipse((0.5 + i)*xratio, data[i]*yratio, 3, 3);
    /*curve*/    vertex((0.5 + i)*xratio, data[i]*yratio);
  }
  /*curve*/  vertex((0.5 + lastIdx)*xratio, data[lastIdx]*yratio);
  if (fill) {
    vertex((0.5 + lastIdx)*xratio, data[lastIdx]*yratio);
    vertex((0.5+ lastIdx)*xratio, 0);
  }  
  endShape();

  stroke(#0266C6);
  for (int i = 0; i < data.length; i++) {
    if (data[i] == min || data[i] == max) {
      ellipse((0.5 + i)*xratio, data[i]*yratio, 3, 3);
    }
  }
  stroke(#ff0000);
  ellipse((0.5)*xratio, data[0]*yratio, 3, 3);
  ellipse((0.5 + lastIdx)*xratio, data[lastIdx]*yratio, 3, 3);
}

