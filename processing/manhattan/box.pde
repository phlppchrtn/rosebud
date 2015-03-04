class Box implements  Shape {
  Position position;
  int w, h;
  String label;
  Box (Position position, int w, int h, String label) {
    this.position = position;  
    this.w = w; 
    this.h = h;
    this.label = label;
  } 

  Position getPosition (){
    return position;
  }
  void draw() {
    rect (position.x, position.y, w, h);
    fill(textColor);
    text (label, position.x+5, position.y + 15);
  }

  boolean inside(float x, float y) {
    return x>position.x && x<(position.x+w) && y>position.y && y<(position.y+h);
  }

  Slot findBestSlot(Shape shape2) {
     float x = shape2.getPosition().x - position.x;
     float y = shape2.getPosition().y  - position.y;
    
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

