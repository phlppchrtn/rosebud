float valeurMax = 100;
boolean mode;
void setup() {
  smooth(); 
  size(250, 250);
  //loop();
  //frameRate(60);
  PFont segoe = createFont("segoeui.ttf", 80);
  textFont(segoe, 80);
  textAlign(CENTER, CENTER);
}

void keyPressed() {
  mode = !mode;
}


void mouseClicked() {
  if ( mouseX > width/2) {
    incValue();
  }
  if ( mouseX < width/2) {
    decValue();
  }
}

void draw() {
  float valeur = getValue();
  background( 255 );
  fill( 255 );

 // drawDonut(valeur, mode);
 // filter(BLUR, 6);

  strokeWeight( 4 );
  stroke(85); 
  ellipse(125, 125, 150, 150);

  drawDonut(valeur, mode);

  strokeWeight( 10 );
  fill(getTextColor(valeur));
  text((int)valeur, 125, 125);
  afterDraw();
  postDraw();
 // filter(BLUR, (mouseX-width/2)/10);
}

void postDraw() {
  // Look up the RGB color in the source image
  loadPixels();
  for (int x = 0; x<width; x++) {
    for (int y = 0; y<height; y++) {
      int loc = x + y*width;
      float noise = noise2(x, y, 5);
      //  if ((y+x)%100 ==0) {
//      println(noise)
        //   }
        pixels[x + y*width] = color(red(pixels[loc]), green(pixels[loc]), blue(pixels[loc]), noise);
      //       pixels[x + y*width] = color(red(pixels[loc])*noise, green(pixels[loc])*noise,blue(pixels[loc])*noise);
    }
  }
  updatePixels();
  //filter(THRESHOLD, 40);
}   

void drawDonut(float valeur, boolean split) {
  if (split) {
    drawSplitDonut(valeur);
  }
  else {
    drawFullDonut(valeur);
  }
}  


void drawFullDonut(float valeur) {
  strokeWeight( 16 );
  stroke(getFillColor(valeur));
  arc(125, 125, 150, 150, -PI/2, -PI/2+(valeur/valeurMax)*2*PI);
}

void drawSplitDonut(float valeur) {
  fill(51, 181, 229);
  stroke(51, 181, 229);
  //arc(125, 125, 150, 150, -PI/2, -PI/2+(valeur/valeurMax)*2*PI);
  ellipseMode(CENTER);
  float a=-PI/2;
  int b=(int)(((valeur/valeurMax)*2*PI)/(PI/11));
  for (int i=0; i<b+1; i=i+1) {
    ellipse(125+75*cos(a), 125+75*sin(a), 14, 14);
    a=a+PI/11;
  }
}

color getFillColor(float valeur) {
  if (valeur/valeurMax <0.25) {
    return color(217, 59, 72);
  }
  else {
    return  color(51, 181, 229);
  }
}

color getTextColor(float valeur) {
  return color(80);
}

//http://www.java-gaming.org/index.php?topic=23771.0
private int noise2(double x, double y, int nbOctave) {
  int result=0;      
  int frequence256=256; 
  int sx=(int)((x)*frequence256); 
  int sy=(int)((y)*frequence256); 
  int octave=nbOctave;   
  while (octave!=0) {
    int bX=sx&0xFF;
    int bY=sy&0xFF;

    int sxp=sx>>8;
    int syp=sy>>8;


    //Compute noise for each corner of current cell
    int Y1376312589_00=syp*1376312589;
    int Y1376312589_01=Y1376312589_00+1376312589;

    int XY1376312589_00=sxp+Y1376312589_00;
    int XY1376312589_10=XY1376312589_00+1;
    int XY1376312589_01=sxp+Y1376312589_01;
    int XY1376312589_11=XY1376312589_01+1;

    int XYBASE_00=(XY1376312589_00<<13)^XY1376312589_00;
    int XYBASE_10=(XY1376312589_10<<13)^XY1376312589_10;
    int XYBASE_01=(XY1376312589_01<<13)^XY1376312589_01;
    int XYBASE_11=(XY1376312589_11<<13)^XY1376312589_11;

    int alt1=(XYBASE_00 * (XYBASE_00 * XYBASE_00 * 15731 + 789221) + 1376312589) ;
    int alt2=(XYBASE_10 * (XYBASE_10 * XYBASE_10 * 15731 + 789221) + 1376312589) ;
    int alt3=(XYBASE_01 * (XYBASE_01 * XYBASE_01 * 15731 + 789221) + 1376312589) ;
    int alt4=(XYBASE_11 * (XYBASE_11 * XYBASE_11 * 15731 + 789221) + 1376312589) ;

    /*
          *NOTE : on  for true grandiant noise uncomment following block
     * for true gradiant we need to perform scalar product here, gradiant vector are created/deducted using
     * the above pseudo random values (alt1...alt4) : by cutting thoses values in twice values to get for each a fixed x,y vector 
     * gradX1= alt1&0xFF 
     * gradY1= (alt1&0xFF00)>>8
     *
     * the last part of the PRN (alt1&0xFF0000)>>8 is used as an offset to correct one of the gradiant problem wich is zero on cell edge
     *
     * source vector (sXN;sYN) for scalar product are computed using (bX,bY)
     *
     * each four values  must be replaced by the result of the following 
     * altN=(gradXN;gradYN) scalar (sXN;sYN)
     *
     * all the rest of the code (interpolation+accumulation) is identical for value & gradiant noise
     */


    /*START BLOCK FOR TRUE GRADIANT NOISE*/

    int grad1X=(alt1&0xFF)-128;
    int grad1Y=((alt1>>8)&0xFF)-128;
    int grad2X=(alt2&0xFF)-128;
    int grad2Y=((alt2>>8)&0xFF)-128;
    int grad3X=(alt3&0xFF)-128;
    int grad3Y=((alt3>>8)&0xFF)-128;
    int grad4X=(alt4&0xFF)-128;
    int grad4Y=((alt4>>8)&0xFF)-128;


    int sX1=bX>>1;
    int sY1=bY>>1;
    int sX2=128-sX1;
    int sY2=sY1;
    int sX3=sX1;
    int sY3=128-sY1;
    int sX4=128-sX1;
    int sY4=128-sY1;
    alt1=(grad1X*sX1+grad1Y*sY1)+16384+((alt1&0xFF0000)>>9); //to avoid seams to be 0 we use an offset
    alt2=(grad2X*sX2+grad2Y*sY2)+16384+((alt2&0xFF0000)>>9);
    alt3=(grad3X*sX3+grad3Y*sY3)+16384+((alt3&0xFF0000)>>9);
    alt4=(grad4X*sX4+grad4Y*sY4)+16384+((alt4&0xFF0000)>>9);

    /*END BLOCK FOR TRUE GRADIANT NOISE */


    /*START BLOCK FOR VALUE NOISE*/
    /*
          alt1&=0xFFFF;
     alt2&=0xFFFF;
     alt3&=0xFFFF;
     alt4&=0xFFFF;
     */
    /*END BLOCK FOR VALUE NOISE*/


    /*START BLOCK FOR LINEAR INTERPOLATION*/
    //BiLinear interpolation 
    /*
         int f24=(bX*bY)>>8;
     int f23=bX-f24;
     int f14=bY-f24;
     int f13=256-f14-f23-f24;
     
     int val=(alt1*f13+alt2*f23+alt3*f14+alt4*f24);
     */
    /*END BLOCK FOR LINEAR INTERPOLATION*/



    //BiCubic interpolation ( in the form alt(bX) = alt[n] - (3*bX^2 - 2*bX^3) * (alt[n] - alt[n+1]) )
    /*START BLOCK FOR BICUBIC INTERPOLATION*/
    int bX2=(bX*bX)>>8;
    int bX3=(bX2*bX)>>8;
    int _3bX2=3*bX2;
    int _2bX3=2*bX3;
    int alt12= alt1 - (((_3bX2 - _2bX3) * (alt1-alt2)) >> 8);
    int alt34= alt3 - (((_3bX2 - _2bX3) * (alt3-alt4)) >> 8);


    int bY2=(bY*bY)>>8;
    int bY3=(bY2*bY)>>8;
    int _3bY2=3*bY2;
    int _2bY3=2*bY3;
    int val= alt12 - (((_3bY2 - _2bY3) * (alt12-alt34)) >> 8);

    val*=256;
    /*END BLOCK FOR BICUBIC INTERPOLATION*/


    //Accumulate in result
    result+=(val<<octave);

    octave--;
    sx<<=1; 
    sy<<=1;
  }
  return result>>>(16+nbOctave+1);
}

