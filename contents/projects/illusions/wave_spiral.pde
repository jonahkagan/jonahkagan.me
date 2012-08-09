int SIZE = 600;
int layers = 10;
int numUnits = 80;

boolean aligned = false;

void setup() {
  size(SIZE, SIZE);
  noLoop();
}

void keyPressed() {
  // align motion
  if (key == ' ')
    aligned = !aligned;
    
  redraw();
}

void draw() {
  background(125);
  
  resetMatrix();

  translate(width/2, height/2);
  pushMatrix();

  float r = 1;
  int dir = 1;
  float s;
  while (r < width) {
    s = drawCirc(r, dir);
    if (!aligned)
      dir -= dir*2;
    r += s*1.3;
  }
  
}

// dir is 1 for left to right, -1 for right to left
float drawCirc(float r, int dir) {
  noStroke();

  color darkest = color(0);
  color lightest = color(255);
  color middark = color(#2643FA);//#0000EE);
  color midlight = color(#D1E231);

  float d = TWO_PI*r/numUnits;
  float s = 4*d/5;
  float angOff = 0;//PI/5;

  // draw bigs
  float interval = 2*asin(d/(2*r));
  boolean c = true;
  for (float ang=0; ang<TWO_PI; ang+=interval) {
    translate(r*cos(ang), r*sin(ang));
    rotate(ang);
    // switch direction
    if (dir == -1)
      rotate(PI);
    // switch colors
    if (c)
      fill(middark);
    else
      fill(midlight);
    c = !c;
    drawCurve(s, d);
    popMatrix();
    pushMatrix();
  }

  d = s/4;

  // draw smalls
  c = true;
  for (float ang=0+angOff; ang<TWO_PI+angOff; ang+=interval) {
    translate(r*cos(ang), r*sin(ang));
    rotate(ang+.13);
    if (dir == -1)
      rotate(PI);
    if (c)
      fill(darkest);
    else
      fill(lightest);
    c = !c;
    drawCurve(s, d);
    popMatrix();
    pushMatrix();
  }

  // return size to inc radius
  return 4*s;
}

void drawCurve(float s, float d) {
  float warp = d/4;
  
  Point p0 = new Point(2*-s, d);
  Point p1 = new Point(2*-s, 0);
  Point p2 = new Point(0, 1.5*-s);
  Point p3 = new Point(2*s, 0);
  Point p4 = new Point(2*s, d);
  Point p5 = new Point(0, 1.5*-s+d);
  
  beginShape();
  vertex(p1.x, p1.y);
  bezierVertex(p1.x, p1.y-2*s, p3.x, p3.y-2*s, p3.x, p3.y);
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
