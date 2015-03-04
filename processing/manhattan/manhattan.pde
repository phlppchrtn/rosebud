
final float ATTRACTION_STRENGTH = - 0.7;  
final float ATTRACTION_MIN_DISTANCE = 1;

final float SPRING_STRENGTH = 0.1;
final float SPRING_DAMPING = 0.5;
final float SPRING_REST_LENGTH = 300;

Layer layer;

color backgroundColor = color(1, 110, 115);
color shapeColor = color(183, 254, 0);
color draggedColor = color(0, 56, 57);
color selectedShapeColor = #40E0D0;

color slotColor = #DC143C; //red crimson  
color linkColor = #EEEEEE;   
color textColor = #333333;


void setup() {
  size(500, 500);

  layer = new LayerBuilder()
    .addShape("a", "box", "movie", 10, 10)
      .addShape("b", "box", "actor", 200, 10)
        .addShape("c", "box", "producer", 150, 150)
          .addShape("d", "box", "alias", 10, 150)
            .addShape("e", "box", "country", 10, 150)
              .addLink ("a", "c")
                .addLink ("a", "b")
                  .addLink ("b", "c")
                    .addLink ("a", "d")
                      .addLink ("d", "e")
                        .build();
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
  cursor(HAND);
  layer.selectShape(mouseX, mouseY);
}  

void mouseReleased() {
  cursor(ARROW);
  layer.unselectShape();
}  

void mouseDragged() {
  //If there is a shape selected, the we can move it
  layer.dragShape(mouseX, mouseY);
}

/*void keyPressed() {
 backgroundColor = color(1, 110, 115);
 if (key == CODED) {
 if (keyCode == UP) {
 backgroundColor = color(255, 110, 115);
 } 
 else if (keyCode == DOWN) {
 backgroundColor = color(1, 110,255);
 }
 }
 }*/
