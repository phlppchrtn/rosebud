class LayerBuilder {
  private ParticleSystem particleSystem = new ParticleSystem();
  private HashMap<String, Integer> ids = new HashMap<String, Integer>();
  private ArrayList<Shape> shapes = new ArrayList<Shape>();
  private ArrayList<Link> links  = new ArrayList<Link>();
  
  
  public LayerBuilder addLink(String id1, String id2) {
    Shape shape1 = shapes.get(ids.get(id1));
    Shape shape2 = shapes.get(ids.get(id2));

    links.add(new Link(shape1, shape2));
    //-----
    Particle a = shape1.getParticle();
    Particle b = shape2.getParticle();
    particleSystem.makeAttraction(a, b, -ATTRACTION_STRENGTH, ATTRACTION_MIN_DISTANCE );
    return this;
  }

  public LayerBuilder addShape(String id, String shapeType, String label, float x, float y) {
    Shape shape;
    Particle particle =  particleSystem.makeParticle();

    if ("box".equals(shapeType)) {
      shape = new Box(new Position(x, y), 100, 100, particle, label);
    }
    else { 
      throw new RuntimeException ("Unknown shape type "+ shapeType);
    }
    ids.put(id, ids.size());
    shapes.add(shape);
    return this;
  }
  
  Layer build(){
    return new Layer (particleSystem, shapes, links);
  }
}
