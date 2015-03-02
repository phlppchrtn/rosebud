
Layer layer = new Layer();

void setup() {
  size(500, 500);

  layer.addShape("a", new Box(100, 100), new Position (10, 10));
  layer.addShape("b", new Box(100, 100), new Position (200, 10));
  layer.addShape("c", new Box(100, 100), new Position (150, 150));
  layer.addLink ("a", "c");
  layer.addLink ("a", "b");
  layer.addLink ("b", "c");
}


void draw() {
  background(#FFFFFF);
  layer.draw();
}

class Link {
  String id1;
  String id2;
  Link(String id1, String id2) {
    this.id1 = id1;
    this.id2 = id2;
  }
}

class Slot {
  int x;
  int y;
  Slot(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class Layer {
  HashMap<String, Integer> ids = new HashMap<String, Integer>();
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  ArrayList<Position> positions  = new ArrayList<Position>();
  //-----
  ArrayList<Link> links  = new ArrayList<Link>();

  Shape over;
  //-----
  Shape select;
  int selectMouseX, selectMouseY; 
  int selectIndex;
  //-----

  void moveShape(int x, int y) {
    Position position = positions.get(selectIndex);
    println("MOVE shape x :"+ (x-selectMouseX));

    position.x += x-selectMouseX;
    position.y += y-selectMouseY;
    selectMouseX = x; 
    selectMouseY = y;
  }

  void overShape (int x, int y) {
    over  = find(x, y);
  }  

  void selectShape (int x, int y) {
    select = find(x, y);
    if (select != null) {
      selectMouseX = x;
      selectMouseY = y;
      selectIndex = shapes.indexOf(select);
    }
  }  

  Shape  find (int x, int y) {
    for (int i=0; i< positions.size (); i++) {
      if (shapes.get(i).inside(x - positions.get(i).x, y- positions.get(i).y)) {
        return shapes.get(i);
      }
    }
    return null;
  }

  void addLink(String id1, String id2) {
    links.add(new Link(id1, id2));
  }

  void addShape(String id, Shape shape, Position position) {
    ids.put(id, ids.size());
    shapes.add(shape);
    positions.add(position);
  }

  Slot getSlot1(Link link) {
    int i = ids.get(link.id1);
    return  new Slot ( positions.get(i).x, positions.get(i).y);
  }

  Slot getSlot2(Link link) {
    int i = ids.get(link.id2);
    return  new Slot ( positions.get(i).x, positions.get(i).y);
  }

  void draw() {
    stroke(#CCCCCC);
    strokeWeight(2);
    noFill();

    for (int i=0; i< links.size (); i++) {
      Slot slot1= getSlot1(links.get(i));
      Slot slot2= getSlot2(links.get(i));
      line(slot1.x, slot1.y, slot2.x, slot2.y);
    }    

    fill(255, 0, 0);
    for (int i=0; i< shapes.size (); i++) {
      noStroke();
      if (select == shapes.get(i)) {
        fill(#CCCCFF);
      }
      else {
        fill(#FFCCCC);
      }
      //-----  
      if (over == shapes.get(i)) {
        strokeWeight(5);
        stroke(#FFFFCC);
      }
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

interface Shape {
  void draw(Position position);
  //relative
  boolean inside(int x, int y);
}

class Box implements  Shape {
  int w, h;
  Box (int w, int h) {
    this.w = w; 
    this.h = h;
  } 

  void draw(Position position) {
    rect (position.x, position.y, w, h);
  }

  boolean inside(int x, int y) {
    return x>0 && x<w && y>0 && y<h;
  }
}


void mouseMoved() {
  layer.overShape(mouseX, mouseY);
}

void mousePressed() {
  println("pressed");
  layer.selectShape(mouseX, mouseY);
}  

void mouseDragged() {
  println("dragged");
  if (layer.select != null) {
    //If there is a shape selected, the we can move it
    layer.moveShape(mouseX, mouseY);
  }
}

