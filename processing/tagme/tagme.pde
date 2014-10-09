PImage photo;

ArrayList<Tag> tags = new ArrayList();
String current = "";
void setup() {
  //taille de la zone de dessin
  photo = loadImage("http://inapcache.boston.com/universal/site_graphics/blogs/bigpicture/Naturalworld_092614/bp18.jpg");
  size(500, 500);
}

void addTag(String text){
  current = text;
}

void draw() {
  //photo.resize(500, 0);
  image(photo, 0, 0, 500, 500);
  
  fill(#00CCFF);
  textSize(32);
  text(current, mouseX, mouseY); 
  
  fill(#00CCFF);
  rect(mouseX, mouseY, 10, 10);
    
  for (int i= 0; i< tags.size(); i++) {
    Tag tag = tags.get(i);
    fill(#FFCC00);
    rect(tag.x, tag.y, 10, 10);
    text(tag.label, tag.x, tag.y); 
  } 
}
  
void mouseClicked() {
  if (current.length()>0){
    Tag tag = new Tag();
    tag.x = mouseX;
    tag.y = mouseY;
    tag.label= current;
    current = "";
    tags.add(tag);
  }
}



