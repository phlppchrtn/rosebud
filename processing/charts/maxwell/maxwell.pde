float[][] power= new float[100][100];
boolean [][] dynamic =new boolean [100][100];

void setup() {
  size(500, 500);
  smooth();
  noStroke();
  loop();
  for (int i=0; i<100; i++) {
    for (int j=0; j<100; j++) {
      power[i][j]=0;
      dynamic[i][j]=true;
    }
  }

  power[10][23]=253;
  dynamic[10][23]=false;

  power[10][24]=253;
  dynamic[10][24]=false;
  power[10][25]=253;
  dynamic[10][25]=false;
  power[10][26]=253;
  dynamic[10][26]=false;
}
//int loop = 0;

void draw() {
 // if (loop>100) {
  //  noLoop();
  //}
  //loop++;
  println("drawDatas !");
  background(255);
  for (int i=1; i<99; i++) {
    for (int j=1; j<99; j++) {
      if (dynamic[i][j]) {
        power[i][j]= (
        power[i-1][j-1] 
          + power[i-1][j] 
          + power[i-1][j+1]
          + power[i][j-1]
          + power[i][j+1]
          + power[i+1][j-1]
          + power[i+1][j]
          + power[i+1][j+1])/8;
      }
//      println("["+i+"]["+j+"]"+power[i][j]);
    }
  }

  for (int i=0; i<100; i++) {
    for (int j=0; j<100; j++) {
      fill(power[i][j]); 
      stroke(153);
      rect(5*i, 5*j, 5, 5);
    }
  }
}

void mouseClicked(){
  println("X="+Math.round(mouseX/5));
  println("Y="+Math.round(mouseY/5));
  int x= Math.round(mouseX/5);
  int y= Math.round(mouseY/5);
  power[x][y] = 200;
  dynamic[x][y] = false;
  
}

