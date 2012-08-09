
int colWidth = 50;
int rowHeight = 30;
int cols, rows;

int xoff = colWidth/2;
int yoff = rowHeight/2;

int up = 0;
int down = 255;

float ang = PI/4;
float interval = radians(3);

boolean showBars = false;

PFont font;

void setup() {
  size(600, 600);
  noLoop();

  font = loadFont("_sans");
  textFont(font, 13);

  cols = width/colWidth;
  rows = height/rowHeight;
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT)
      if (ang > -PI/2) ang -= interval;
    if (keyCode == RIGHT)
      if (ang < PI/2) ang += interval;
  }
  else if (key == ' ')
    showBars = !showBars;

  redraw();
}

void draw() {
  background(150);

  for (int x=0; x<cols; x++)
    for (int y=0; y<rows; y++) {
      translate(xoff, yoff);
      translate(x*colWidth, y*rowHeight);
      
      int xmin = cols/4;
      int xmax = 2*cols/3;
      int ymin = rows/4;
      int ymax = 2*rows/3;
      
      if (x < xmin || x > xmax
        || y < ymin || y > ymax)
        rotate(ang);
      else {
        rotate(-ang);
      } 
        
      drawTilt();
      resetMatrix();
    }

  if (showBars) {
    fill(0);

    int col1 = 1*cols/4;
    int col2 = 2*cols/4;
    int col3 = 3*cols/4;

    //      println(col1+" "+col2+" "+col3);

    rect (0, 0, col1*colWidth-5, height);
    rect ((col1+1)*colWidth, 0, (col2-(col1+1))*colWidth-5, height);
    rect ((col2+1)*colWidth, 0, (col3-(col2+1))*colWidth-5, height);
    rect ((col3+1)*colWidth, 0, width, height);
  }

  fill(0);
  rect(0, 0, 75, 20);
  fill(255);
  String angStr = str(round(degrees(PI/2-ang)));
  if (ang < 0)
    angStr = str(round(degrees(-PI/2-ang)));
  text("Angle: "+angStr, 5, 15);
}

void drawTilt() {
  translate(-23, 0);
  drawT();
  translate(13, 0);
  drawI();
  translate(10, 0);
  drawL();
  translate(10, 0);
  drawT();
}

void drawT() {
  pushMatrix();
  fill(down);
  translate(0, 10);
  text("T", 0, 0);
  fill(up);
  rotate(PI);
  translate(-8, 20);
  text("T", 0, 0);
  popMatrix();
}

void drawI() {
  pushMatrix();
  fill(down);
  translate(0, 10);
  text("I", 0, 0);
  fill(up);
  rotate(PI);
  translate(-4, 20);
  text("I", 0, 0);
  popMatrix();
}

void drawL() {
  pushMatrix();
  fill(down);
  translate(0, 10);
  text("L", 0, 0);
  fill(up);
  rotate(PI);
  translate(-4, 20);
  text("L", 0, 0);
  popMatrix();
}

