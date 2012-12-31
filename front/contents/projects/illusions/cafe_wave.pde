int SIZE = 600;
int xOff = 0;

color darkest, lightest, middark, midlight;

String orderStr;
String orderStr1 = "darkest -> mid-light (green) -> lightest -> mid-dark (blue)"
+ "\n" + "which creates motion in the opposite direction of the arcs";
String orderStr2 = "darkest -> mid-dark (blue) -> lightest -> mid-light (green)"
+ "\n" + "which creates motion in the same direction as the arcs";

Pfont font;

void setup() {
  size(SIZE, SIZE);
  noLoop();

  font = loadFont("_sans");
  textFont(font, 14);

  darkest = color(0);
  lightest = color(255);
  middark = color(#2643FA); // blue //#0000EE);
  midlight = color(#D1E231); // green

  orderStr = orderStr1;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT)
      if (xOff > -30) xOff -= 2;
    if (keyCode == RIGHT)
      if (xOff < 24) xOff += 2;
  }
       
  // change direction of motion
  else if (key == ' ') {
    color temp = middark;
    middark = midlight;
    midlight = temp;
    if (orderStr == orderStr1)
      orderStr = orderStr2;
    else
      orderStr = orderStr1;
  }
  redraw();
}

void draw() {
  background(125);

  for(int y=0; y<20; y++) {
    if (y%2 == 0)
      drawRow(xOff-5, y*80, 1);
    else
      drawRow(SIZE, y*80, -1);
  }
  for(int y=0; y<20; y++) {
    strokeWeight(3);
    stroke(125);
    line(0, y*80+40, SIZE, y*80+40);
  }
  
  translate(0, height-40);
  noStroke();
  fill(0);
  rect(0, 0, width, 40);
  fill(255);
  text("color order: "+orderStr, 5, 18);
  
  strokeWeight(1);
  stroke(255);
  line(width-120, 0, width-120, 40);
  
  text("row offset: "+xOff, width-110, 18);
}

// dir is 1 for left to right, -1 for right to left
void drawRow(int startx, int y, int dir) {
  ellipseMode(CENTER);
  int s = 20;

  noStroke();

  int d;
  int off = -50;
  int totalx = 0;

  for (int x=0; x<50; x++) {
    if (x%2 == 0) { 
      d = s/4; // small sections
      if (x%4 == 0) // 1
        fill(lightest);
      else // 3
      fill(darkest);
    }
    else { 
      d = s+s/4; // big sections
      if ((x+1)%4 == 0) // 4
        fill(midlight);
      else // 2
      fill(middark);
    }

    totalx += d*dir;

    translate(startx+dir*off+totalx, y);
    rotate(dir*PI/2);
    drawCurve(s, d);
    resetMatrix();
  }
}

void drawCurve(int s, int d) {
  Point p0 = new Point(2*-s, d);
  Point p1 = new Point(2*-s, 0);
  Point p2 = new Point(0, 1.5*-s);
  Point p3 = new Point(2*s, 0);
  Point p4 = new Point(2*s, d);
  Point p5 = new Point(0, 1.5*-s+d);
  
  beginShape();
  vertex(p1.x, p1.y);
  bezierVertex(p1.x, p1.y-2*s, p3.x, p3.y-2*s, p3.x, p3.y);
  vertex(p1.x, p1.y);
  bezierVertex(p1.x, p1.y, p3.x, p3.y, p3.x, p3.y);
  bezierVertex(p3.x, p3.y, p4.x, p4.y, p4.x, p4.y);
  bezierVertex(p4.x, p4.y-2*s, p0.x, p0.y-2*s, p0.x, p0.y);
  endShape();
}

class Point {
  public float x, y;

  Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
}

