
void setup() {
  size(200, 500);
  strokeCap(ROUND);
  strokeJoin(ROUND);
}


void draw() {
  Layer layer = new Layer();
  layer.add(new Box(10, 10), new Position (50, 50));
  layer.add(new Box(10, 10), new Position (10, 10));
  layer.draw();
  
  strokeWeight(2);
  noFill();
  bezier(15, 20, 15, 30, 50, 50, 50, 40);

}

class Layer {
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  ArrayList<Position> positions  = new ArrayList<Position>();

  void add(Shape shape, Position position) {
    shapes.add(shape);
    positions.add(position);
  }

  void draw() {
    for (int i=0; i< shapes.size (); i++) {
      shapes.get(i).draw(positions.get(i));
    }
  }
}

class Position {
  int x, y;
  Position (int x, int y) {
    this.x = x; 
    this.y = y;
  }
}

class Shape {
  void draw(Position position) {
  }
}

class Box extends Shape {
  int w, h;
  Box (int w, int h) {
    this.w = w; 
    this.h = h;
  } 

  void draw(Position position) {
    fill(255, 0, 0);
    rect (position.x, position.y, w, h);
  }
}

