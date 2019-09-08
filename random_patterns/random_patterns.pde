float ri = 400;
float ai = 0.0;
float r;
float a;
float rc;
float ac;
//////////////////////////////////////////////////////////////////////////////////////
float R;
float G;
float B;
float Ri;
float Gi;
float Bi;
float Rf;
float Gf;
float Bf;
float Rc;
float Gc;
float Bc;
//////////////////////////////////////////////////////////////////////////////////////
int j;
int Number = 1;
boolean start = true;
boolean fullscreen = true;

void setup() {
  fullScreen();
  background(0);
  //println("hello");
}

void mousePressed() {
  Start();
}

void keyPressed() {
  if (key == ' ') {
    println(" ");
    println(" ");
    println(" ");
    println(" ");
    println("NUMBER: ");
    println(Number);
    println("Ri");
    println(Ri);
    println("Rf");
    println(Rf);
    println("Gi");
    println(Gi);
    println("Gf");
    println(Gf);
    println("Bi");
    println(Bi);
    println("Bf");
    println(Bf);

    Number += 1;
  }
}

void draw() {
  checkfs();
  if (start) {
    Start();
  } else {
    create();
    create();
  }

  if (j >= ri/rc) {
    delay(5000);
    start = true;
  }
}
//////////////////////////////////////////////////////////////////////////////////////











//////////////////////////////////////////////////////////////////////////////////////
void create() {
  float x = r * cos(a);
  float y = r * sin(a);

  display(x, y);

  a += ac;
  r -= rc;

  j++;
}
//////////////////////////////////////////////////////////////////////////////////////
void Start() {
  background(0);
  setColors();
  fill(random(255), random(255), random(255));

  r = ri;
  a = ai;
  rc = random(0.1, 0.5);
  ac = random(0.05, 50);

  numberValues();
  colorValues();
  j = 0;
  start = false;
}
//////////////////////////////////////////////////////////////////////////////////////
void display(float x, float y) {
  updateColors();

  noStroke();
  ellipse(x, y, 10, 10);
}
//////////////////////////////////////////////////////////////////////////////////////
void numberValues() {
  PVector v1;
  PVector v2;
  if (fullscreen) {
    v1 = new PVector(-width/2 + 10, -height/2 + 74);
    v2 = new PVector(-width/2 + 10, -height/2 + 148);
  } else {
    v1 = new PVector(-(3 * width/8) + 10, -height/2 + 74);
    v2 = new PVector(-(3 * width/8) + 10, -height/2 + 148);
  }
  PFont f = createFont("AR CHRISTY", 64);

  fill(255);
  noStroke();

  textFont(f);
  text(rc, v1.x, v1.y);
  text(ac, v2.x, v2.y);
}
//////////////////////////////////////////////////////////////////////////////////////
void colorValues() {
  PVector v1;
  PVector v2;
  PVector v3;

  String ri = "Ri";
  String gi = "Gi";
  String bi = "Bi";

  String rf = "Rf";
  String gf = "Gf";
  String bf = "Bf";

  v1 = new PVector(3 * width/8 - 5, -height/2 + 74);
  v2 = new PVector(3 * width/8 - 5, -height/2 + 148);
  v3 = new PVector(3 * width/8 - 5, -height/2 + 222);

  PFont f = createFont("AR CHRISTY", 50);

  fill(255);
  noStroke();
  textFont(f);

  text(Ri, v1.x, v1.y);
  text(ri, v1.x - 60, v1.y);
  text(Rf, v1.x, v1.y + 60);
  text(rf, v1.x - 60, v1.y + 60);

  text(Gi, v1.x, v1.y + 130);
  text(gi, v1.x - 60, v1.y + 130);
  text(Gf, v1.x, v1.y + 190);
  text(gf, v1.x - 60, v1.y + 190);

  text(Bi, v1.x, v1.y + 260);
  text(bi, v1.x - 60, v1.y + 260);
  text(Bf, v1.x, v1.y + 320);
  text(bf, v1.x - 60, v1.y + 320);
}
//////////////////////////////////////////////////////////////////////////////////////
void checkfs() {
  if (fullscreen) {
    translate(width/2, height/2);
  } else {
    translate(3 * width/8, height/2);
  }
}
//////////////////////////////////////////////////////////////////////////////////////
void setColors() {
  Ri = int(random(255));
  R = Ri;
  Gi = int(random(255));
  G = Gi;
  Bi = int(random(255));
  B = Bi;

  Rf = int(random(255));
  Gf = int(random(255));
  Bf = int(random(255));

  Rc = (Ri - Rf)/(ri/rc);
  Gc = (Gi - Gf)/(ri/rc);
  Bc = (Bi - Bf)/(ri/rc);
}
//////////////////////////////////////////////////////////////////////////////////////
void updateColors() {
  R -= Rc;
  G -= Gc;
  B -= Bc;

  fill(R, G, B);
}