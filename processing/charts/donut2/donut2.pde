float valeur = 25;
float valeurMax = 100;

void setup() {
  smooth(); 
  size(250, 250);
  frameRate(30);
  PFont segoe = createFont("segoeui.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}

void draw() {
  background( 255 );
  fill( 255 );
  stroke(85); 
  strokeWeight( 4 );
  ellipse(125, 125, 150, 150);
  strokeWeight( 4 );
  fill(51, 181, 229);
  stroke(51, 181, 229);
  //arc(125, 125, 150, 150, -PI/2, -PI/2+(valeur/valeurMax)*2*PI);
  ellipseMode(CENTER);
  float a=-PI/2;
  int b=(int)(((valeur/valeurMax)*2*PI)/(PI/11));
  for(int i=0; i<b+1; i=i+1) {
	ellipse(125+75*cos(a),125+75*sin(a),14,14);
	a=a+PI/11;

  }
  text((int)valeur, 125, 125);
 

}

