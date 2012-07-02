int SIZE = 600;
int squares = 15;
int s = SIZE/squares;
int SPACE = 15;
int wave = 2;
color back = color(0, 100, 200);
color front = color(100, 220, 35);

int[] edges4 = {
  1, 1, 0, 0
};
int[] edges3 = {
  0, 1, 1, 0
};
int[] edges2 = {
  0, 0, 1, 1
};
int[] edges1 = {
  1, 0, 0, 1
};

void setup() {
  //println(s);
  size(SIZE+SPACE, SIZE+SPACE);
  noLoop();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) squares++;
    else if (keyCode == DOWN) squares--;
    else if (keyCode == RIGHT) wave++;
    else if (keyCode == LEFT) wave--;
  }
  if (wave <= 0) wave++;
  if (squares <= 0) squares++;
  s = SIZE/squares;
  
  redraw();
}

void draw() {
  background(back);

  for (int y=0; y<squares; y++) {
    for (int x=0; x<squares; x++) {
      //      if ((x%2 == 0 && y%2 == 0)
      //        || (x%2 == 1 && y%2 == 1)) {
      translate(x*s, y*s);

      int w = 4*wave;

      int d = (x-y) % w;
      if (d < 0) {
        d = w+d;//(w - d) % w;
      }

      if (d == -1)
        drawSquare(SPACE, SPACE, s-SPACE, edges4);

      //      if (d < 0) {
      //        d = (y-x)%12;
      //      }
      if (d >= 0 && d < wave) {
        //rotate(-PI/40);
        drawSquare(SPACE, SPACE, s-SPACE, edges1);
      }
      else if (d >= wave && d < 2*wave) {
        //rotate(-PI/40);
        drawSquare(SPACE, SPACE, s-SPACE, edges2);
      }
      else if (d >= 2*wave && d < 3*wave) {
        //rotate(-PI/40);
        drawSquare(SPACE, SPACE, s-SPACE, edges3);
      }
      else if (d >= 3*wave && d < 4*wave) {
        //rotate(-PI/40);
        drawSquare(SPACE, SPACE, s-SPACE, edges4);
      }

      resetMatrix();
    }
  }
}


void drawSquare(int x, int y, int s, int[] edges) {

  fill(front);
  noStroke();
  rect(x, y, s, s);

  noFill();
  strokeWeight(2);

  // draw whites
  stroke(255);
  for (int i=0; i<edges.length; i++)
    if (edges[i] == 1)
      drawEdge(i, x, y, s);

  // draw blacks
  stroke(0);
  for (int i=0; i<edges.length; i++)
    if (edges[i] == 0)
      drawEdge(i, x, y, s);
}

void drawEdge(int i, int x, int y, int s) {
  switch(i) {
  case 0:
    line(x, y, x+s, y);
    break;
  case 1:
    line(x+s, y, x+s, y+s);
    break;
  case 2:
    line(x, y+s, x+s, y+s);
    break;
  case 3:
    line(x, y, x, y+s);
    break;
  default: 
    break;
  }
}

