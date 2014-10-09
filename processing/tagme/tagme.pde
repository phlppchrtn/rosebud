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
  boolean found = false;    
  for (int i= 0; i< tags.size(); i++) {
    Tag tag = tags.get(i);
    if (mouseX>tag.x-10 && mouseX<tag.x+10 && mouseY>tag.y-10 && mouseY<tag.y+10){
      stroke(#FF0000);
      found = true;
    }else{
      stroke(#FFCC00);
    }
    noFill();
    strokeWeight(5);
    ellipse(tag.x-5, tag.y-5, 20, 20);
    text(tag.label, tag.x, tag.y); 
  }
   if (!found){
      noFill();
      strokeWeight(5);
      stroke(#00CCFF);
      ellipse(mouseX-5, mouseY-5, 20, 20);
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



