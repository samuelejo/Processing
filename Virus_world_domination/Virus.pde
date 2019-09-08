class Point {
  float x, y;
  boolean dead;

  Point() {
    dead = false;
    noStroke();
  }

  void setXY(float x_, float y_) {
    x = x_;
    y = y_;
  }

  void display() {
    if (!dead) {
      ellipse(x, y, 1, 1);
    }
  }

  void walk() {
    int choice = int(random(4));

    if (choice == 0) {
      x += 1;
    } else if (choice == 1) {
      x -= 1;
    } else if (choice == 2) {
      y += 1;
    } else {
      y -= 1;
    }
  }

  void checkColor() {
    color c = globalMap.get(int(x), int(y));

    if (c <= color(250, 250, 250)) {
      fill(255, 0, 0);
    } else {
      fill(255);
      dead = true;
    }
  }
}