// Code from Visualizing Data, First Edition, Copyright 2008 Ben Fry.
// Based on the GraphLayout example by Sun Microsystems.

static final color boxColor   = #F0C070;
static final color marginColor   = #000070;

PFont font;
private  HContainer container;

void setup() {
  size(600, 600);  
  loadData();
 // noLoop();
}



void loadData() {
  container = new HContainer();
  //
  Box box; 
  box = new Box (100, 50);
  container.addWidget(box);
  //
  box = new Box (150, 60);
  container.addWidget(box);

//  font =createFont("SansSerif", 10);
//  textFont(font, 32);
}

void draw() {
  container.draw();
}


void keyPressed() {
  if (key == 'a') {
    container.addWidget(new Box(100, 50));
  }
}


