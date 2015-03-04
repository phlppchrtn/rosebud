interface Shape {
  void draw();
  boolean inside(float x, float y);

  //Find the best slot to link the shape 
  Slot findSlot(Shape shape);
  
  Position getPosition();
}
