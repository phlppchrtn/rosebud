interface Shape {
  void draw(Position position);
  //relative
  boolean inside(float x, float y);

  Slot findSlot(float x, float y);
}
