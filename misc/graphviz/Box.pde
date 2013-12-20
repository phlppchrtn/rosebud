public final class Box implements Widget{
  private final int width;
  private final int height;
  
  public Box(int width, int height) {
    this.width = width;
    this.height = height;
  }
  
  public int getWidth(){
    return width; 
  }

  public int getHeight(){
    return height; 
  }
  
   public int getTopMargin(){
     return 20;
   }
   
   public int getBottomMargin(){
     return 20;
   }
   
   public int getRightMargin(){
     return 30;
   }
   
   public int getLeftMargin(){
     return 25;
   }
  
  //-----------------------------------------------------------
    
  public void draw() {
    //Affichage des marges
    noFill();  
    stroke(marginColor);
    strokeWeight(0.15);
    rect (0, 0, width + getRightMargin(), height + getBottomMargin()); 

    //Affichage du contenu
    fill(255,255,255);
    stroke(boxColor);
    strokeWeight(0.35);
    rect (0 + getLeftMargin(), 0 + getTopMargin(), width, height); 
  }
}
  
