
final float ATTRACTION_STRENGTH = - 0.7;  
final float ATTRACTION_MIN_DISTANCE = 1;

final float SPRING_STRENGTH = 0.1;
final float SPRING_DAMPING = 0.5;
final float SPRING_REST_LENGTH = 300;

Layer layer = new Layer();

color backgroundColor = color(1, 110, 115);
color shapeColor = color(183, 254, 0);
color draggedColor = color(0, 56, 57);
color selectedShapeColor = #40E0D0;

color slotColor = #DC143C; //red crimson  
color linkColor = #EEEEEE;   
color textColor = #333333;


void setup() {
  size(500, 500);

  layer.addShape("a", "box", "movie", 10, 10);
  layer.addShape("b", "box", "actor", 200, 10);
  layer.addShape("c", "box", "producer", 150, 150);
  layer.addShape("d", "box", "alias", 10, 150);
  layer.addShape("e", "box", "country", 10, 150);

  layer.addLink ("a", "c");
  layer.addLink ("a", "b");
  layer.addLink ("b", "c");
  layer.addLink ("a", "d");
  layer.addLink ("d", "e");

  layer.init();
}


void draw() {
  background(backgroundColor);
  layer.draw();
}



class Slot {
  float x, y;
  float vx, vy;
  Slot(int x, int y, int vx, int vy) {
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
  }
}

void mouseMoved() {
  layer.overShape(mouseX, mouseY);
}

void mousePressed() {
  layer.selectShape(mouseX, mouseY);
}  

void mouseDragged() {
  if (layer.selectedShape != null) {
    //If there is a shape selected, the we can move it
    layer.moveShape(mouseX, mouseY);
  }
}

