public final class HContainer extends AbstractContainer{
  private static final short TOP = 1;
  private static final short CENTER = 2;
  private static final short BOTTOM = 3;

  private final List<Widget> widgets = new ArrayList<Widget> ();
  private short position = TOP;


  //On ajoute toujours les composants à droite paér convention.
  public void addWidget(Widget widget){
    if (widgets.isEmpty()){
      //Cas du premier élément placé. 
      //La marge a gauche est celle du premier élément placé.
      leftMargin = widget.getLeftMargin();
      width = widget.getWidth();
    }else{
      //On fusionne les marges
      int margin = max (rightMargin, widget.getLeftMargin());
      width = width + margin + widget.getWidth();
    }
    
    height = max(height, widget.getHeight());
    //La marge à droite est toujoyurs celle du dernier élément placé 
    rightMargin = widget.getRightMargin(); 
    //topMargin = max (topMargin, widget.getTopMargin());
    //---
    widgets.add(widget);
  }  
  
  //-----------------------------------------------------------

  void draw() {
  //  int last rightMargin =0;
    for (Widget widget : widgets){ 
//      if (
//      int margin = max (0, widget.getLeftMargin()- rightMargin);
  //    translate (widget.getWidth() , 0);
//       + max(widget.getRightMargin(), 0);
      widget.draw();

      translate (widget.getWidth() , 0);
      rightMargin = widget.getRightMargin();
    }
  }
}
