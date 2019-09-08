class Laser extends Entity {

  float speedy;
  int type;
  int mult;
  int lives;
  boolean allysDead;

  Laser(float x_, float y_) {
    super(new PVector(x_, y_));
    super.setHitbox(new PVector(-3, -15), new PVector(8, 15));
    speedy = -3;
    type = 2;
  }

  Laser(float x, boolean dead) {
    super( new PVector(x, 9 * height / 10));
    super.setHitbox(new PVector(-1, -10), new PVector(2, 10));
    type = 1;
    allysDead = dead;
    if (!dead) mult = 1; 
    else mult = 2;
  }


  void display() {
    if (!aLive) {
      conf.shotSound = true;
      return;
    }
    if (type == 1) {
      if (!allysDead) {
        speedy = 8f;
        lives = 1;
        stroke(255);
        strokeWeight(2);
        line(location.x, location.y, location.x, location.y - 10);
        if (conf.shotSound) {
          Laser.play();
          conf.shotSound = false;
        }
      } else {
        speedy = 6f;
        lives = 2;
        stroke(127, 0, 255);
        strokeWeight(6);
        line(location.x, location.y, location.x, location.y -20);
      }
    } else {
      stroke(255, 0, 0);
      strokeWeight(4);
      line(location.x + 3, location.y, location.x + 3, location.y - 12);
    }
  }

  void update() {
    location.y = location.y - speedy;
    if (location.y < 0 || location.y > height + 15) {
      aLive = false;
    }
  }

  void laserExplotion(float x_, float y_, ArrayList lasers, Laser l) {
    createExplotion(x_, y_);
    lasers.remove(l);
  }

  void createExplotion(float x_, float y_) {
    stroke(0, 255, 0);
    strokeWeight(2);
    int[][] deadLaser = {
      {1, 0, 0, 1}, 
      {0, 1, 0, 0}, 
      {0, 0, 0, 1}, 
      {0, 0, 1, 0}, 
      {0, 0, 0, 0}, 
      {0, 1, 0, 1}, 
      {0, 0, 0, 0}, 
      {1, 0, 0, 1}, 
      {0, 0, 0, 0}, 
      {0, 1, 0, 0}, 
      {0, 0, 1, 0}, 
      {1, 0, 0, 1}, };

    noStroke();
    fill(255, 0, 0);
    rectMode(CENTER);
    for (int i = 0; i < 12; i++) {
      for (int j = 0; j < 4; j++) {
        if (deadLaser[i][j] == 1) {
          rect(j + x_, i + y_, 1, 1);
        }
      }
    }
  }
}