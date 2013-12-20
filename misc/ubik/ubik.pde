ArrayList datas = new ArrayList();
DashBoard dashBoard = new DashBoard();
ArrayList descriptions = new ArrayList();
int diameter = 150; 

void setup() {
    size(400, 400);
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
   int sum = 0;
   for (int i=0; i<datas.size(); i++){
     sum += (Integer)datas.get(i);
   } 
    float startAngle =0;
    float stopAngle;
    for (int i=0; i<datas.size(); i++){
      stopAngle = startAngle + ((Integer)datas.get(i))*TWO_PI /sum; 
//      dashBoard.add(new Pie(width/2, height/2, startAngle, stopAngle, getColor(i)));
      dashBoard.add(new Pie(100, height/2, startAngle, stopAngle, getColor(i)));
      dashBoard.add(new Pie(300, height/2, startAngle, stopAngle, getColor(i)));
      startAngle = stopAngle;  
    }
 }  

 void draw(){
    println("drawDatas !");
    background(255);
    dashBoard.draw(); 
 }
 
color getColor(int i){
      //Bleu /vert /orange
      color[] colors = {#33B5E5, #99CC00, #FFBB33}; 
      return colors[i%3]; 
}

void mouseMoved() {
    dashBoard.mouseClicked(mouseX, mouseY); 
}


