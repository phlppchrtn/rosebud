
final float ATTRACTION_STRENGTH =  -10;  
final float ATTRACTION_MIN_DISTANCE = 10;

final float SPRING_STRENGTH = 0.4;
final float SPRING_DAMPING = 0.4;
final float SPRING_REST_LENGTH = 50;

Layer layer;

color backgroundColor = color(1, 110, 115);
color shapeColor = color(183, 254, 0);
color draggedColor = color(0, 56, 57);
color selectedShapeColor = #40E0D0;

color slotColor = #DC143C; //red crimson  
color linkColor = #EEEEEE;   
color textColor = #333333;


void setup() {
  size(800, 800);

  LayerBuilder layerBuilder = new LayerBuilder();
  
  JSONArray dtDefinitions  = loadJSONArray("http://localhost:8080/vertigo/dtdefinitions");
  for (int i = 0; i < dtDefinitions.size(); i++) {
    JSONObject dtDefinition = dtDefinitions.getJSONObject(i); 
    String name = dtDefinition.getString("name");
    println (name);
    layerBuilder.addShape(name, "box", name, 10+ 10*i, 10+ 10*i);
  }
  JSONArray associations  = loadJSONArray("http://localhost:8080/vertigo/associations");
  for (int i = 0; i < associations.size(); i++) {
    JSONObject association = associations.getJSONObject(i); 
    String nodeA = association.getJSONObject("associationNodeA").getString("dtDefinitionRef");
    String nodeB = association.getJSONObject("associationNodeB").getString("dtDefinitionRef");
    println(nodeA+ " --- "+ nodeB);
    layerBuilder.addLink(nodeA, nodeB);
  }
  
  JSONArray tasks  = loadJSONArray("http://localhost:8080/vertigo/tasks");
  for (int i = 0; i < tasks.size(); i++) {
    JSONObject task = tasks.getJSONObject(i);
    String name = task.getString("name");
    layerBuilder.addShape(name, "box", name, 12+ 12*i, 12+ 12*i);
  }
  
  JSONArray links  = loadJSONArray("http://localhost:8080/vertigo/taskattributess");
  for (int i = 0; i < links.size(); i++) {
    JSONObject link = links.getJSONObject(i); 
    String nodeA = link.getJSONObject("dtDefinition").getString("name");
    String nodeB = link.getJSONObject("taskDefinition").getString("name");
    println(nodeA+ " -+- "+ nodeB);
    layerBuilder.addLink(nodeA, nodeB);
  }
  
  layer = layerBuilder.build();

  /* layer = new LayerBuilder()
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
   .build();*/
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

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      layer.zoomOut();
    } 
    else if (keyCode == DOWN) {
      layer.zoomIn();
    }
  }
}

