class Layer {
  ParticleSystem particleSystem = new ParticleSystem();

  HashMap<String, Integer> ids = new HashMap<String, Integer>();
  ArrayList<Particle> particles = new  ArrayList<Particle>();
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  //-----
  ArrayList<Link> links  = new ArrayList<Link>();

  Shape overShape;
  //-----
  Shape selectedShape;
  int selectMouseX, selectMouseY; 
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

    Shape shape1 = shapes.get(i1);
    Shape shape2 = shapes.get(i2);
    
    return shape1.findSlot(shape2);
  }

  Slot getSlot2(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);

    Shape shape1 = shapes.get(i1);
    Shape shape2 = shapes.get(i2);
    
    return shape2.findSlot(shape1);
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
    for (Link link : links){
      int i1 = ids.get(link.id1);
      int i2 = ids.get(link.id2);

      Slot slot1= getSlot1(link);
      Slot slot2= getSlot2(link);

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

