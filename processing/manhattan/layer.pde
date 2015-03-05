class Layer {
  private final ParticleSystem particleSystem;
  private final ArrayList<Shape> shapes;
  private final ArrayList<Link> links;

  private Shape highlightedShape;
  //-----
  private Shape selectedShape;
  private int selectMouseX, selectMouseY; 

  private float translateX = 0;
  private float translateY = 0;

  Layer( ParticleSystem particleSystem, ArrayList<Shape> shapes, ArrayList<Link> links) {
    this.particleSystem = particleSystem;
    this.shapes = shapes;
    this.links = links;

    //-----Springs    
    for (int i=0; i< shapes.size (); i++) { 
      Particle a = shapes.get(i).getParticle();
      for (int j = i+1; j<shapes.size (); j++) {
        Particle b = shapes.get(j).getParticle();
        particleSystem.makeSpring(a, b, SPRING_STRENGTH, SPRING_DAMPING, SPRING_REST_LENGTH);
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
      if (overShape == shape) {
        strokeWeight(5);
        stroke(draggedColor);
      } else {
        noStroke();
      }
      //-----
      shape.draw();
    }
  }
}

