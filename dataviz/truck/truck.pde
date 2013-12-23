/* @pjs font="armalite_rifle.ttf"; */
/* @pjs preload="truck.svg"; */

PShape icon;

void setup() {
  size(500, 300); //480+2*10 & 280+2*10
  noLoop();
  smooth();
  
  icon = loadShape("truck.svg");
  icon.disableStyle();
  
  PFont font = loadFont("armalite_rifle.ttf", 120);
  textFont(font, 120);
  textAlign(CENTER, CENTER);

  background(255);
}

void draw() {
  translate (10, 10); // up and left margins
   //1. displays all svg body with a nice blue
  noStroke();
  fill(51, 181, 229); //nice blue
  shape(icon, 0, 0, 480, 280);

 //3. clears proportionally to the rate
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

