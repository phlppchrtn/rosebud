interface Handler{
  //
}
interface ClickHandler extends Handler{
  void onClick(); 
}

interface Sprite {
  boolean contains(int x, int y);
  void draw(boolean selected);
}

class DashBoard {
  ArrayList sprites = new ArrayList();
  HashMap  handlers = new HashMap ();
  int selected = -1; 

  void register(Sprite sprite, Handler handler){
    handlers.put(sprite, handler);
  }

  void add(Sprite sprite){
    sprites.add(sprite);
  }
  
  void mouseClicked(int x, int y) {
    for (int i=0; i<sprites.size(); i++){
      if (((Sprite)sprites.get(i)).contains(x, y)){
        selected = i;      
      }
    }  
  }
  
  void draw(){
    for (int i=0; i<sprites.size(); i++){
      ((Sprite)sprites.get(i)).draw(i==selected);
    } 
  }
}
