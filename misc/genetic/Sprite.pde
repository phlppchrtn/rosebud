interface ISprite {
  void draw();
  boolean mouseOver(int mx, int my);
  void mousePressed();
}

abstract class Sprite implements ISprite {
  Float x;
  Float y;
  Float h;
  Float w;
  Integer m_fill;
  Integer m_stroke;
  Integer m_strokeWeight;
  Float opacity;
  Float tx;
  Float ty;
  Float rx;
  Float ry;
  Float angle;
  Float s;
  boolean visible;
  PMatrix2D matrix;
  boolean showbox;
  Boolean showOver;
  String type;

  Sprite() {
    //this.showOver = true;
    this.visible = true;
    this.opacity = 1;
    this.m_fill = null;
    this.m_stroke = null;
    this.m_strokeWeight = null;
    this.tx = 0;
    this.ty = 0;
    this.rx = null;
    this.ry = null;
    this.angle = null;
    this.s = 1;
    this.matrix = new PMatrix2D();
    //this.showbox = true;
  }

  final void draw() {
    if (!this.visible || this.s == 0) {
      return;
    }

    if (this.opacity != 1) {
      externals.context.save();
      externals.context.globalAlpha = this.opacity;
    }

    this.matrix = new PMatrix2D();
    pushMatrix();
    
    if (m_strokeWeight != null) {
      if (m_strokeWeight > 0) {
        strokeWeight(m_strokeWeight);
      }
    } else {
      strokeWeight(1);
    }
    
    if (this.m_stroke != null) {
      if (this.m_stroke.equals(-1)) {
        noStroke();
      } 
      else {
        stroke(this.m_stroke);
      }
    }

    if (this.m_fill != null) {
      if (this.m_fill.equals(-1)) {
        noFill();
      } 
      else {
        fill(this.m_fill);
      }
    }

    Float[] box = this.getBBox(true);
    if (!((this.tx == 0 ) && this.ty == 0 )) {
      matrix.translate(tx, ty);
      translate(tx, ty);
    }

    if (!(this.angle == null )) {

      if ((this.rx == null )) {
        this.rx = box[0] + (box[2] - box[0]) / 2;
      }

      if ((this.ry == null )) {
        this.ry = box[1] + (box[3] - box[1]) / 2;
      }
      matrix.translate(rx, ry);
      translate(rx, ry);

      matrix.rotate(angle * PI / 180);
      rotate(angle * PI / 180);

      matrix.translate(-rx, -ry);
      translate(-rx, -ry);
    }

    if (!(this.s == 1)) {
      matrix.translate((1 - this.s) * (box[0] + (box[2] - box[0]) / 2), (1 - this.s) * (box[1] + (box[3] - box[1]) / 2));
      translate((1 - this.s) * (box[0] + (box[2] - box[0]) / 2), (1 - this.s) * (box[1] + (box[3] - box[1]) / 2));
      matrix.scale(this.s);
      scale(this.s);
    }

    this.eDraw();
    if (this.opacity != 1) {
      externals.context.restore();
    }

    popMatrix();

    if (this.showbox) {
      stroke(0);
      noFill();
      box = this.getBBox();
      beginShape();
      vertex(box[0], box[1]);
      vertex(box[2], box[1]);
      vertex(box[2], box[3]);
      vertex(box[0], box[3]);
      endShape(CLOSE);
    }
  };

  void hide() {
    this.visible = false;
  }

  void show() {
    this.visible = true;
  }

  boolean mouseOver(int mx, int my) {
    if (this.isHide()) {
      return false;
    }
    Float [] box = this.getBBox();
    Boolean res = (box[0]<=mx && mx<=box[2] && box[1]<=my && my<=box[3]);
    return res;
  }

  boolean mouseOver(int mx, int my, int tolerance) {
    if (this.isHide()) {
      return false;
    }
    Float [] box = this.getBBox();
    Boolean res = ((box[0] - tolerance)<=mx && mx<=(box[2] + tolerance) && (box[1] - tolerance)<=my && my<=(box[3] + tolerance));  

    return res;
  }

  abstract void eDraw();

  final Float[] getBBox() {
    Float[] box = this.getBBox(true);
    Float x01, y01, x21, y21, x03, y03, x23, y23;

    x01 = box[0] * this.matrix.elements[0] + box[1] * this.matrix.elements[1] + this.matrix.elements[2];
    y01 = box[0] * this.matrix.elements[3] + box[1] * this.matrix.elements[4] + this.matrix.elements[5];

    x21 = box[2] * this.matrix.elements[0] + box[1] * this.matrix.elements[1] + this.matrix.elements[2];
    y21 = box[2] * this.matrix.elements[3] + box[1] * this.matrix.elements[4] + this.matrix.elements[5];

    x03 = box[0] * this.matrix.elements[0] + box[3] * this.matrix.elements[1] + this.matrix.elements[2];
    y03 = box[0] * this.matrix.elements[3] + box[3] * this.matrix.elements[4] + this.matrix.elements[5];

    x23 = box[2] * this.matrix.elements[0] + box[3] * this.matrix.elements[1] + this.matrix.elements[2];
    y23 = box[2] * this.matrix.elements[3] + box[3] * this.matrix.elements[4] + this.matrix.elements[5];

    box[0] = Math.min(x01, x21, x03, x23);
    box[1] = Math.min(y01, y21, y03, y23);

    box[2] = Math.max(x01, x21, x03, x23);
    box[3] = Math.max(y01, y21, y03, y23);

    return box;
  }

  void toFront() {
    // Workaround pour problème de closure
    var that = this;
    var parent = that.parent;
    var id = that.id;
    parent.toFront(id);
  }

  boolean isHide() {
    var that = this;
    if (that.parent) {
      return (that.parent.isHide() || (!visible));
    } 
    else {
      return (!visible);
    }
  }

  boolean hasShowOver() {
    var that = this;
    if (that.parent) {
      return (that.parent.hasShowOver() || (showOver));
    } 
    else {
      return (showOver);
    }
  }

  abstract Float[] getBBox(Boolean isWithoutTranform);
}

class Image extends Sprite {
  PImage img;

  Image(PImage img, float x, float y) {
    this.type = "Image";
    this.w = img.width;
    this.h = img.height;
    this.x = x;
    this.y= y;  
    this.img = img;
  }

  Image(PImage img, float x, float y, float w, float h) {
    this.type = "Image";
    this.w = w;
    this.h = h;
    this.x = x;
    this.y= y;  
    this.img = img;
  }

  void eDraw() {
    image(this.img, this.x, this.y, this.w, this.h);
  }

  Float[] getBBox(Boolean isWithoutTransform) {
    Float[] box = {
      this.x, this.y, this.x + this.w, this.y + this.h
    };
    return box;
  }
}

class Rect extends Sprite {

  Rect(float x, float y, float w, float h) {
    this.type = "Rect";
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
  }

  void eDraw() {
    rect(this.x, this.y, this.w, this.h);
  }

  Float[] getBBox(Boolean isWithoutTransform) {
    Float[] box = {
      this.x, this.y, this.x + this.w, this.y + this.h
    };
    return box;
  }
}

class SpriteCall extends Sprite {
  function drawFunc;

  SpriteCall(function drawFunc, float x, float y, float w, float h) {
    this.drawFunc = drawFunc;
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;
  }

  void eDraw() {
    drawFunc(this.x, this.y, this.w, this.h);
  }

  Float[] getBBox(Boolean isWithoutTransform) {
    Float[] box = {
      this.x, this.y, this.x + this.w, this.y + this.h
    };
    return box;
  }
}

class TextEl extends Sprite {
  PFont font;
  int size;
  String m_text;
  float x2;
  float y2;

  TextEl(String m_text, float x1, float y1, float x2, float y2, PFont font, int m_size) {
    this.type = "Text";
    this.m_text = m_text;
    this.x = x1;
    this.y = y1;
    this.x2 = x2;
    this.y2 = y2;
    this.w = x2 - x1;
    this.h = y2 - y1;
    this.font = font;
    this.size = m_size;
  }

  void eDraw() {
    textFont(this.font, this.size);
    text(this.m_text, this.x, this.y, this.x2, this.y2);
  }

  Float[] getBBox(Boolean isWithoutTransform) {
    Float[] box = {
      this.x, this.y, this.x + this.w, this.y + this.h
    };
    return box;
  }
}

class Circle extends Sprite {
  Float cx;
  Float cy;
  Float r;

  Circle(Float cx, Float cy, Float r) {
    this.type = "Circle";
    this.cx = cx;
    this.cy = cy;
    this.x = cx - r;
    this.y = cy - r;
    this.r = r;
    this.h = 2 * r;
    this.w = 2 * r;
  }

  Circle(Float cx, Float cy, Float r, Integer f, Integer s) {
    this.type = "Circle";
    this.cx = cx;
    this.cy = cy;
    this.x = cx - r;
    this.y = cy - r;
    this.r = r;
    this.h = 2 * r;
    this.w = 2 * r;
    this.m_fill = f;
    this.m_stroke = s;
  }

  Circle(Float cx, Float cy, Float r, Integer f, Integer s, Float o) {
    this.type = "Circle";
    this.cx = cx;
    this.cy = cy;
    this.x = cx - r;
    this.y = cy - r;
    this.r = r;
    this.h = 2 * r;
    this.w = 2 * r;
    this.m_fill = f;
    this.m_stroke = s;
    this.opacity = o;
  }

  void eDraw() {
    ellipse(this.cx, this.cy, this.r * 2, this.r * 2);
  }

  Float[] getBBox(Boolean isWithoutTransform) {
    Float[] box = {
      this.x, this.y, this.x + this.w, this.y + this.h
    };
    return box;
  }
}

class Group extends Sprite {
  ArrayList<Sprite> elements;

  Group () {
    elements = new ArrayList<Sprite>();
  }

  Group (Sprite element) {
    this.type = "Group";
    elements = new ArrayList<Sprite>();
    this.add(element);
  }
  
  void eDraw() {
    for (Sprite element : this.elements) {
      element.draw();
    }
  }
  
  void add(int index, Sprite element) {
    element.parent = this;
    element.id = index;
    for (int i = index; i < this.size(); i++) {
      get(i).id = get(i).id + 1;
    }
    
    this.elements.add(index, element);
  }
  
  void add(Sprite element) {
    element.parent = this;
    element.id = this.size();
    this.elements.add(element);
  }

  Sprite get(Integer index) {
    return this.elements.get(index);
  }

  void set(Integer index, Sprite element) {
    this.elements.set(index, element);
  }

  Integer size() {
    return this.elements.size();
  }

  Float[] getBBox() {
    Float[] box = {
      null, null, null, null
    };
    Float[] bBox;

    for (Sprite element : this.elements) {
      bBox = element.getBBox();
      if (box[0] == null || !(box[0] <= bBox[0])) {
        box[0] = bBox[0];
      }
      if (box[1] == null || !(box[1] <= bBox[1])) {
        box[1] = bBox[1];
      }
      if (box[2] == null || !(box[2] >= bBox[2])) {
        box[2] = bBox[2];
      }
      if (box[3] == null || !(box[3] >= bBox[3])) {
        box[3] = bBox[3];
      }
    }
    return box;
  }

  Float[] getBBox(Boolean isWithoutTransform) {
    Float[] box = {
      null, null, null, null
    };
    Float[] bBox;

    for (Sprite element : this.elements) {
      bBox = element.getBBox(isWithoutTransform);
      if (box[0] == null || !(box[0] <= bBox[0])) {
        box[0] = bBox[0];
      }
      if (box[1] == null || !(box[1] <= bBox[1])) {
        box[1] = bBox[1];
      }
      if (box[2] == null || !(box[2] >= bBox[2])) {
        box[2] = bBox[2];
      }
      if (box[3] == null || !(box[3] >= bBox[3])) {
        box[3] = bBox[3];
      }
    }
    return box;
  }

  boolean mouseOver(int mx, int my) {
    if (!this.visible) {
      return false;
    }

    for (Sprite element : this.elements) {
      if (element.mouseOver(mx, my)) {
        return true;
      }
    }
    return false;
  }

  void toFront(Integer index) {
    Sprite element = elements.get(index);
    Sprite last = elements.get(elements.size() - 1);
    elements.set(index, last);
    last.id = index;
    elements.set(elements.size() - 1, element);
    element.id = elements.size() - 1;
  }
}

