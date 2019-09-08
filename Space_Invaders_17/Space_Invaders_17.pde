/*How to play:
 -Left & right arrows to move.
 -Space key to shoot.
 -When Super Power is ready, a red sign will appear.
 -To trigger the super power, use the ENTER. It costs 100 points.
 -Try to survive as many phases as possible.
 
 
 //sound deactivated for non-working issues.//
 */
import processing.sound.*;

Conf conf;
PFont fontA;
Ship ship;
Fleet fleet;
Laser laser;
MotherShip motherShip;
ArrayList<Ship> livesFeedBck;
ArrayList<Shield> shields;

SoundFile Laser;
SoundFile GameOver;
SoundFile OpeningTheme;

boolean wordBlink;
int laserWaitTime;

void setup() {
  size(500, 430);
  conf = new Conf();
  frameRate(40);
  fontA = loadFont("AnonymousPro-Bold-48.vlw");
  Laser    = new SoundFile(this, "Laser.mp3");
  GameOver = new SoundFile(this, "GameOver.mp3");
  OpeningTheme = new SoundFile(this, "OpeningTheme.mp3");
  initGame();
}

void draw() {
  println(laserWaitTime);
  displayScore();
  if (conf.lives <= 0) {
    gameOver();
    return;
  }
  laser.display();
  ship.display();
  fleet.display();
  motherShip.display();



  fleet.update();
  laser.update();
  updateShip();
  updateMother();

  for (Shield s : shields) {
    s.display();
    s.contact(laser);
    s.contactList(fleet.getLasers());
    s.contactInvader(fleet.getInvaders());
  }

  conf.lives = (fleet.checkShipContact(ship))?0:conf.lives;
  conf.score += motherShip.checkContact(laser);
  conf.score += fleet.checkLaserContact(laser);
  for (Laser invaderLaser : fleet.getLasers()) {
    if (ship.contact(invaderLaser)) {
      invaderLaser.setaLive(false); 
      conf.lives--;
    }
  }

  if (fleet.everyInvadersAreDead()) {
    fleet = new Fleet();
    conf.phase +=1;
    if (conf.lives < 4)
      conf.lives += 1;
  }
}


void updateShip() {
  if (conf.Ri == true) {
    ship.moveRight();
  }
  if (conf.Le == true) {
    ship.moveLeft();
  }
  if (conf.Ti == true) {
    if (!laser.aLive) {
      laser = new Laser(ship.location.x, false);
    }
  }
  if (conf.Sp == true) {
    if (!laser.aLive) {
      if (conf.score >= 100 && laserWaitTime >= 80) {
        laser = new Laser(ship.location.x, true);
        laserWaitTime = 0;
        conf.score -= 100;
      } else if (conf.score > 500 && laserWaitTime < 80) {
        laser = new Laser(ship.location.x, true);
        laserWaitTime = 0;
        conf.score -= 500;
      }
    }
  }
}

void keyPressed() {
  if (keyCode == RIGHT) {
    conf.Ri = true;
  }
  if (keyCode == LEFT) {
    conf.Le = true;
  }
  //if (key == ' ') {
  if (keyCode == UP) {
    conf.Ti = true;
  }
  if (keyCode == ENTER) {
    conf.Sp = true;
  }
}

void keyReleased() {
  if (keyCode == SHIFT) {
    ship.shipVelocity = 4;
    conf.score += 500;
  }
  if (keyCode == RIGHT) {
    conf.Ri = false;
  }
  if (keyCode == LEFT) {
    conf.Le = false;
  }
  //if (key == ' ') {
  if (keyCode == UP) {
    conf.Ti = false;
  }
  if (keyCode == ENTER) {
    conf.Sp = false;
  }
}

void updateMother() {
  if (motherShip.aLive) {
    motherShip.update();
  } else {
    if (frameCount % 60 == 0 && random(100) > 85) {
      motherShip.launchMotherShip(random(100) > 50);
    }
  }
}

void initializeSheild() {
  shields = new ArrayList<Shield>();
  for (int i = 0; i < 4; i++) {
    shields.add(new Shield(i * 125 + 45, 310));
  }
}

void initGame() {
  conf.overSound = true;
  conf.shotSound = true;
  conf.openingthemeSound = true;

  OpeningTheme.stop();

  ship = new Ship();
  fleet = new Fleet();
  laser = new Laser(ship.location.x, false);
  laser.setaLive(false);
  motherShip = new MotherShip();
  initializeSheild();
  conf.score = 0;
  conf.lives = 1;
  conf.phase = 1;
  livesFeedBck = new ArrayList<Ship>();
  for (int i = 0; i < conf.lives; i++) {
    livesFeedBck.add(new Ship(width - 40 - 40 * i, height / 15));
  }
}

void displayScore() {
  background(0);
  fill(255);
  textFont(fontA, 15);
  textAlign(LEFT);
  text("Score: " + conf.score, width / 20, height / 15);
  text("Phase: " + conf.phase, width / 20, height / 15 + 20);
  strokeWeight(2);
  stroke(0, 255, 0);
  line(0, 9 * height / 10 + 20, width, 9 * height / 10 + 20);
  for (int i = 0; i < conf.lives; i++) {
    Ship ship = livesFeedBck.get(i);
    ship.display();
  }
  if (wordBlink) {
    fill(255, 0, 0);
    wordBlink = false;
  } else {
    fill(0);
    wordBlink = true;
  }

  if (conf.score >= 100 && laserWaitTime >= 80) {
    if (conf.lives != 0)
      text("SUPER POWER READY FOR 100", width/20, height/15 + 40);
  } else if (conf.score >= 500 && laserWaitTime < 80) {
    if (conf.lives != 0)
      text("SUPER POWER READY FOR 500", width/20, height/15 + 40);
  }
}

void gameOver() {
  int blink = 1;

  fill(255);
  textFont(fontA, 35);
  textAlign(CENTER);
  text("GAME OVER", width / 2, height / 2);
  textFont(fontA, 15);
  text("Score: " + conf.score, width / 2, 3 * height / 4);
  text("Phase: " + conf.phase, width / 2, 20 + 3 * height / 4);
  if (frameCount % 10 == 0 && blink == 1) {
    fill(0);
  } else if (frameCount % 10 == 0 && blink == -1) {
    fill(255);
  } 
  blink *= -1;

  textFont(fontA, 25);
  text("INSERT A COIN", width / 2, 40 + height / 2);
  if (conf.overSound) {
    GameOver.play();
    conf.overSound = false;
  }
  if (frameCount % 160 == 0 && conf.openingthemeSound) {
    OpeningTheme.loop();
    conf.openingthemeSound = false;
  }

  if (mousePressed) {
    initGame();
  }
}