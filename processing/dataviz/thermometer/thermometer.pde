 boolean selected = false;
 ThermoData data;
 void setup() {
    size(60, 160);
    smooth();
    noStroke();
    noLoop();
    
    ThermoData dataTest = new ThermoData();
    dataTest.min = 0;
    dataTest.max = 100;
    dataTest.value = 25;
    
    setData (dataTest);
 }

 void setData(ThermoData _data){
   println("addData "+ _data);
   data = _data;
   drawChart();
 }

  void drawChart(){
    translate (30, 130);

    println("drawDatas "+ data);
    background(255);
    

    strokeWeight (30);
    stroke(#CCCCCC);
    line (0,0, 0, -115);

    noStroke();
    fill(#CCCCCC);
    ellipse(0, 0, 50, 50); 

    strokeWeight (10);
    stroke(#FFFFFF);
    line (0,-15, 0, -115);

    noStroke();
    if (selected){
      fill(#CC0000);
    }else{
      fill(#FF4444);
    }
    ellipse(0, 0, 30, 30); 
    strokeWeight (10);
    if (selected){
      stroke(#CC0000);
    }else{
      stroke(#FF4444);
    }
    line (0,0, 0, -115 * (data.value/data.max));
    translate (-30, -130);

 }
 
void mouseOver() { 
  selected = true;
  println("mouseOver");
  select("" +data.value);
  drawChart();
}  

void mouseOut() {
    selected = false;
    println("mouseOut");
    unSelect();
    drawChart();
}  

ThermoData createData(){
  return new ThermoData();
}

class ThermoData {
  float  min;
  float  max;
  float  value;
  
  String toString(){
    return "{ min ="  + min  + " ; max=" + max + " ; value=" + value + " }"; 
  }
}

