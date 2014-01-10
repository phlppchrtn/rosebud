float valeurMax = 100;
boolean mode;
void setup() {
  smooth(); 
  size(250, 250);
  loop();
  frameRate(60);
  PFont segoe = createFont("segoeui.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}

void keyPressed() {
  mode = !mode;
}


void mouseClicked(){
  if ( mouseX > width/2) {
    incValue();
  }
  if ( mouseX < width/2) {
    decValue();
  }
}

void draw() {
  float valeur = getValue();
  background( 255 );
  fill( 255 );
 
  strokeWeight( 4 );
  stroke(85); 
  ellipse(125, 125, 150, 150);
 
  drawDonut(valeur, mode);

  strokeWeight( 10 );
  fill(getTextColor(valeur));
  text((int)valeur, 125, 125);
}

void drawDonut(float valeur, boolean split){
 if(split){
   drawSplitDonut(valeur);
 }else{
   drawFullDonut(valeur);
 }
}  
  

void drawFullDonut(float valeur){
  strokeWeight( 16 );
  stroke(getFillColor(valeur));
  arc(125, 125, 150, 150, -PI/2, -PI/2+(valeur/valeurMax)*2*PI);
}

void drawSplitDonut(float valeur){
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
}

color getFillColor(float valeur){
  if (valeur/valeurMax <0.25) {
    return color(217, 59, 72);
  }else{
    return  color(51, 181, 229);
  }
}

color getTextColor(float valeur){
    return color(80);
}
