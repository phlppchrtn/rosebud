PImage photo;

ArrayList<Tag> tags = new ArrayList();
boolean choosen = false;
Tag currentTag;
color defaultColor = #A0522D;

void setup() {
  cursor(CROSS);
  photo = loadImage("Coronation_of_Napoleon.jpg");
//  photo.loadPixels();
  size(300, 300);
//size($(document).width(), $(document).height());

  strokeCap(ROUND);
  strokeJoin(ROUND);
}

void updateColor(String c){
  int h = unhex("FF"+c);
  defaultColor = color(h);
  currentTag.c =defaultColor;
}


void removeTag(){
  choosen = false;
}

void saveTag(String label){
  currentTag.label = label;
  tags.add(currentTag);
  choosen = false;
}

void draw() {
  image(photo, 0, 0,500, 500);
//  background(photo);
  
 // fill(#00CCFF);
  //textSize(32);
  //text(current, mouseX, mouseY); 
  
//  boolean found = false;    
  for (int i= 0; i< tags.size(); i++) {
    Tag tag = tags.get(i);
//    if (! choosen && mouseX>tag.x-10 && mouseX<tag.x+10 && mouseY>tag.y-10 && mouseY<tag.y+10){
 //     stroke(#FF0000);
//      found = true;
 //   }else{
  //    stroke(#FFCC00);
  //  }
    drawTag(tag, tag.x, tag.y, false);
  }
  
  if (choosen){
    //on est en train de renseigner les tags
     if (mousePressed){
       drawTag(currentTag, mouseX, mouseY, true);
     }else{
       drawTag(currentTag, currentTag.x, currentTag.y, true);
     } 
  }else {
      //Il n'y a pas de point choisi, on affiche le curseur
      noFill();
      strokeWeight(2);
      stroke(#00CCFF);
      ellipse(mouseX-5, mouseY-5, 20, 20);
    } 
}

void drawTag (Tag tag, int x, int y, boolean selected){
   noFill();
   strokeWeight(2);
   stroke(tag.c);
   ellipse(x, y, 20, 20);
   text(tag.label, x, y); 
   if (selected){
      strokeWeight(1); 
      stroke(#CCCCCC); 
      rect(x-15, y-15,  30, 30);
   }
}  

void mouseClicked() {
    cursor(MOVE);

  choosen = true;

  currentTag = new Tag();
  currentTag.x = mouseX;
  currentTag.y = mouseY;
  currentTag.label= "";
  currentTag.c = defaultColor; 
  
  displayTag(mouseX, mouseY);    
}



