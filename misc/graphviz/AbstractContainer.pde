abstract class AbstractContainer implements  Widget{
  protected  int width;
  protected  int height;
 /* protected  int topMargin;
  protected  int bottomMargin;
  protected  int leftMargin;
  protected  int rightMargin;
*/
  public int getWidth(){
    return width; 
  }

  public int getHeight(){
    return height; 
  }
  
  public int getTopMargin(){
     return topMargin;
   }
   
  public int getBottomMargin(){
     return bottomMargin;
   }
   
  public int getRightMargin(){
     return rightMargin;
   }
   
  public int getLeftMargin(){
     return leftMargin;
   }
}
