Point[] points = new Point[1000];

PImage globalMap;
int t = 0;

void setup() {
  size(1414, 655);
  background(255);
  globalMap = loadImage("globalMap.png");

  for (int i = 0; i < points.length; i++) {
    points[i] = new Point();
  }
  
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      color t = globalMap.get(int(x), int(y));
      if (t <= color(250, 250, 200)) {
        fill(20, 162, 18);
        ellipse(x, y, 1, 1);
      } else {
        fill(255);
        ellipse(x, y, 1, 1);
      }
    }
  }
}

void mousePressed() {
  t ++;
  points[t-1].setXY(mouseX, mouseY);
}

void draw() {  
  for (int j = 0; j < t; j++) {
    for (int i = 0; i < 10; i++) {
      points[j].walk();
      points[j].display();
      points[j].checkColor();
    }
  }
}