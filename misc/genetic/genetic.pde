/* @pjs preload="square.jpg, square_glass_button.png"; 
 */

Map<String, Sprite> hElements = new HashMap<String, Sprite>();
Map<String, PImage> hImages = new HashMap<String, PImage>();
Map<String, String> hLiaisons = new HashMap<String, String>();
Group gElements = new Group();
PFont font = loadFont("Dosis.vlw");

void setup() {
  size(1920, 1080);
  smooth();
  frameRate(60);
  hImages.put("square_glass_button", loadImage("square_glass_button.png"));
  hImages.put("square", loadImage("square.jpg"));

  // fonction initialize définie dans script.js
  initialize(this);
}

void draw() {
  background(#2288aa);
  gElements.draw();
}

/**
 * Ajoute les éléments à dessiner
 * @param name: nom de l'élément accessible avec hElement.get(name)
 * @param value: l'élément
 * @param index: (optionel) index d'ajout. Par défaut ajouté à la fin de la liste
 */
void addElement(String name, Sprite value, int index) {
  value.name = name;
  hElements.put(name, value);
  if (index >= 0) {
    gElements.add(index, hElements.get(name));
  } 
  else {
    gElements.add(hElements.get(name));
  }
}

/**
 * Ajoute les liaisons à dessiner
 * @param src: module fils
 * @param target: modules parents
 */
void addLiaison(String src, String[] target) {
  if (src == target) {
    return;
  }

  ArrayList<String> list = hLiaisons.get(src);
  if (list == null) {
    list = new ArrayList<String>();
    hLiaisons.put(src, list);
  }

  for (int index = 0; index < target.length; index++) {
    list.add(target[index]);
  }
}

void mouseClicked() {
  for (int index = gElements.size() - 1; index >= 0; index--) {
    Sprite element = gElements.get(index);
    if (element.type == "ModuleSprite" && element.mouseOver(mouseX, mouseY)) {
      consoleWrite("clicked on", element.name);
    }
  }
}

/**
* Classe de représentation du Module
*/
class ModuleSprite extends Group {
  Sprite sprite;
  Sprite shadow;
  Sprite m_text;
  Sprite m_line;

  ModuleSprite(float x, float y, float w, float h, String text) {
    this.type = "ModuleSprite";
    this.w = w;
    this.h = h;
    this.x = x;
    this.y = y;

    this.sprite = new Image(hImages.get("square"), x, y, w, h);//new Rect(x, y, w, h);
    this.sprite.m_fill = #ffffff;
    this.sprite.m_stroke = -1;
    this.sprite.opacity = 1;

    this.shadow = new Rect(x, y, w, h);
    this.shadow.tx = -4;
    this.shadow.ty = -4;
    this.shadow.m_fill = 0;
    this.shadow.opacity = 0.3;
    this.shadow.m_stroke = -1;

    this.m_text = new TextEl(text, x + 10, y + 15, x + w, y + h, font, 20);
    this.m_text.m_fill = #ffffff;

    this.m_line = new SpriteCall(line, x, y + 40, x + w, y + 40);
    m_line.m_stroke = #5555ff;
    m_line.m_strokeWeight = 2;

    this.add(this.shadow);
    this.add(this.sprite);
    this.add(this.m_text);
    this.add(m_line);
  }

  boolean mouseOver(int mx, int my) {
    if (!this.visible) {
      return false;
    }

    return sprite.mouseOver(mx, my);
  }

  float[] getAnchorUp() {
    return new float[] {
      tx + sprite.x + sprite.w/2, ty + sprite.y
    };
  }

  float[] getAnchorDown() {
    return new float[] {
      tx + sprite.x + sprite.w/2, ty + sprite.y + sprite.h
    };
  }
}

void initTree(Object map) {
  float startModX = 50, startModY = 50, offModX = 50, offModY = 50, widthMod = 100, heightMod = 100;
  float currModX = startModX, currModY = startModY;
  float textWidth = 500, textHeight = 500;
  int lastLevel = 0;

  for (int level = 0; level < map.modules.length; level++) {

    String[] listModules = map.modules[level];
    for (int iMod = 0; iMod < listModules.length; iMod++) {
      // Dessin à la position (currModX, currModY)
      Group gModule = new ModuleSprite(currModX, currModY, widthMod, heightMod, listModules[iMod]);

      addElement(listModules[iMod], gModule);
      
      // La position horizontale augmente tant que l'on est dans le même niveau et est réinitialisée quand on change de niveau
      if (iMod != (listModules.length - 1)) {
        currModX += gModule.w + offModX;
      }
      else {
        currModX = startModX + ((level + 1) % 2) * startModX;
        currModY += gModule.h + offModY;
      }
    }
  }

  iterateHashMap(hLiaisons, liaisonShow);
}

void liaisonShow(String key, ArrayList<String> list) {
  
  // el2 Sprite fils
  float[] el2 = hElements.get(key);
  float r = 10;
  for (String value : list) {
    // el1 Sprite parent
    float[] el1 = hElements.get(value);
    Group gLiaison = new Group();
    
    float[] aVect = el1.getAnchorDown();
    float[] bVect = el2.getAnchorUp();
    
    Sprite liaison = new SpriteCall(line, aVect[0], aVect[1], bVect[0], bVect[1]);
    gLiaison.add(liaison);
    liaison.m_stroke = #ff0000;

    Sprite begin = new Circle(bVect[0], bVect[1], r);
    begin.m_fill = #ffffff;

    Sprite end = new Rect(aVect[0] - r, aVect[1] - r, 2 * r, 2 * r);
    end.m_fill = #ffffff;

    gLiaison.add(begin);
    gLiaison.add(end);

    // Dessin de la liaison
    addElement("liaison_" + key + "_" + value, gLiaison);
  }
}

