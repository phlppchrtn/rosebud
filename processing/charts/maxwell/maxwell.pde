int cols=10;
int rows=10;

int[][] power= new int[cols][rows];
boolean [][] dynamic =new boolean [cols][rows];

void setup() {
  size(500, 500);
  smooth();
  noStroke();
  loop();
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      power[i][j]=0;
      dynamic[i][j]=true;
    }
  }

  power[10][23]=1;
  dynamic[10][23]=false;

  power[10][24]=1;
  dynamic[10][24]=false;

  power[10][25]=1;
  dynamic[10][25]=false;

  power[10][26]=1;
  dynamic[10][26]=false;
}

int loops = 0;
void draw() {
   if (loops>10) {
    noLoop();
  }
  loops++;
  println("drawDatas :"+loops);
  background(255);
  for (int i=1; i< (cols-1); i++) {
    for (int j=1; j<(rows-1); j++) {
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
//      fill(lerpColor(#FFFFFF, #CCCCFF, power[i][j]));
      fill(100*power[i][j]);
      stroke(255);
      rect(50*i, 50*j, 50, 50);
    }
  }
}

void mouseClicked(){
    loops=0;
    loop();
    int x= Math.round(mouseX/50);
    int y= Math.round(mouseY/50);
    power[x][y] += 1;
    dynamic[x][y] = false;
  }
