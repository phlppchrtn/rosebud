float valeur1=50;
float valeur2=70;
float valeurMax=100;

void setup(){
 size(500,150);
 frameRate(30);
 smooth();
  PFont segoe = createFont("segoeui.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}
void draw(){
background( 255 );

PShape icone;
icone= loadShape("data/regle.svg");
shape(icone,0,0,500,150);
noStroke();
fill(255);
rectMode(CENTER);
for (float i=0;i<11;i=i+1){
  rect(22+i/10*448,32,10,40,4,4,4,4);
}
for (float i=0.5;i<10;i=i+1){
  rect(22+i/10*448,22,10,20,4,4,4,4);
}
fill(51, 181, 229);
rectMode(CORNER);
rect(17+valeur1/valeurMax*448,12,448*(valeur2-valeur1)/valeurMax+10,40,4,4,4,4);

text((int)valeur1+"-"+(int)valeur2, 350, 100);
}
