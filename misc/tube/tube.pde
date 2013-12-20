ArrayList datas = new ArrayList();
ArrayList descriptions = new ArrayList();

 void setup() {
    size(200, 200);
    smooth();
    noStroke();
    loop();
    reset();
    addData("10", "A faire");
    addData("20", "En cours");
    addData("30", "A vérifier");
    addData("30", "A vérifier");
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
   int sum = 0;
   for (int i=0; i<datas.size(); i++){
     sum += (Integer)datas.get(i);
   } 
 }  

 void draw(){
    println("drawDatas !");
    background(240);
    
    stroke(200);
    strokeWeight(10);
    int margin = 10;
    float step = (width-2*margin)/datas.size();
//    strokeCap(SQUARE);

    line(margin, height/2, width-margin, height/2);

    float x = margin;
    for (int i=0; i<datas.size(); i++){


      noStroke();
      if (i == selected){
//        ellipse(x+step/2, height/2, 50, 50);
       //  println("selected "+selected);
  //    fill(getColor(i), 123);
   //      arc(width/2, height/2, diameter+ 20, diameter +20, startAngles[i], stopAngles[i]);
    //     fill(#ffffff);
     //   arc(width/2, height/2, diameter+ 5, diameter +5, startAngles[i], stopAngles[i]);
        fill(getColor(i));
      }else{
        fill(getColor(i), 123);
      }
      rect(x,50, step, 10);
 
      stroke(200);
      fill(getColor(i));
      ellipse(x+step/2, height/2, 30, 30);


      x += step;
    }
 }
 
 int selected = 0;
 void mouseClicked() {
/*
   select((String)descriptions.get(i));
          return ;
        }
      }
    }
*/
    unSelect();
 //   selected = -1;
 }
 
 color getColor(int i){
      //Bleu /vert /orange
      color[] colors = {#33B5E5, #99CC00, #FFBB33}; 
      return colors[i%3]; 
}
