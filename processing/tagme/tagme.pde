PImage photo;

ArrayList<Tag> tags = new ArrayList();
boolean choosen = false;
Tag currentTag;
color defaultColor = #A0522D;

void setup() {
  cursor(CROSS);
  photo = loadImage("Coronation_of_Napoleon.jpg");
//  photo.loadPixels();
  size(500, 500);
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
  cursor(CROSS);
}

void draw() {
  image(photo, 0, 0,500, 500);
  
  for (int i= 0; i< tags.size(); i++) {
    Tag tag = tags.get(i);
    drawTag(tag, false);
  }
  
  if (choosen){
    //on est en train de renseigner les tags
     if (move){
        cursor(HAND);
       currentTag.x = mouseX;
       currentTag.y = mouseY;
     }
     drawTag(currentTag, true);
  }else {
      //Il n'y a pas de point choisi, on affiche le curseur
      cursor(CROSS);
      noFill();
      strokeWeight(2);
      stroke(#00CCFF);
      ellipse(mouseX-5, mouseY-5, 20, 20);
    } 
}

void drawTag (Tag tag, boolean selected){
   noFill();
   strokeWeight(2);
   stroke(tag.c);
   ellipse(tag.x, tag.y, 20, 20);
   text(tag.label, tag.x, tag.y); 
   if (selected){
      strokeWeight(1); 
      stroke(#CCCCCC); 
      rect(tag.x-15, tag.y-15,  30, 30);
   }
}  

boolean move =false;

void mouseReleased() {
   // cursor(ARROW);
   // if (move){
    //  currentTag.x = mouseX;
    //  currentTag.y = mouseY;
    //  move= false;
    //} 
}  
void mouseClicked() {
  if (choosen){
   if (abs(currentTag.x-mouseX)<20 && abs(currentTag.y-mouseY)<20){
     //on est sur le tag couant, on le bouge 
     cursor(HAND);
      move= true;
    }
  }else{
    choosen = true;
  
    currentTag = new Tag();
    currentTag.x = mouseX;
    currentTag.y = mouseY;
    currentTag.label= "";
    currentTag.c = defaultColor; 
    
    displayTag(mouseX, mouseY);    
  }

}



