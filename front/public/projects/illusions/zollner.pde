int gap = 50;
int off = 100+gap/2;
int angle = 21;
int len = 80;
int k = 1;
boolean intersect = true;

void setup() {
  size(600, 600);
  noLoop();
}

void draw() {
  background(255);

  stroke(0);
  
  fill(0);
  String angStr = str(angle);
  if (angle > 90)
    angStr = str(180-angle);
  textSize(16);
  text("intersection angle: "+angStr, 30, 30);

  float x, y;
  for (int j=1; j<=k; j++) {
    strokeWeight(3);
    line(j*width/(k+1), 100, j*width/(k+1), height-100);

    // change line dir
    int ang;
    if (j%2 == 1)
      ang = 90-angle;
    else
      ang = 90+angle;

    //strokeWeight(2);
    for (int i=0; i<8; i++) {
      translate(j*width/(k+1), off+i*gap);

      x = cos(radians(ang))*len;
      y = sin(radians(ang))*len;

      if (intersect)
        // intersecting lines
        line(-x/2, -y/2, x/2, y/2);

      else {
        // quarter lines (that don't intersect)
        line(-x/2, -y/2, -x/4, -y/4);
        line(x/4, y/4, x/2, y/2);
      }

      resetMatrix();
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (angle < 178) angle += 3; }
    else if (keyCode == DOWN) {
      if (angle > 2) angle -= 3; }
    else if (keyCode == LEFT) {
      if (len > 10) len -= 10; }
    else if (keyCode == RIGHT) {
      if (len < width) len += 10; }
  }
  else if (key == ' ') {
    intersect = !intersect;
  }
  // parse num lines
  else {
    int temp = int(key - 48);
    if (temp >= 1 && temp <= 9)
      k = temp;
  }

  redraw();
}

