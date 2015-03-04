interface Shape {
  void draw();
  boolean inside(float x, float y);

  Slot findSlot(float x, float y);
  
  Position getPosition();
}
