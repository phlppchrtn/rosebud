class Pie implements Sprite{
  float startAngle;
  float stopAngle;
  color _color;
  float centerX, centerY;
  
  Pie(int x, int y, float startAngle, float stopAngle, color _color){
    this.startAngle = startAngle;
    this.stopAngle = stopAngle;
    this._color = _color; 
    this.centerX = x;
    this.centerY = y;
  }

   void draw(boolean selected){
      if (selected){
         fill(_color, 123);
         arc(centerX, centerY, diameter+ 20, diameter +20, startAngle, stopAngle);
         fill(#ffffff);
         arc(centerX, centerY, diameter+ 5, diameter +5, startAngle, stopAngle);
      }   
      fill(_color);
      arc(centerX, centerY, diameter, diameter, startAngle, stopAngle);
    }
    
    boolean contains (int x, int y){
      float angle = atan2(y - centerY, x - centerX);
      if (angle<0){
        angle = angle +TWO_PI;
      }
      if (angle>startAngle && angle<stopAngle){
        //On vérifie que l'on est dans le cercle !
        if (dist(centerX, centerY, x, y) < diameter/2){
          return true;
        }
      }
      return false;
    }
}

