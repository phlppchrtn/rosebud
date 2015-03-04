class Layer {
  ParticleSystem particleSystem = new ParticleSystem();

  HashMap<String, Integer> ids = new HashMap<String, Integer>();
  ArrayList<Particle> particles = new  ArrayList<Particle>();
  ArrayList<Shape> shapes = new ArrayList<Shape>();
//  ArrayList<Position> positions  = new ArrayList<Position>();
  //-----
  ArrayList<Link> links  = new ArrayList<Link>();

  Shape overShape;
  //-----
  Shape selectedShape;
  int selectMouseX, selectMouseY; 
  int selectIndex;
  //-----

  void moveShape(int x, int y) {
    Position position =selectedShape.getPosition();

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
    for (int i=0; i< shapes.size (); i++) {
      if (shapes.get(i).inside(x, y)) {
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

  void addShape(String id, String shapeType, String label, float x, float y) {
    Shape shape;
    if ("box".equals(shapeType)) {
      shape = new Box(new Position(x, y), 100, 100, label);
    }
    else {
      throw new RuntimeException ("Unknown shape type "+ shapeType);
    }
    ids.put(id, ids.size());
    shapes.add(shape);
    //-----
    Particle particle =  particleSystem.makeParticle();
    particle.position.set(x, y, 0);
    particles.add(particle);
  }

  Slot getSlot1(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);
    Position position1 = shapes.get(i1).getPosition();
    Position position2 = shapes.get(i2).getPosition();

    Shape shape = shapes.get(i1);
    return shape.findSlot(-position1.x + position2.x, - position1.y + position2.y);
  }

  Slot getSlot2(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);
    Position position1 = shapes.get(i1).getPosition();
    Position position2 = shapes.get(i2).getPosition();

    Shape shape = shapes.get(i2);
    return shape.findSlot(position1.x - position2.x, position1.y - position2.y);
  }

  void rebuildCoordinatesFromSystem() {
    for (int i = 0; i<particles.size(); i++) {  
      shapes.get(i).getPosition().x = particles.get(i).position.x;
      shapes.get(i).getPosition().y = particles.get(i).position.y;
    }
  }
  void rebuildCoordinatesFromShapes() {
    for (int i = 0; i<particles.size(); i++) {  
      Position position = shapes.get(i).getPosition(); 
      particles.get(i).position.set(position.x, position.y, 0);
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
      Position position1 = shapes.get(i1).getPosition();
      Position position2 = shapes.get(i2).getPosition();
      bezier (position1.x + slot1.x, position1.y + slot1.y, position1.x + slot1.x + slot1.vx, position1.y + slot1.y + slot1.vy, 
      position2.x + slot2.x + slot2.vx, position2.y + slot2.y + slot2.vy, position2.x + slot2.x, position2.y + slot2.y );        

      noStroke();
      fill(slotColor);
      ellipse(position1.x + slot1.x, position1.y + slot1.y, 10, 10);
      ellipse(position2.x + slot2.x, position2.y + slot2.y, 10, 10);
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
      shapes.get(i).draw();
    }
  }
}

