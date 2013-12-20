int player = 1; 
int[][] board = new int[7][6];
boolean playing = true;
int on = 0;

void setup() {
  size(800, 800);
  noStroke();
}

void draw() {
  background(255);  
  fill(0, 0, 255);
  rect(0, 0, 700, 600);
  for (int c=0; c<7 ; c++) {
    for (int r=0; r<6 ; r++) {
      fill(getColor(board[c][r]));
      ellipse(50+c*100, 50+r*100, 50, 50);
    }
  }

  fill(122);
  rect (25, 650, 300, 75);

  fill(getColor(player));
  rect (50, 675, 25, 25);

  fill(255);
  textSize(25);
  text("Joueur : " +player, 100, 700);


  if (playing) { 
    fill(0, 255, 0);
  }
  else {
    fill(255, 0, 0);
  } 
  ellipse (300, 690, 20, 20);
  if (playing) { 
    if (on%20 >10) {
      fill(0, 255, 0);
    }
    else {
      fill(255);
    }
    ellipse (300, 690, 15, 15);
  }
  on ++;
}  

void mouseClicked() {
  if (playing) {
    int c = floor(mouseX/100);
    int r = floor(mouseY/100);

    if (c>=0 && c<7 && r>=0 && r<6) {
      //On cherche la première ligne vide
      for (int i=0 ; i<6; i++) {
        if ((i==5 || board[c][i+1]>0 )&&(board[c][i]==0)) {
          r= i;
          play(c, r);
          break;
        }
      }
    }
  }
}

void play(int c, int r) {
  board[c][r] =player;
  //gain ?

  if (win(c, r)) {
    playing = false;
  } 
  else { 
    //On change de joueur
    if (player ==1) {
      player =2;
    } 
    else {
      player =1;
    }
  }
}

int eval(int c, int r, int cstep, int rstep) {
  int count = 0;
  if (same(c + cstep, r + rstep)) {
    count ++;
    if (same(c + 2*cstep, r + 2*rstep)) {
      count ++;
      if (same(c + 3*cstep, r + 3*rstep)) {
        count ++;
      }
    }
  }
  return count;
}  

boolean win(int c, int r) {
  if (same(c, r+1) && same(c, r+2)&& same(c, r+3)) {
    //alignement vertical 
    return true;
  }

  int east = eval(c, r, 1, 0 );
  int west = eval (c, r, -1,0);
  if ((east+west+1)>=4) {
    //alignement horizontal  
    return true;
  } 

  int northEast = eval(c, r, 1, -1 );
  int southWest = eval(c, r, -1, 1 );
  if ((northEast+southWest+1)>=4) {
    //alignement diagonale   
    return true;
  } 

  int northWest = eval(c, r, -1, -1 );
  int southEast = eval(c, r, 1, 1 );
  if ((northWest+southEast+1)>=4) {
    //alignement diagonale   
    return true;
  } 

  return false;
}  

boolean same(int c, int r) {
  if (c>=0 && c<7 && r>=0 && r<6) {
    return board[c][r] == player;
  }
  return false;
}


color getColor(int p) {
  switch(p) {
  case 1:   
    return color(255, 0, 0);
  case 2:   
    return color(255, 255, 0);
  }
  return color(255);
}

