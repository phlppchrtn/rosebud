
Layer layer = new Layer();

void setup() {
  size(500, 500);

  layer.addShape("a", "box", "movie", 10, 10);
  layer.addShape("b", "box", "actor", 200, 10);
  layer.addShape("c", "box", "producer", 150, 150);
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
  ArrayList<String> labels  = new ArrayList<String>();
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

  void addShape(String id, String shapeType, String label, int x, int y) {
    Shape shape;
    if ("box".equals(shapeType)){
      shape = new Box(100, 100);
    }else{
      throw new RuntimeException ("Unknown shape type "+ shapeType);
    }
    ids.put(id, ids.size());
    labels.add(label);
    shapes.add(shape);
    positions.add(new Position(x, y));
  }

  Slot getSlot1(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);
    Position position1 = positions.get(i1);
    Position position2 = positions.get(i2);
    
    Shape shape = shapes.get(i1);
    return shape.findSlot(-position1.x + position2.x, - position1.y + position2.y);
  }

  Slot getSlot2(Link link) {
    int i1 = ids.get(link.id1);
    int i2 = ids.get(link.id2);
    Position position1 = positions.get(i1);
    Position position2 = positions.get(i2);
    
    Shape shape = shapes.get(i2);
    return shape.findSlot(position1.x - position2.x, position1.y - position2.y);
  }

  void draw() {
    stroke(#CCCCCC);
    strokeWeight(2);
    noFill();

    for (int i=0; i< links.size (); i++) {
      Link link = links.get(i);
      int i1 = ids.get(link.id1);
      int i2 = ids.get(link.id2);

      Slot slot1= getSlot1(links.get(i));
      Slot slot2= getSlot2(links.get(i));
      
      line(positions.get(i1).x + slot1.x, positions.get(i1).y + slot1.y, positions.get(i2).x +slot2.x, positions.get(i2).y +slot2.y);
      fill(125);
      ellipse(positions.get(i1).x + slot1.x, positions.get(i1).y + slot1.y, 10,10);
      ellipse(positions.get(i2).x + slot2.x, positions.get(i2).y + slot2.y, 10,10);
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
      shapes.get(i).draw(positions.get(i), labels.get(i));
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
  void draw(Position position, String label);
  //relative
  boolean inside(int x, int y);
  
  Slot findSlot(int x, int y); 
}

class Box implements  Shape {
  int w, h;
  Box (int w, int h) {
    this.w = w; 
    this.h = h;
  } 

  void draw(Position position, String label) {
    rect (position.x, position.y, w, h);
    fill(0);
    text (label, position.x+5 , position.y + 15);
  }

  boolean inside(int x, int y) {
    return x>0 && x<w && y>0 && y<h;
  }

  Slot findSlot(int x, int y){
    float d = sqrt(x*x + y*y);

    if( x>d/2) {
      return new Slot (w, h/2);
    } else if( x<-d/2) {
      return new Slot (0, h/2);
    } else if( y>d/2) {
      return new Slot (w/2, h);
    }  
    return new Slot (w/2, 0);
  }

}


void mouseMoved() {
  layer.overShape(mouseX, mouseY);
}

void mousePressed() {
  layer.selectShape(mouseX, mouseY);
}  

void mouseDragged() {
  if (layer.select != null) {
    //If there is a shape selected, the we can move it
    layer.moveShape(mouseX, mouseY);
  }
}
