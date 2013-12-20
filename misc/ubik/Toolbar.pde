class Button implements Sprite {
  String title;
  int x, y;  
  Button (int x, int y, String title){
    this.title = title;
    this.x = x;
    this.y = y;
  }
  
  boolean contains(int x, int y);
  void draw(boolean selected){
    if (selected){
     fill(153, 153, 153);
   }  else {
     fill(0, 102, 153);
   }  
    text(title, x, y);
  }

}
class Toolbar {
  ArrayList buttons = new ArrayList();
  int x, y;  

  Toolbar (int x, int y, String title){
    this.title = title;
    this.x = x;
    this.y = y;
  }
  
  void Button button){
     buttons.add(button);
  }
  void draw(){
  }
}
