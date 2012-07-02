float boxWidth = 30;
float lineWidth = 3;
float barWidth;

float xOff = boxWidth;
float uOff = 0;

int blurry = 1;

void setup() {
  size(600, 600);
  noLoop();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT)
      if (uOff > -8) uOff -= 2;
    if (keyCode == RIGHT)
      if (uOff < 35) uOff += 2;
  }
  else if (key == ' ')
    blurry = (2-blurry)-2;
  redraw();
}

void draw() {
  background(125);
  noStroke();
  
  barWidth = boxWidth/4;
  
  for (int y=0; y*(boxWidth+lineWidth)<=height-boxWidth; y++)
    drawRow(y*(boxWidth+lineWidth)+4, y%2);
}

// dir: 1 = ltr motion, 0 = rtl motion
void drawRow(float y, int dir) {
  float barOff = 0;
  if (dir == blurry*1)
    barOff = 3*barWidth;
  
  float off = (boxWidth/2)*-dir + xOff;
  
  if (y%2 == 1)
    off += uOff;
  
  for (int x=0; x*boxWidth<=width-3*xOff; x++) {
    if (x%2 == 0) {
      fill(color(#D1E231)); // black
      rect(off+x*boxWidth, y, boxWidth, boxWidth);
      fill(0);//62); // dark
      rect(off+x*boxWidth+barOff, y, barWidth, boxWidth);
    }
    else {
      fill(color(#0000EE)); // white
      rect(off+x*boxWidth, y, boxWidth, boxWidth);
      fill(255);//187); // light
      rect(off+x*boxWidth+barOff, y, barWidth, boxWidth);
    }
  }
}
