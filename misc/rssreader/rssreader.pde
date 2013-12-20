ArrayList items = new ArrayList();

void setup() {
  println("setup : started");
  size(600,400);
  noStroke();
  background(125);
  fill(255);
  loop();
  println("setup : finished");
  //initProxy();
  load();
}

void initProxy() {
  Properties systemSettings = System.getProperties();
 // systemSettings.put("http.proxyHost", "172.20.0.9");
 // systemSettings.put("http.proxyPort", "3128");
//  systemSettings.put("http.proxyUser", "myusername");
//  systemSettings.put("http.proxyPassword", "mypassword");
  System.setProperties(systemSettings); 
}  

//void display(string text){
//}

float y = 20;
int currentX=-1;
void draw(){
  background(125);
  fill(#EEEEEE);
  rect(10,0,450, height);

  fill(#333333);
  y += delta;
 
  float _y = y;
  //println("y="+y + " ; delta="+delta);
  for (int i = 0; i < items.size(); i++) {
    Item item = (Item) items.get(i);
    item.draw (20, _y);
    _y =  _y+ item.getHeight() +20;
  } 
}

class Item  {
  String title;
  String description;
  PImage img;
  String url;
  float x, y;
  void load(String imgUrl){
//    alert("load img"+imgUrl);
    img = loadImage(imgUrl);
  }
  float getWidth(){
      return 3 * img.width;
  }
  String toString(){
  return "item x="+x+" ; y="+y+" ; w="+getWidth()+" ; h="+getHeight()+" title="+title;
  }
  float getHeight(){
      float ascent = textAscent();
      return img.height + 2*ascent;
  }
  void draw(float _x, float _y){
    if ((_y+ getWidth())<0 || (_y-getWidth())>0){
    //   println("skip"); 
      return;
    }
    //   println("display"); 
    x = _x;
    y = _y;
      image(img, x, y);
//      println(">>"+title);
      float ascent = textAscent();
//     text("Hello Web!",20 ,20 );
      fill(#33B5E5);
      rect(x,y +img.height, img.width, 2*ascent+10);
     
      fill(#FFFFFF);
      textAlign(CENTER, CENTER);

      text(title, x, y +img.height, img.width, 2*ascent+10);
     
      fill(#333333);     

      rect(x + img.width, y,  2* img.width,getHeight()+10);
      fill(#FFFFFF);
     
      textAlign(LEFT, CENTER);
      text(description, x + img.width+10, y,  2* img.width-20, getHeight()+10);
      if (this == selected){
        noFill();
        stroke (#99CC00); 
        strokeWeight(1);   
        rect (_x, _y, getWidth(), getHeight());    
        noStroke();
      }
  }       
  
  boolean contains (float _x, float _y){
    return _x>=x && _x<=(x+getWidth()) && _y>=y && _y<=(y+getHeight());
  }
}


void load(){
  String url = "rss.xml";
  println("loading "+url);
  XMLElement rss = new XMLElement(this, url);
    
 // println(">>>>"+rss);
  XMLElement[] _items = rss.getChildren("channel/item");
  for (int i = 0; i < _items.length; i++) {
      Item item = new Item();
      item.title = _items[i].getChild("title").getContent();

      // Get thumbnail of each element
     //println(" item.title "+ item.title+ "  =" +_items[i].getChildCount());
      for (int j = 0; j<_items[i].getChildCount(); j++){
        //  alert(" j= "+ j +" =>"+_items[i].getChild(j).getName());
        if ("thumbnail".equals(_items[i].getChild(j).getName())){
          String imgUrl = _items[i].getChild(j).getString("url");
          item.load(imgUrl);
        }
      }
   /*   XMLElement[] imageURLElements = _items[i].getChildren("media:thumbnail");
      alert(" item.title "+ item.title+ "  =" +imageURLElements.length);
      for (int j = 0; j < imageURLElements.length; j++) {
           item.load(imageURLElements[j].getString("url"));
      }     */
      item.url = _items[i].getChild("link").getContent();
      item.description = _items[i].getChild("description").getContent();
      items.add(item);
  }
}
int delta = 0;
int prevMouseY= -1;

void mouseReleased(){
  prevMouseY = -1;
  delta = delta/2;
}

Item selected; 

//void mouseMoved(){
void mouseClicked(){
   for (int i = 0; i<items.size(); i++){
     Item item = (Item) items.get(i);
     //println(">>>item="+item.toString());  
     if (item.contains(mouseX, mouseY)){
        selected = item;  
        //println(">>>selected="+item.title);  
        //println("X = "+mouseX);
        //println("Y = "+mouseY);
        //link (item.url);
         display(item.description); 
         break;  
     }
   }
}

void mouseDragged(){
  if (prevMouseY !=-1){
    delta = mouseY - prevMouseY;
  }else {
    delta = 0;
  }
 // println(">>mouseDragged " + delta);
  prevMouseY = mouseY;
}

