float valeurMax = 100;
boolean mode;
PImage bg;

void setup() {
  smooth(); 
  size(610, 458);
  loop();
//  noloop();
  frameRate(20);
 // PFont segoe = createFont("segoeui.ttf", 80);
  //textFont(segoe, 80);
  textAlign(CENTER, CENTER);
  bg = loadImage("watercolor-paper.jpg");
}

void keyPressed() {
  mode = !mode;
}


void mouseClicked(){
  if ( mouseX > width/2) {
 //   incValue();
  }
  if ( mouseX < width/2) {
 //   decValue();
  }
}

void draw() {
  int xoffset = 5* (mouseX - width/2)/width;
  int yoffset = 5* (mouseY - height/2)/height;
  float valeur = 45;
  background( bg );

  strokeWeight( 4 );
  stroke(85); 
  noFill();
  ellipse(125, 125, 150, 150);

  translate (5,5);
  stroke(#cccccc);
  drawDonut(valeur, mode);

  translate (-5, -5);
  stroke(getFillColor(valeur));
  drawDonut(valeur, mode);
 }

void drawDonut(float valeur, boolean split){
   strokeWeight( 16 );
    arc(125, 125, 150, 150, -PI/2, -PI/2+(valeur/valeurMax)*2*PI);
}

color getFillColor(float valeur){
    return  color(51, 181, 229);
}


