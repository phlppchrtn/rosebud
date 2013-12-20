int sHeight=400;
int sWidth=600;
float a=55;
float b=30;
float valeur=50;
float valeurMax=100;

/* @pjs preload="man_gray.svg"; */
/* @pjs preload="man_blue.svg"; */

void setup(){
 size(400,600);
 frameRate(30);
 background( 255 );
 stroke(0);
}

void draw(){
PShape icone;
icone= loadShape("man_blue.svg");
float x=0;
float y=0; 
for (int i = 1; i <= valeurMax; i = i+1){
  if (i==valeur+1) {icone= loadShape("man_gray.svg");}
  if (x+b>sWidth) {y=y+a; x=0;}
 shape(icone,x,y,8*b/9,8*a/9);
  x=x+b;
}
}
