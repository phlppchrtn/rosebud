ArrayList datas = new ArrayList();
ArrayList descriptions = new ArrayList();

float[] startAngles;
float[] stopAngles;

 void setup() {
    size(200, 200);
    smooth();
    noStroke();
    loop();
    reset();
    addData("10", "abba");
    addData("20", "djkszd");
    addData("30", "kjkj");
    prepare();
 }
 
 void reset(){
     datas = new ArrayList();
     descriptions = new ArrayList();
 }
 void addData(String value, String desc){
   println("addData :"+value+" ; desc=" +desc);
   datas.add(int(value)); 
   descriptions.add(desc); 
 }

 void prepare(){
    //On réinitialise les données
   startAngles = new float[datas.size()];
   stopAngles = new float[datas.size()];
     
   int sum = 0;
   for (int i=0; i<datas.size(); i++){
     sum += (Integer)datas.get(i);
   } 
 
    float startAngle = 0;
    float stopAngle = 0;
    for (int i=0; i<datas.size(); i++){
      fill(getColor(i));
      stopAngle = startAngle + ((Integer)datas.get(i))*TWO_PI /sum; 
      startAngles[i] = startAngle;

      startAngle = stopAngle;  
      stopAngles[i] = stopAngle;
    }
 }  
 int diameter = 150; 

 void draw(){
    println("drawDatas !");
    background(255);
     
    for (int i=0; i<datas.size(); i++){
  //  print("start :"+startAngles[i]+ ": "); 
  //  println("stop :"+stopAngles[i]);

      if (i == selected){
       //  println("selected "+selected);
      fill(getColor(i), 123);
         arc(width/2, height/2, diameter+ 20, diameter +20, startAngles[i], stopAngles[i]);
         fill(#ffffff);
        arc(width/2, height/2, diameter+ 5, diameter +5, startAngles[i], stopAngles[i]);
      }
     fill(getColor(i));
      arc(width/2, height/2, diameter, diameter, startAngles[i], stopAngles[i]);
    }
 }
 
 int selected = -1;
 void mouseClicked() {
   
    float angle = atan2(mouseY - height/2, mouseX - width/2);
    if (angle<0){
      angle = angle +TWO_PI;
    }

    for (int i=0; i<datas.size(); i++){
      if (angle>startAngles[i] && angle<stopAngles[i]){
        //On vérifie que l'on est dans le cercle !
        // 
        if (dist(width/2, height/2, mouseX, mouseY) < diameter/2){
          selected = i;
          select((String)descriptions.get(i));
          return ;
        }
      }
    }
    unSelect();
    selected = -1;
 }
 
 color getColor(int i){
      //Bleu /vert /orange
      color[] colors = {#33B5E5, #99CC00, #FFBB33}; 
      return colors[i%3]; 
}
