class Layer {
  private final ParticleSystem particleSystem;
  private final ArrayList<Shape> shapes;
  private final ArrayList<Link> links;

  private Shape highlightedShape;
  //-----
  private Shape selectedShape;
  private int selectMouseX, selectMouseY; 

  private float layerScale = 1;
  private float translateX = 0;
  private float translateY = 0;

  Layer( ParticleSystem particleSystem, ArrayList<Shape> shapes, ArrayList<Link> links) {
    this.particleSystem = particleSystem;
    this.shapes = shapes;
    this.links = links;


    Particle north = particleSystem.makeParticle();
    north.makeFixed();
    north.position.x = width/2;
    north.position.y = 0;

    Particle south = particleSystem.makeParticle();
    south.makeFixed();
    south.position.x = width/2;
    south.position.y = height;
    
    Particle east = particleSystem.makeParticle();
    east.makeFixed();
    east.position.x = width;
    east.position.y = height/2;

    Particle west = particleSystem.makeParticle();
    west.makeFixed();
    west.position.x = 0;
    west.position.y = height/2;
    
    //-----Springs    
    for (int i=0; i< shapes.size (); i++) { 
      Particle a = shapes.get(i).getParticle();
        particleSystem.makeSpring(a, north, SPRING_STRENGTH/400, SPRING_DAMPING/10, SPRING_REST_LENGTH/10);
        particleSystem.makeSpring(a, south, SPRING_STRENGTH/800, SPRING_DAMPING/10, SPRING_REST_LENGTH/10);
        particleSystem.makeSpring(a, east, SPRING_STRENGTH/800, SPRING_DAMPING/10, SPRING_REST_LENGTH/10);
        particleSystem.makeSpring(a, west, SPRING_STRENGTH/800, SPRING_DAMPING/10, SPRING_REST_LENGTH/10);
      for (int j = i+1; j<shapes.size (); j++) {
        Particle b = shapes.get(j).getParticle();
        println("attraction "+ shapes.get(i).getLabel() +" === "+ shapes.get(j).getLabel()); 
        particleSystem.makeAttraction(a, b, ATTRACTION_STRENGTH, ATTRACTION_MIN_DISTANCE );
      }
    }
    //Once System is built, we can define the coordinates.
    rebuildCoordinatesFromShapes();
  }




  public void dragShape(int x, int y) {
    if (selectedShape != null) {
      Position position =selectedShape.getPosition();

      position.x += x-selectMouseX;
      position.y += y-selectMouseY;
      selectMouseX = x; 
      selectMouseY = y;
      rebuildCoordinatesFromShapes();
    } else {
      translateX = x-selectMouseX;
      translateY = y-selectMouseY;
    }
  }

  public void overShape (int x, int y) {
    highlightedShape  = find(x, y);
  }  

  public void unselectShape () {
    if (selectedShape !=null) {
      selectedShape.getParticle().makeFree(); 
      selectedShape = null;
    }
  } 

  public void selectShape (int x, int y) {
    selectedShape = find(x-translateX, y-translateY); //selectedShape may be null
    if (selectedShape !=null) {
      selectedShape.getParticle().makeFixed();
    }
    selectMouseX = x;
    selectMouseY = y;
  }  

  private Shape  find (float x, float y) {
    for (int i=0; i< shapes.size (); i++) {
      if (shapes.get(i).inside(x, y)) {
        return shapes.get(i);
      }
    }
    return null;
  }



  private void rebuildCoordinatesFromSystem() {
    for (Shape shape : shapes) {  
      //println("system x:"+shape.getParticle().position.x+" ; "+shape.getParticle().position.y); 
      shape.getPosition().x = shape.getParticle().position.x;
      shape.getPosition().y = shape.getParticle().position.y;
    }
  }
  private void rebuildCoordinatesFromShapes() {
    for (Shape shape : shapes) {  
      shape.getParticle().position.x =shape.getPosition().x;
      shape.getParticle().position.y = shape.getPosition().y;
    }
  }


  public void draw() {
    scale(layerScale);
    translate(translateX, translateY);
    particleSystem.tick();
    rebuildCoordinatesFromSystem();
    for (Link link : links) {
      Slot slot1= link.shape1.findBestSlot(link.shape2);
      Slot slot2= link.shape2.findBestSlot(link.shape1);

      stroke(linkColor);
      strokeWeight(2);
      noFill();
      Position position1 = link.shape1.getPosition();
      Position position2 = link.shape2.getPosition();
      bezier (position1.x + slot1.x, position1.y + slot1.y, position1.x + slot1.x + slot1.vx, position1.y + slot1.y + slot1.vy, 
      position2.x + slot2.x + slot2.vx, position2.y + slot2.y + slot2.vy, position2.x + slot2.x, position2.y + slot2.y );        

      noStroke();
      fill(slotColor);
      ellipse(position1.x + slot1.x, position1.y + slot1.y, 10, 10);
      ellipse(position2.x + slot2.x, position2.y + slot2.y, 10, 10);
    }    

    for (Shape shape : shapes) {
      if (selectedShape == shape) {
        fill(selectedShapeColor);
      } else {
        fill(shapeColor);
      }
      //-----  
      if (highlightedShape == shape) {
        strokeWeight(5);
        stroke(draggedColor);
      } else {
        noStroke();
      }
      //-----
      shape.draw();
    }
  }
  
  void zoomIn(){
    layerScale = layerScale*1.2;
  }
  void zoomOut(){
    layerScale = layerScale*0.8;
  }
}

