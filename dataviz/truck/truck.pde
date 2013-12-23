/* @pjs font="armalite_rifle.ttf"; */
/* @pjs preload="truck.svg"; */

PShape icon;

void setup() {
  size(500, 300); //480+2*10 & 280+2*10
  icon = loadShape("truck.svg");
  noLoop();
  smooth();
  
  PFont font = loadFont("armalite_rifle.ttf", 120);
  textFont(font, 120);
  textAlign(CENTER, CENTER);
}

void draw() {
  translate (10, 10); // up and left margins
  background(255);
 
  //1. displays svg body 
  icon.disableStyle();
  noStroke();
  fill(51, 181, 229); //pretty blue
  shape(icon, 0, 0, 480, 280);

  fill(255);
  rect(0, 0, 480, 280-280*getRate());

  //2. displays svg skin 
  stroke(85);
  strokeWeight(2);
  noFill();
  shape(icon, 0, 0, 480, 280);

  //3. displays the label in the center 
  noStroke();
  fill(85);
  text(getLabel(), 480/2, 280/2);
}

