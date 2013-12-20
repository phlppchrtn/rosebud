int sHeight=400;
int sWidth=600;
float a=55;
float b=30;
float valeurMax=100;

void setup() {
  size(sWidth, sHeight);
  frameRate(30);
  background( 255 );
  stroke(0);
}

void draw() {
  float valeur = getValue();
  float x=0;
  float y=0; 
  PShape icone = loadShape("data/man_blue.svg");
  
  for (int i = 1; i <= valeurMax; i = i+1) {
    if (i==valeur+1) {
     icone= loadShape("data/man_gray.svg");
    }
    if (x+b>sWidth) {
      y=y+a; 
      x=0;
    }
  //  shape(icone, x, y, 8*b/9, 8*a/9);
    icone.disableStyle();
    noStroke();
    color fillColor ;
    if (i <=valeur) {
       fillColor = getFillColor(valeur);
    }else{
      fillColor = color(80);
    }
    fill(fillColor);
    shape(icone, x, y, 8*b/9, 8*a/9);
    
    
    x=x+b;
    
    
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
