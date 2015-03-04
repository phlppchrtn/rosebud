class Box implements  Shape {
  String label;
  int w, h;
  Box (int w, int h, String label) {
    this.w = w; 
    this.h = h;
    this.label = label;
  } 

  void draw(Position position) {
    rect (position.x, position.y, w, h);
    fill(textColor);
    text (label, position.x+5, position.y + 15);
  }

  boolean inside(float x, float y) {
    return x>0 && x<w && y>0 && y<h;
  }

  Slot findSlot(float x, float y) {
    float d = sqrt(x*x + y*y);

    if ( x>d/2) {
      return new Slot (w, h/2, 50, 0);
    } 
    else if ( x<-d/2) {
      return new Slot (0, h/2, -50, 0);
    } 
    else if ( y>d/2) {
      return new Slot (w/2, h, 0, 50);
    }  
    return new Slot (w/2, 0, 0, -50);
  }
}

