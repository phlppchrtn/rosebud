List<Float> datas = new ArrayList();
List<String> descriptions = new ArrayList();

float[] startAngles;
float[] stopAngles;
int diameter = 150; 
//ItemSelected
int selected = -1;
 
 void setup() {
    size(200, 200);
    smooth();
    noStroke();
    loop();
    reset();
    addData("0.10", "aaa");
    addData("0.20", "bbb");
    addData("0.30", "ccc");
    prepare();
 }
 
 void reset(){
     datas = new ArrayList();
     descriptions = new ArrayList();
 }
void addData(String value, String desc){
      println(desc + " : value :"+value);

   datas.add(float(value)); 
   descriptions.add(desc); 
 }

 void prepare(){
    //data init
   startAngles = new float[datas.size()];
   stopAngles = new float[datas.size()];
     
   float sum = 0;
   for (int i=0; i<datas.size(); i++){
     sum += datas.get(i);
   } 
    println("sum :"+sum);

    float startAngle = 0;
    float stopAngle = 0;
    for (int i=0; i<datas.size(); i++){
      stopAngle = startAngle + (datas.get(i))*TWO_PI /sum; 
      startAngles[i] = startAngle;

      startAngle = stopAngle;  
      stopAngles[i] = stopAngle;
    }
 }  

 void draw(){
    background(255); //white
     
    for (int i=0; i<datas.size(); i++){
		if (i == selected){
			fill(getColor(i), 123); //Color with transparency
			arc(width/2, height/2, diameter+ 20, diameter +20, startAngles[i], stopAngles[i]);
			fill(#ffffff);
			arc(width/2, height/2, diameter+ 5, diameter +5, startAngles[i], stopAngles[i]);
		}
//		println("data "+i);
		fill(getColor(i));
		arc(width/2, height/2, diameter, diameter, startAngles[i], stopAngles[i]);
	}
 }
 

 void mouseClicked() {
    float angle = atan2(mouseY - height/2, mouseX - width/2);
    if (angle<0){
      angle = angle +TWO_PI;
    }

    for (int i=0; i<datas.size(); i++){
      if (angle>startAngles[i] && angle<stopAngles[i]){
        //check if we're inside the circle
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
      //color palette
      color[] colors = { #FFD200, #E31B23, #AFBD22, #5D87A1, #BEC0C2, #9C5708, #98002E, #6DB33F, #597B7B, #F47B20, #532E63, #00958F, #215352}; 
      return colors[i%13]; 
}
