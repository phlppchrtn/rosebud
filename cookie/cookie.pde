float valueMax=100;

void setup() {
  size(500, 300);
 // noLoop();
  smooth();
  PFont segoe = createFont("segoeui.ttf", 120);
  textFont(segoe, 120);
  textAlign(CENTER, CENTER);
}
void draw() {
  float value=getValue();
  background( 255 );
  PShape icon= loadShape("truck.svg");
  icon.disableStyle();

  noStroke();
  fill(getFillColor(value));
  shape(icon, 10, 10, 480, 280);
  fill(255);
  rect(0, 10, 500, 280-280*value/valueMax);
  stroke(85);
  strokeWeight(2);
  noFill();
  shape(icon, 10, 10, 480, 280);
  noStroke();
  fill(getTextColor(value));
  text((int)value, 250, 120);

  fill(112, 112, 112, 45);
  if (step<0){
    rect(0,0, 50, height);
  }
  if (step>0){
    rect(width-50, 0, width,height);
  }
}
color getFillColor(float value){
  if (value/valueMax <0.25) {
    return color(217, 59, 72);
  }else{
    return  color(51, 181, 229);
  }
}

color getTextColor(float value){
    return color(80);
}

float step = 0;

void mousePressed(){
  value = value+step;
  if (value<0) value =0;
  if (value>100) value =100;
}


void mouseMoved(){
  if (mouseX <50){
    step= -1;
  }else if ((width - mouseX) <50){
    step= 1;
  } else{
    step= 0;
  }  
}

void incValue() {
  //println ("inc"); 
  value = value + step;
}

void decValue() {
  // println ("dec"); 
  value = value - step;
}
float value = 50;

float getValue() {
  return value;
}


