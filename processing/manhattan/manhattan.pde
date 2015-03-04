
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

class Link {
  String id1;
  String id2;
  Link(String id1, String id2) {
    this.id1 = id1;
    this.id2 = id2;
  }
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

class Layer {
  ParticleSystem particleSystem = new ParticleSystem();

  HashMap<String, Integer> ids = new HashMap<String, Integer>();
  ArrayList<Particle> particles = new  ArrayList<Particle>();
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  ArrayList<Position> positions  = new ArrayList<Position>();
  //-----
  ArrayList<Link> links  = new ArrayList<Link>();

  Shape overShape;
  //-----
  Shape selectedShape;
  int selectMouseX, selectMouseY; 
  int selectIndex;
  //-----

  void moveShape(int x, int y) {
    Position position = positions.get(selectIndex);

    position.x += x-selectMouseX;
    position.y += y-selectMouseY;
    selectMouseX = x; 
    selectMouseY = y;
    rebuildCoordinatesFromShapes();
  }

  void overShape (int x, int y) {
    overShape  = find(x, y);
  }  

  void selectShape (int x, int y) {
    selectedShape = find(x, y);
    if (selectedShape != null) {
      selectMouseX = x;
      selectMouseY = y;
      selectIndex = shapes.indexOf(selectedShape);
    }
  }  

  Shape  find (float x, float y) {
    for (int i=0; i< positions.size (); i++) {
      if (shapes.get(i).inside(x - positions.get(i).x, y- positions.get(i).y)) {
        return shapes.get(i);
      }
    }
    return null;
  }

  void addLink(String id1, String id2) {
    links.add(new Link(id1, id2));
    //-----
    Particle a = particles.get(ids.get(id1));
    Particle b = particles.get(ids.get(id2));
    particleSystem.makeAttraction(a, b, -ATTRACTION_STRENGTH, ATTRACTION_MIN_DISTANCE );
  }

  float xx = 10;
  float  yy = 10;

  void addShape(String id, String shapeType, String label, float xj, float yj) {
    float x = xx++;
    float y = yy++;
    Shape shape;
    if ("box".equals(shapeType)) {
      shape = new Box(100, 100, label);
    }
    else {
      throw new RuntimeException ("Unknown shape type "+ shapeType);
    }
    ids.put(id, ids.size());
    shapes.add(shape);
    positions.add(new Position(x, y));
    //-----
    Particle particle =  particleSystem.makeParticle();
    particle.position.set(x, y, 0);
    particles.add(particle);
  }

  Slot getSlot1(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);
    Position position1 = positions.get(i1);
    Position position2 = positions.get(i2);

    Shape shape = shapes.get(i1);
    return shape.findSlot(-position1.x + position2.x, - position1.y + position2.y);
  }

  Slot getSlot2(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);
    Position position1 = positions.get(i1);
    Position position2 = positions.get(i2);

    Shape shape = shapes.get(i2);
    return shape.findSlot(position1.x - position2.x, position1.y - position2.y);
  }

  void rebuildCoordinatesFromSystem() {
    for (int i = 0; i<particles.size(); i++) {  
      positions.get(i).x = particles.get(i).position.x;
      positions.get(i).y = particles.get(i).position.y;
    }
  }
  void rebuildCoordinatesFromShapes() {
    for (int i = 0; i<particles.size(); i++) {  
      particles.get(i).position.set(positions.get(i).x, positions.get(i).y, 0);
    }
  }

  void init() {
    for (int i=0; i<particles.size(); i++) { 
      Particle a = particles.get(i);
      for (int j = i+1 ; j<particles.size(); j++) {
        Particle b = particles.get(j);
        particleSystem.makeSpring(a, b, SPRING_STRENGTH, SPRING_DAMPING, SPRING_REST_LENGTH);
      }
    }
  }
  void draw() {
    particleSystem.tick();
    rebuildCoordinatesFromSystem();
    for (int i=0; i< links.size (); i++) {
      Link link = links.get(i);
      int i1 = ids.get(link.id1);
      int i2 = ids.get(link.id2);

      Slot slot1= getSlot1(links.get(i));
      Slot slot2= getSlot2(links.get(i));

      stroke(linkColor);
      strokeWeight(2);
      noFill();
      bezier (positions.get(i1).x + slot1.x, positions.get(i1).y + slot1.y, positions.get(i1).x + slot1.x + slot1.vx, positions.get(i1).y + slot1.y + slot1.vy, 
      positions.get(i2).x + slot2.x + slot2.vx, positions.get(i2).y + slot2.y + slot2.vy, positions.get(i2).x + slot2.x, positions.get(i2).y + slot2.y );        

      noStroke();
      fill(slotColor);
      ellipse(positions.get(i1).x + slot1.x, positions.get(i1).y + slot1.y, 10, 10);
      ellipse(positions.get(i2).x + slot2.x, positions.get(i2).y + slot2.y, 10, 10);
    }    

    for (int i=0; i< shapes.size (); i++) {
      if (selectedShape == shapes.get(i)) {
        fill(selectedShapeColor);
      }      
      else {
        fill(shapeColor);
      }
      //-----  
      if (overShape == shapes.get(i)) {
        strokeWeight(5);
        stroke(draggedColor);
      }
      else {
        noStroke();
      }
      //-----
      shapes.get(i).draw(positions.get(i));
    }
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

