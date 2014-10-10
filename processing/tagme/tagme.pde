PImage photo;

ArrayList<Tag> tags = new ArrayList();
boolean choosen = false;
Tag currentTag;

void setup() {
  //taille de la zone de dessin
  photo = loadImage("http://inapcache.boston.com/universal/site_graphics/blogs/bigpicture/Naturalworld_092614/bp18.jpg");
  size(500, 500);
}

void updateColor(String c){
  alert(currentTag.c);
  int hi = unhex(c);
  currentTag.c = color(hi);
  alert(currentTag.c);
}


void addInfo(String label){
  currentTag.label = label;
  tags.add(currentTag);
  choosen = false;
}

void draw() {
  //photo.resize(500, 0);
  image(photo, 0, 0, 500, 500);
  
 // fill(#00CCFF);
  //textSize(32);
  //text(current, mouseX, mouseY); 
  
  fill(#00CCFF);
//  boolean found = false;    
  for (int i= 0; i< tags.size(); i++) {
    Tag tag = tags.get(i);
//    if (! choosen && mouseX>tag.x-10 && mouseX<tag.x+10 && mouseY>tag.y-10 && mouseY<tag.y+10){
 //     stroke(#FF0000);
//      found = true;
 //   }else{
  //    stroke(#FFCC00);
  //  }
    drawTag(tag);
  }
  
  if (choosen){
    //on est en train de rensigner les tags
     drawTag(currentTag);
  }else {
      noFill();
      strokeWeight(2);
      stroke(#00CCFF);
      ellipse(mouseX-5, mouseY-5, 20, 20);
    } 
}

void drawTag (Tag tag){
   noFill();
   strokeWeight(2);
   stroke(tag.c);
   ellipse(tag.x-5, tag.y-5, 20, 20);
   text(tag.label, tag.x, tag.y); 
}  

void mouseClicked() {
  choosen = true;

  currentTag = new Tag();
  currentTag.x = mouseX;
  currentTag.y = mouseY;
  currentTag.label= "";
  currentTag.c = #A0522D; 
  displayTag();    
}



