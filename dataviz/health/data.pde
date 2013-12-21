float valeurMax=100;

float value = 50;
float step = 1;

int getValue() {
  return value;
}
float getRate() {
  return value/valeurMax;
}
color getFillColor() {
  if (value/valeurMax <0.25) {
    return color(217, 59, 72);
  }
  else {
    return  color(51, 181, 229);
  }
}

color getTextColor(float valeur) {
  return color(80);
}

void incValue() {
  //println ("inc"); 
  value = value + step;
}

void decValue() {
  // println ("dec"); 
  value = value - step;
}

