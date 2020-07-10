/*
  Desrciption: Nick_fury
 Author: Mostafa Hussein
 Date of last edit: 28,OCT,2019
 */

/*instructions
 at the start screen of the program the helicarrier can be moved using A and D on the keyboard
 if enter is pressed the program works
 The music will be playing to stop it press P on the keyboard
 to open the "Shield AI" press on the shield logo top left 
 the shield AI menu will pop up, press on the wanted catg. to open it
 the Combat system it clears the "planes and clouds" and leaves a pointer to shoot lasers into nothing
 there is a mega laser that charges and charges slower as u shoot the normal laser
 the lasers work as the mouse is DRAGGED
 the megalaser works until mouse is released even if it isnt fully drained
 the contacts contains 3 contacts (voice lines from marvel movies)
 press on the wanted contact to start the voice line
 the menu button goes  back to start screen where there is a hellicarrier third person view and it can be controlled A and D
 the Game button starts a replica of space invaders that is just 1 circle(enemy) and shoots one laser at a time with the score being frame controlled in the code
 the ship can work using the right and left arrows and the up arrow shoots the lasers
 for every enemy hit a new one starts in a random spawn zones (there is around 8 spawn areas)
 for every enemy u get 10 points
 it is possible to restart the game when it's over if the blue circle is pressed in the middle
 
 Extras:
 the sheild logo stays open while the shield AI is on, but if pressed the sheild AI can close
 when a sub menu or game is open the back key returns you back to the main one
 
 
 Finally :
 Esc (by default in processing) closes the program
 pressing ctrl+shift+r starts the program in full screen
 it takes a bit to load with the sound files
 */


import processing.sound.*;

PImage img;
PImage sheildLogo;

PFont sheildFont;


SoundFile introMusic;
SoundFile Initiated;
SoundFile CombatSystem;
SoundFile CombatSystemOff;
SoundFile MegaLaser;
SoundFile MegaLaserOn;
SoundFile LaserSound;
SoundFile Menu;
SoundFile ShieldApp;
SoundFile captinVoice;
SoundFile spiderVoice;
SoundFile happyVoice;
SoundFile starkVoice;

Boolean programOn = false, happy = false, stark = false, captin = false, spiderMan=false, ContactsOn = false, GameOn= false, pause = false, musicPaused = false, soundPlayed = false, sheildApp = false, mouseOverLogo, laserPlayed = false, cleanAnimation= false, Idle = true, menuOn = true, menuChoicesOn, combat = false, laser = false, skyCleared = false, MegaLaserReady = false, drainingMegaLaser = false, sayCapacity = false, dontSayAgain = false;

int sheildSize, logoOffset, menuOffsetX, menuOffsetY;

float leftCloudOffset, megaLaserCharge = 0, planeOffsetX = 0, planeOffsetY = 0, planeOffsetX_2 = 0, planeOffsetY_2 = 0;

int beginingPositionX = 42, endingPositionX = 142, beginingPositionY = 67, endingPositionY = 167, craftOffsetY = 2, craftStartX, craftPositionX, craftMovementX = 0, craftColour, randomColour;

// minigame laser variables----------------------------------------------------------------------------
Boolean leftAllowed = true, rightAllowed = true, newLaser = true, enemy = false, GameOver = false;


int[] laserX = {-100};

int arrayNum = 0, laserYOffset = 100, enemyPosition, strokeColour;
// minigame laser variables end------------------------------------------------
//points is for the game and ship is for in the menu
int points=0, shipMovementOffset = 0;




void settings() {
  size(295, 350); //sets size
  //img = loadImage("background_fury.jpg"); used to draw
  //sheildLogo = loadImage("images.png"); used to draw
  //sheildLogo.resize(47, 20); used to draw
}

void setup() {
  //locates background sound for program and lowers the amp
  introMusic = new SoundFile(this, "sample.mp3");
  introMusic.amp(0.25);

  //sets the custom font wanted
  sheildFont = createFont("Arial Bold", 18);

  //sets the offset for thte menu option sizes
  menuOffsetX = 0;
  menuOffsetY = 0;
  menuChoicesOn = true;

  //locates the sound Files

  Initiated = new SoundFile(this, "transcript.wav");
  CombatSystem = new SoundFile(this, "transcript2.wav");
  CombatSystemOff = new SoundFile(this, "transcript3.wav");
  MegaLaser = new SoundFile(this, "transcript4.wav");
  MegaLaserOn = new SoundFile(this, "transcript5.wav");
  LaserSound = new SoundFile(this, "laser.wav");
  Menu = new SoundFile(this, "menu.wav");
  ShieldApp = new SoundFile(this, "sheildApp.wav");
  spiderVoice = new SoundFile(this, "SpiderMan.wav");
  captinVoice = new SoundFile(this, "Captin.wav");
  happyVoice = new SoundFile(this, "Happy.wav");


  //game setup start -----
  craftStartX = endingPositionX/2;

  //the random colour (gray or white) for the minigame
  randomColour = int(random(1, 2));
  if (randomColour == 2) {
    craftColour = 200;
  } else {
    craftColour = 255;
  }
  enemy = true;
  enemyPosition = int(random(1, 8))*10;
  //game setup end -----
}

void draw() {
  noStroke();
  strokeWeight(10);
  // image(img, 0, 0);
  background(2, 111, 149);
  sheildSize = 51;
  logoOffset = 0;

  //start menu
  if (programOn == false) {
    fill(255, 255, 255, 100);
    rect(-4, -4, width+4, height+4);

    //clouds
    noStroke();
    fill(255, 255, 255, 100);
    if (skyCleared == false) {
      ellipse(leftCloudOffset +250, 212, 50, 50); 
      ellipse(leftCloudOffset +40, 210, 50, 50); 
      ellipse(leftCloudOffset +19, 209, 50, 50); 
      ellipse(leftCloudOffset +17, 253, 50, 50); 
      ellipse(leftCloudOffset +54, 267, 50, 50); 
      ellipse(leftCloudOffset +5, 292, 50, 50); 
      ellipse(leftCloudOffset +39, 213, 50, 50); 
      ellipse(leftCloudOffset +65, 201, 50, 50); 
      ellipse(leftCloudOffset +39, 195, 50, 50);
      ellipse(leftCloudOffset +10, 274, 50, 50); 
      ellipse(leftCloudOffset +30, 284, 50, 50); 
      ellipse(leftCloudOffset +11, 302, 50, 50); 
      ellipse(leftCloudOffset +34, 311, 50, 50); 
      ellipse(leftCloudOffset +66, 299, 50, 50); 
      ellipse(leftCloudOffset +57, 333, 50, 50); 
      ellipse(leftCloudOffset +14, 335, 50, 50); 
      ellipse(leftCloudOffset +31, 320, 50, 50); 
      ellipse(leftCloudOffset +82, 313, 50, 50); 
      ellipse(leftCloudOffset +84, 289, 50, 50); 
      ellipse(leftCloudOffset +70, 275, 50, 50); 
      ellipse(leftCloudOffset +74, 319, 50, 50); 
      ellipse(leftCloudOffset +89, 302, 50, 50); 
      ellipse(leftCloudOffset +94, 279, 50, 50); 
      ellipse(leftCloudOffset +85, 254, 50, 50); 
      ellipse(leftCloudOffset +58, 237, 50, 50); 
      ellipse(leftCloudOffset +23, 212, 50, 50); 
      ellipse(leftCloudOffset +4, 218, 50, 50); 
      ellipse(leftCloudOffset +64, 215, 50, 50); 
      ellipse(leftCloudOffset +89, 226, 50, 50); 
      ellipse(leftCloudOffset +114, 233, 50, 50); 
      ellipse(leftCloudOffset +133, 262, 50, 50); 
      ellipse(leftCloudOffset +123, 290, 50, 50); 
      ellipse(leftCloudOffset +138, 312, 50, 50); 
      ellipse(leftCloudOffset +104, 316, 50, 50); 
      ellipse(leftCloudOffset +109, 337, 50, 50); 
      ellipse(leftCloudOffset +153, 339, 50, 50); 
      ellipse(leftCloudOffset +173, 309, 50, 50); 
      ellipse(leftCloudOffset +162, 290, 50, 50); 
      ellipse(leftCloudOffset +150, 261, 50, 50); 
      ellipse(leftCloudOffset +170, 244, 50, 50); 
      ellipse(leftCloudOffset +189, 270, 50, 50); 
      ellipse(leftCloudOffset +187, 293, 50, 50); 
      ellipse(leftCloudOffset +186, 329, 50, 50); 
      ellipse(leftCloudOffset +211, 335, 50, 50); 
      ellipse(leftCloudOffset +234, 335, 50, 50); 
      ellipse(leftCloudOffset +232, 316, 50, 50); 
      ellipse(leftCloudOffset +214, 295, 50, 50); 
      ellipse(leftCloudOffset +194, 285, 50, 50); 
      ellipse(leftCloudOffset +192, 309, 50, 50); 
      ellipse(leftCloudOffset +239, 325, 50, 50); 
      ellipse(leftCloudOffset +272, 330, 50, 50); 
      ellipse(leftCloudOffset +288, 324, 50, 50); 
      ellipse(leftCloudOffset +278, 300, 50, 50); 
      ellipse(leftCloudOffset +241, 298, 50, 50); 
      ellipse(leftCloudOffset +232, 280, 50, 50); 
      ellipse(leftCloudOffset +245, 263, 50, 50); 
      ellipse(leftCloudOffset +229, 253, 50, 50); 
      ellipse(leftCloudOffset +202, 239, 50, 50); 
      ellipse(leftCloudOffset +172, 227, 50, 50); 
      ellipse(leftCloudOffset +146, 222, 50, 50); 
      ellipse(leftCloudOffset +105, 216, 50, 50); 
      ellipse(leftCloudOffset +99, 204, 50, 50); 
      ellipse(leftCloudOffset +77, 193, 50, 50); 
      ellipse(leftCloudOffset +33, 184, 50, 50); 
      ellipse(leftCloudOffset +18, 168, 50, 50); 
      ellipse(leftCloudOffset +12, 164, 50, 50); 
      ellipse(+leftCloudOffset-6, 189, 50, 50); 
      ellipse(+leftCloudOffset-34, 213, 50, 50); 
      ellipse(+leftCloudOffset-56, 224, 50, 50); 
      ellipse(+leftCloudOffset-139, 324, 50, 50); 
      ellipse(+leftCloudOffset-163, 332, 50, 50); 
      ellipse(+leftCloudOffset-87, 329, 50, 50); 
      ellipse(+leftCloudOffset-60, 329, 50, 50); 
      ellipse(+leftCloudOffset-40, 312, 50, 50); 
      ellipse(+leftCloudOffset-32, 285, 50, 50); 
      ellipse(+leftCloudOffset-61, 309, 50, 50); 
      ellipse(+leftCloudOffset-4, 277, 50, 50); 
      ellipse(+leftCloudOffset-17, 346, 50, 50); 
      ellipse(+leftCloudOffset-64, 282, 50, 50); 
      ellipse(+leftCloudOffset-21, 324, 50, 50); 
      ellipse(+leftCloudOffset-99, 288, 50, 50); 
      ellipse(+leftCloudOffset-65, 195, 50, 50); 
      ellipse(+leftCloudOffset-11, 189, 50, 50); 
      ellipse(+leftCloudOffset-136, 320, 50, 50); 
      ellipse(+leftCloudOffset-167, 234, 50, 50);
      ellipse(leftCloudOffset+284, 263, 50, 50); 
      ellipse(leftCloudOffset+287, 245, 50, 50); 
      ellipse(leftCloudOffset+255, 269, 50, 50); 
      ellipse(leftCloudOffset+287, 242, 50, 50); 
      ellipse(leftCloudOffset+202, 219, 50, 50); 
      ellipse(leftCloudOffset+280, 204, 50, 50); 
      ellipse(leftCloudOffset+214, 201, 50, 50); 
      ellipse(leftCloudOffset+187, 214, 50, 50); 
      ellipse(leftCloudOffset+202, 202, 50, 50); 
      ellipse(leftCloudOffset+240, 194, 50, 50); 
      ellipse(leftCloudOffset+268, 194, 50, 50); 
      ellipse(leftCloudOffset+273, 199, 50, 50); 
      ellipse(leftCloudOffset+283, 205, 50, 50); 

      //cloud movement
      leftCloudOffset += random(.2, 0.7);

      if (leftCloudOffset >= 90) {
        leftCloudOffset = -20;
      }
    }

    //hellicarrier movement
    if (keyPressed) {
      if (key == 'd' || key == 'D') {
        shipMovementOffset += 1;
      }
      if (key == 'a'|| key == 'A') {
        shipMovementOffset -=1;
      }
    }

    //hellicarrier------------------

    fill(60);
    beginShape();
    vertex(105 +shipMovementOffset, 168); 
    vertex(111+shipMovementOffset, 170); 
    vertex(122+shipMovementOffset, 174); 
    vertex(131+shipMovementOffset, 182); 
    vertex(142+shipMovementOffset, 182); 
    vertex(146+shipMovementOffset, 176); 
    vertex(153+shipMovementOffset, 178); 
    vertex(157+shipMovementOffset, 179); 
    vertex(175+shipMovementOffset, 182); 
    vertex(182+shipMovementOffset, 182); 
    vertex(187+shipMovementOffset, 172); 
    vertex(202+shipMovementOffset, 165); 
    vertex(195+shipMovementOffset, 161); 
    vertex(168+shipMovementOffset, 160); 
    vertex(169+shipMovementOffset, 156); 
    vertex(177+shipMovementOffset, 153); 
    vertex(174+shipMovementOffset, 150); 
    vertex(164+shipMovementOffset, 150); 
    vertex(164+shipMovementOffset, 147); 
    vertex(164+shipMovementOffset, 151); 
    vertex(153+shipMovementOffset, 151); 
    vertex(146+shipMovementOffset, 148); 
    vertex(138+shipMovementOffset, 152); 
    vertex(116+shipMovementOffset, 153); 
    vertex(114+shipMovementOffset, 155); 
    vertex(134+shipMovementOffset, 157); 
    vertex(129+shipMovementOffset, 162); 
    vertex(106+shipMovementOffset, 166);
    vertex(105+shipMovementOffset, 168);
    endShape();

    //helicarrier boosters-------------
    //booster 1
    fill(155, 11, 45);
    beginShape();
    vertex(124+shipMovementOffset, 174); 
    vertex(131+shipMovementOffset, 181); 
    vertex(142+shipMovementOffset, 180); 
    vertex(145+shipMovementOffset, 175); 
    vertex(125+shipMovementOffset, 175);
    endShape();
    //booster 2
    beginShape();
    vertex(169+shipMovementOffset, 181);  
    vertex(166+shipMovementOffset, 174); 
    vertex(184+shipMovementOffset, 173); 
    vertex(180+shipMovementOffset, 180);
    vertex(169+shipMovementOffset, 179); 
    endShape();
    //end of hellicarrier boosters -------------
    //end of hellicarrier--------------------
    //start text --------------------------
    textFont(sheildFont);
    fill(255);
    noStroke();
    textSize(10);
    text("Press ENTER to continue", 96, 34);
    //end of  start text------------------------------
  } else if (programOn== true) {  // the actual scene
    noStroke();
    fill(255, 255, 255, 100);
    rect(-3, -3, width+4, height+4);

    if (skyCleared == false) { 
      //planes
      //plane 1
      ellipse((2*width+planeOffsetX), height+planeOffsetY, 5, 5);
      planeOffsetX -= 8;
      planeOffsetY -= 6;
      if ((2*width+planeOffsetX) <= 0) {
        planeOffsetX = 0;
      }
      if ((height+planeOffsetY) <= 0 ) {
        planeOffsetY = 0;
      }
      //plane 2
      ellipse(planeOffsetX_2, planeOffsetY_2+20, 5, 5);
      planeOffsetX_2 += 8;
      planeOffsetY_2 += 6;
      if (planeOffsetX_2 >= width) {
        planeOffsetX_2 = 0;
      }
      if (planeOffsetY_2 >= height ) {
        planeOffsetY_2 = 0;
      }


      //clouds
      noStroke();
      fill(255, 255, 255, 100);
      ellipse(leftCloudOffset +250, 212, 50, 50); 
      ellipse(leftCloudOffset +40, 210, 50, 50); 
      ellipse(leftCloudOffset +19, 209, 50, 50); 
      ellipse(leftCloudOffset +17, 253, 50, 50); 
      ellipse(leftCloudOffset +54, 267, 50, 50); 
      ellipse(leftCloudOffset +5, 292, 50, 50); 
      ellipse(leftCloudOffset +39, 213, 50, 50); 
      ellipse(leftCloudOffset +65, 201, 50, 50); 
      ellipse(leftCloudOffset +39, 195, 50, 50);
      ellipse(leftCloudOffset +10, 274, 50, 50); 
      ellipse(leftCloudOffset +30, 284, 50, 50); 
      ellipse(leftCloudOffset +11, 302, 50, 50); 
      ellipse(leftCloudOffset +34, 311, 50, 50); 
      ellipse(leftCloudOffset +66, 299, 50, 50); 
      ellipse(leftCloudOffset +57, 333, 50, 50); 
      ellipse(leftCloudOffset +14, 335, 50, 50); 
      ellipse(leftCloudOffset +31, 320, 50, 50); 
      ellipse(leftCloudOffset +82, 313, 50, 50); 
      ellipse(leftCloudOffset +84, 289, 50, 50); 
      ellipse(leftCloudOffset +70, 275, 50, 50); 
      ellipse(leftCloudOffset +74, 319, 50, 50); 
      ellipse(leftCloudOffset +89, 302, 50, 50); 
      ellipse(leftCloudOffset +94, 279, 50, 50); 
      ellipse(leftCloudOffset +85, 254, 50, 50); 
      ellipse(leftCloudOffset +58, 237, 50, 50); 
      ellipse(leftCloudOffset +23, 212, 50, 50); 
      ellipse(leftCloudOffset +4, 218, 50, 50); 
      ellipse(leftCloudOffset +64, 215, 50, 50); 
      ellipse(leftCloudOffset +89, 226, 50, 50); 
      ellipse(leftCloudOffset +114, 233, 50, 50); 
      ellipse(leftCloudOffset +133, 262, 50, 50); 
      ellipse(leftCloudOffset +123, 290, 50, 50); 
      ellipse(leftCloudOffset +138, 312, 50, 50); 
      ellipse(leftCloudOffset +104, 316, 50, 50); 
      ellipse(leftCloudOffset +109, 337, 50, 50); 
      ellipse(leftCloudOffset +153, 339, 50, 50); 
      ellipse(leftCloudOffset +173, 309, 50, 50); 
      ellipse(leftCloudOffset +162, 290, 50, 50); 
      ellipse(leftCloudOffset +150, 261, 50, 50); 
      ellipse(leftCloudOffset +170, 244, 50, 50); 
      ellipse(leftCloudOffset +189, 270, 50, 50); 
      ellipse(leftCloudOffset +187, 293, 50, 50); 
      ellipse(leftCloudOffset +186, 329, 50, 50); 
      ellipse(leftCloudOffset +211, 335, 50, 50); 
      ellipse(leftCloudOffset +234, 335, 50, 50); 
      ellipse(leftCloudOffset +232, 316, 50, 50); 
      ellipse(leftCloudOffset +214, 295, 50, 50); 
      ellipse(leftCloudOffset +194, 285, 50, 50); 
      ellipse(leftCloudOffset +192, 309, 50, 50); 
      ellipse(leftCloudOffset +239, 325, 50, 50); 
      ellipse(leftCloudOffset +272, 330, 50, 50); 
      ellipse(leftCloudOffset +288, 324, 50, 50); 
      ellipse(leftCloudOffset +278, 300, 50, 50); 
      ellipse(leftCloudOffset +241, 298, 50, 50); 
      ellipse(leftCloudOffset +232, 280, 50, 50); 
      ellipse(leftCloudOffset +245, 263, 50, 50); 
      ellipse(leftCloudOffset +229, 253, 50, 50); 
      ellipse(leftCloudOffset +202, 239, 50, 50); 
      ellipse(leftCloudOffset +172, 227, 50, 50); 
      ellipse(leftCloudOffset +146, 222, 50, 50); 
      ellipse(leftCloudOffset +105, 216, 50, 50); 
      ellipse(leftCloudOffset +99, 204, 50, 50); 
      ellipse(leftCloudOffset +77, 193, 50, 50); 
      ellipse(leftCloudOffset +33, 184, 50, 50); 
      ellipse(leftCloudOffset +18, 168, 50, 50); 
      ellipse(leftCloudOffset +12, 164, 50, 50); 
      ellipse(+leftCloudOffset-6, 189, 50, 50); 
      ellipse(+leftCloudOffset-34, 213, 50, 50); 
      ellipse(+leftCloudOffset-56, 224, 50, 50); 
      ellipse(+leftCloudOffset-139, 324, 50, 50); 
      ellipse(+leftCloudOffset-163, 332, 50, 50); 
      ellipse(+leftCloudOffset-87, 329, 50, 50); 
      ellipse(+leftCloudOffset-60, 329, 50, 50); 
      ellipse(+leftCloudOffset-40, 312, 50, 50); 
      ellipse(+leftCloudOffset-32, 285, 50, 50); 
      ellipse(+leftCloudOffset-61, 309, 50, 50); 
      ellipse(+leftCloudOffset-4, 277, 50, 50); 
      ellipse(+leftCloudOffset-17, 346, 50, 50); 
      ellipse(+leftCloudOffset-64, 282, 50, 50); 
      ellipse(+leftCloudOffset-21, 324, 50, 50); 
      ellipse(+leftCloudOffset-99, 288, 50, 50); 
      ellipse(+leftCloudOffset-65, 195, 50, 50); 
      ellipse(+leftCloudOffset-11, 189, 50, 50); 
      ellipse(+leftCloudOffset-136, 320, 50, 50); 
      ellipse(+leftCloudOffset-167, 234, 50, 50);
      ellipse(leftCloudOffset+284, 263, 50, 50); 
      ellipse(leftCloudOffset+287, 245, 50, 50); 
      ellipse(leftCloudOffset+255, 269, 50, 50); 
      ellipse(leftCloudOffset+287, 242, 50, 50); 
      ellipse(leftCloudOffset+202, 219, 50, 50); 
      ellipse(leftCloudOffset+280, 204, 50, 50); 
      ellipse(leftCloudOffset+214, 201, 50, 50); 
      ellipse(leftCloudOffset+187, 214, 50, 50); 
      ellipse(leftCloudOffset+202, 202, 50, 50); 
      ellipse(leftCloudOffset+240, 194, 50, 50); 
      ellipse(leftCloudOffset+268, 194, 50, 50); 
      ellipse(leftCloudOffset+273, 199, 50, 50); 
      ellipse(leftCloudOffset+283, 205, 50, 50); 


      leftCloudOffset += random(.2, 0.7);

      if (leftCloudOffset >= 90) {
        leftCloudOffset = -180;
      }
    }

    if (laser == true) {

      if (MegaLaserReady == true) {
        strokeWeight(20);
      } else {
        strokeWeight(2);
      }
      stroke(152, 11, 44);
      line(width/4, height+100, mouseX-5, mouseY);
      line(3*width/4, height+100, mouseX+5, mouseY);

      if (drainingMegaLaser == true) {
        megaLaserCharge -=.2;
        if (int(megaLaserCharge) == 0) {
          MegaLaserReady = false;
          drainingMegaLaser = false;
        }
      }
    }

    //windows ----------------
    fill(50);
    stroke(50);
    beginShape();
    curveVertex(0, 223); 
    curveVertex(0, 223); 
    curveVertex(105, 232);
    curveVertex(291, 232);
    curveVertex(292, 257);
    curveVertex(105, 253);
    curveVertex(4, 243);
    curveVertex(0, 244); 
    curveVertex(0, 244); 
    endShape();


    stroke(139);
    strokeWeight(9);
    line(0, 253, 7, 254);
    line(7, 254, 8, 249);
    line(8, 249, 56, 256);
    line(56, 256, 103, 261);
    stroke(50);

    strokeWeight(13);
    stroke(0);
    line(151, 0, 161, 347);
    stroke(255);
    strokeWeight(4);
    line(151, 0, 161, 347);

    beginShape();
    curveVertex(5, 223); 
    curveVertex(5, 223); 
    curveVertex(105, 232); 
    curveVertex(291, 232); 
    curveVertex(105, 232);   
    curveVertex(5, 223); 
    curveVertex(5, 223); 
    endShape();

    beginShape();
    curveVertex(1, 218); 
    curveVertex(1, 218); 
    curveVertex(7, 221); 
    curveVertex(3, 249); 
    curveVertex(0, 249); 
    endShape();

    beginShape();
    curveVertex(4, 243); 
    curveVertex(4, 243);
    curveVertex(105, 253); 
    curveVertex(292, 257); 
    curveVertex(105, 253); 
    curveVertex(105, 253);
    endShape();
    //end of windows -----------------
    textSize(10);
    if (combat == true) {
      if ((mouseX >= 5 && mouseX <= 64 && mouseY >= 4 && mouseY <= 64) || (mouseX >= 16 && mouseX <= 66 && mouseY >= 306 && mouseY <=323)) {
        cursor();
      } else {
        noCursor();
        noFill();
        stroke(35, 197, 245, 150);
        strokeWeight(3);
        point(mouseX, mouseY);
        ellipse(mouseX, mouseY, 30, 30);
      }
      if (int(megaLaserCharge) != 100) {
        if (MegaLaserReady == false) {
          dontSayAgain = false;
          if (laser == true) {
            megaLaserCharge += 0.01;
          } else {
            megaLaserCharge += .1;
          }
        }
        fill(35, 197, 245, 150);
        text("Mega Laser Charge: "+int(megaLaserCharge)+"%", 19, 77);
      } else if (int(megaLaserCharge)== 100) {
        fill(35, 197, 245, 150);
        text("Mega Laser Charge:   "+"Ready", 19, 77);
        MegaLaserReady = true;
        if (dontSayAgain == false) {
          if (MegaLaser.isPlaying() == false) {
            MegaLaser.play();
            dontSayAgain = true;
          }
        }
      }
    } else {
      cursor();
    }



    //drawing nick ----------------
    strokeWeight(1.4);
    stroke(18, 46, 75);
    fill(18, 46, 75);
    //noFill();
    //left sleeve
    beginShape();
    vertex(76, 350);
    vertex(76, 350);
    vertex(98, 303);
    vertex(104, 277);
    vertex(101, 261);
    vertex(99, 254);
    vertex(103, 243);
    vertex(108, 237);
    vertex(110, 224);
    vertex(117, 207);
    vertex(116, 196);
    vertex(118, 176);
    vertex(122, 172);
    vertex(129, 188);
    vertex(142, 223);
    vertex(154, 257);
    vertex(164, 275);
    vertex(166, 291);
    vertex(167, 302);
    vertex(172, 349);
    vertex(172, 349);
    endShape();

    //dark shade for left arm
    fill(7, 18, 36);
    stroke(7, 18, 36);
    //noFill();
    beginShape();
    curveVertex(96, 349);
    curveVertex(96, 349);
    curveVertex(102, 347); 
    curveVertex(110, 344); 
    curveVertex(119, 341); 
    curveVertex(124, 337); 
    curveVertex(129, 331); 
    curveVertex(134, 326);
    curveVertex(138, 322); 
    curveVertex(140, 319); 
    curveVertex(144, 315); 
    curveVertex(148, 309); 
    curveVertex(149, 307); 
    curveVertex(150, 302); 
    curveVertex(148, 293); 
    curveVertex(148, 288); 
    curveVertex(146, 285); 
    curveVertex(140, 282); 
    curveVertex(134, 278); 
    curveVertex(130, 274); 
    curveVertex(134, 274); 
    curveVertex(142, 275); 
    curveVertex(147, 276); 
    curveVertex(149, 274); 
    curveVertex(149, 271); 
    curveVertex(149, 266); 
    curveVertex(146, 259); 
    curveVertex(146, 254); 
    curveVertex(144, 244); 
    curveVertex(144, 239); 
    curveVertex(141, 233); 
    curveVertex(139, 226); 
    curveVertex(139, 220); 
    curveVertex(137, 211);
    curveVertex(130, 190);
    curveVertex(122, 172);
    curveVertex(130, 190);
    curveVertex(137, 211);
    curveVertex(143, 229); 
    curveVertex(146, 241); 
    curveVertex(151, 250); 
    curveVertex(155, 259); 
    curveVertex(158, 265); 
    curveVertex(161, 271); 
    curveVertex(163, 276); 
    curveVertex(164, 283); 
    curveVertex(165, 291); 
    curveVertex(166, 296); 
    curveVertex(167, 303); 
    curveVertex(167, 312); 
    curveVertex(168, 319); 
    curveVertex(169, 327); 
    curveVertex(171, 337); 
    curveVertex(171, 341);
    curveVertex(171, 345); 
    curveVertex(171, 348);
    curveVertex(171, 348);
    endShape();

    //t-shirt
    fill(0, 9, 21);
    noStroke();
    //noFill();
    beginShape();
    curveVertex(253, 190); 
    curveVertex(253, 190); 
    curveVertex(268, 235); 
    curveVertex(288, 304); 
    curveVertex(294, 345); 
    curveVertex(294, 343); 
    vertex(294, 212); 
    vertex(281, 209); 
    curveVertex(260, 196); 
    curveVertex(260, 196); 
    endShape();

    //dark shade for t-shirt
    fill(0, 0, 0, 140);
    beginShape();
    curveVertex(294, 215); 
    curveVertex(294, 215); 
    curveVertex(280, 212); 
    curveVertex(259, 204); 
    curveVertex(277, 269); 
    curveVertex(288, 304); 
    curveVertex(294, 315); 
    curveVertex(293, 264); 
    curveVertex(280, 256); 
    curveVertex(275, 236); 
    curveVertex(271, 219); 
    curveVertex(293, 221);
    curveVertex(293, 221);
    endShape();

    // shade for left side
    strokeWeight(1);
    stroke(18, 46, 75);
    fill(18, 46, 75);
    //noFill();
    beginShape(); 
    vertex(122, 170); 
    vertex(127, 183); 
    vertex(130, 189); 
    vertex(132, 194); 
    vertex(134, 200); 
    vertex(137, 207); 
    vertex(140, 215); 
    vertex(143, 230); 
    vertex(146, 239); 
    vertex(148, 244); 
    vertex(152, 252); 
    vertex(155, 257); 
    vertex(158, 264); 
    vertex(160, 268); 
    vertex(163, 275); 
    vertex(164, 287); 
    vertex(166, 300); 
    vertex(167, 310); 
    vertex(168, 320); 
    vertex(170, 329); 
    vertex(171, 336); 
    vertex(172, 346); 
    vertex(172, 347); 
    vertex(172, 348); 
    vertex(205, 349); 
    vertex(205, 349); 
    vertex(293, 349); 
    vertex(284, 337); 
    vertex(275, 325); 
    vertex(269, 317); 
    vertex(261, 312); 
    vertex(253, 303); 
    vertex(241, 296); 
    vertex(229, 286); 
    vertex(220, 279); 
    vertex(214, 273); 
    vertex(209, 269); 
    vertex(206, 265); 
    vertex(209, 261); 
    vertex(217, 253); 
    vertex(222, 248); 
    vertex(229, 240); 
    vertex(235, 231); 
    vertex(241, 223);
    vertex(244, 219); 
    vertex(237, 213); 
    vertex(229, 206); 
    vertex(223, 205); 
    vertex(210, 205); 
    vertex(195, 204); 
    vertex(181, 201); 
    vertex(175, 202); 
    vertex(171, 200); 
    vertex(168, 198); 
    vertex(166, 198); 
    vertex(169, 192); 
    vertex(173, 187); 
    vertex(177, 180); 
    vertex(182, 173); 
    vertex(187, 166); 
    vertex(193, 157); 
    vertex(198, 148); 
    vertex(206, 139); 
    vertex(212, 134); 
    vertex(205, 134); 
    vertex(194, 137); 
    vertex(185, 140); 
    vertex(176, 143); 
    vertex(163, 148); 
    vertex(154, 152); 
    vertex(146, 156); 
    vertex(141, 159); 
    vertex(132, 165); 
    vertex(123, 170);
    endShape();
    //the shades (lights and shadows)
    //first shadow
    stroke(0, 29, 54);
    fill(0, 29, 54);
    beginShape();
    curveVertex(107, 245);
    curveVertex(107, 245);
    curveVertex(109, 262);
    curveVertex(111, 266);
    curveVertex(114, 277);
    curveVertex(115, 275);
    curveVertex(149, 318);
    curveVertex(114, 277);
    curveVertex(108, 267);
    curveVertex(104, 253);
    curveVertex(107, 245);
    curveVertex(107, 245);
    endShape();
    //second shadow
    beginShape();
    curveVertex(122, 236);
    curveVertex(122, 236);
    curveVertex(136, 258);
    curveVertex(147, 271);
    curveVertex(136, 262);
    curveVertex(130, 256);
    curveVertex(130, 256);
    endShape();

    //light

    fill(219, 238, 255, 190);
    stroke(219, 238, 255, 190);
    beginShape();
    curveVertex(117, 208);
    curveVertex(117, 208);
    curveVertex(121, 224);
    curveVertex(120, 234);
    curveVertex(121, 240);
    curveVertex(122, 249);
    curveVertex(123, 254);
    curveVertex(117, 249);
    curveVertex(115, 245);
    curveVertex(110, 240);
    curveVertex(110, 225);
    curveVertex(110, 225);
    endShape();
    //light
    beginShape();
    curveVertex(116, 193);
    curveVertex(116, 193);
    curveVertex(125, 180);
    curveVertex(166, 154);
    curveVertex(181, 148);
    curveVertex(152, 156);
    curveVertex(129, 167);
    curveVertex(118, 175);
    curveVertex(118, 175);
    endShape();
    //light
    beginShape();
    curveVertex(89, 323);
    curveVertex(109, 293);
    curveVertex(110, 286);
    curveVertex(107, 280);
    curveVertex(102, 256);
    curveVertex(108, 243);
    curveVertex(110, 263);
    curveVertex(116, 268);
    curveVertex(113, 263);
    curveVertex(112, 242);
    curveVertex(109, 238);
    curveVertex(99, 255);
    curveVertex(104, 276);
    curveVertex(97, 304);
    curveVertex(93, 314);
    curveVertex(93, 314);
    endShape();

    beginShape();
    curveVertex(81, 337);
    curveVertex(81, 337);
    curveVertex(91, 332);
    curveVertex(100, 328);
    curveVertex(102, 329);
    curveVertex(95, 338);
    curveVertex(104, 334);
    curveVertex(112, 330);
    curveVertex(118, 332);
    curveVertex(118, 332);
    curveVertex(108, 339);
    curveVertex(91, 349);
    curveVertex(77, 349);
    curveVertex(77, 349);
    endShape();




    fill(0, 9, 21);
    stroke(0, 0, 0, 150);
    beginShape();
    curveVertex(263, 163);
    curveVertex(263, 163);
    curveVertex(267, 170); 
    curveVertex(267, 175); 
    curveVertex(274, 187); 
    curveVertex(286, 194); 
    curveVertex(292, 195); 
    curveVertex(293, 195); 
    curveVertex(293, 210); 
    curveVertex(283, 209); 
    curveVertex(267, 201); 
    curveVertex(254, 190); 
    curveVertex(261, 171);
    curveVertex(261, 171);
    endShape();

    fill(255, 255, 255, 10);
    noStroke();
    beginShape();
    curveVertex(263, 164); 
    curveVertex(263, 164);
    curveVertex(254, 189); 
    curveVertex(276, 206); 
    curveVertex(287, 211); 
    curveVertex(294, 211); 
    curveVertex(275, 197); 
    curveVertex(266, 185); 
    curveVertex(264, 177); 
    curveVertex(264, 177);
    endShape();

    fill(18, 46, 75);
    noStroke();
    //noFill();
    beginShape();
    curveVertex(253, 142); 
    curveVertex(253, 142); 
    curveVertex(263, 163); 
    curveVertex(254, 191); 
    curveVertex(248, 208); 
    curveVertex(244, 217); 
    curveVertex(229, 205); 
    curveVertex(239, 176); 
    curveVertex(253, 141);
    curveVertex(253, 141);
    endShape();


    fill(0, 0, 0, 110);
    beginShape();
    curveVertex(253, 143);
    curveVertex(253, 143); 
    curveVertex(243, 170); 
    curveVertex(237, 196); 
    curveVertex(244, 214); 
    curveVertex(253, 192); 
    curveVertex(262, 163); 
    curveVertex(257, 151);
    curveVertex(257, 151);
    endShape();


    //thin shades of left side of suit
    fill(7, 18, 36, 200);
    stroke(7, 18, 36, 200);
    //nofill
    beginShape();
    vertex(130, 187);
    vertex(130, 187); 
    vertex(134, 186); 
    vertex(138, 184); 
    curveVertex(150, 180); 
    vertex(165, 171); 
    vertex(184, 166); 
    vertex(187, 163); 
    vertex(172, 166); 
    curveVertex(151, 172); 
    curveVertex(139, 178); 
    vertex(139, 178);
    endShape();

    beginShape();
    vertex(192, 154); 
    vertex(192, 154); 
    curveVertex(187, 156); 
    curveVertex(167, 163); 
    curveVertex(167, 163); 
    curveVertex(149, 169); 
    curveVertex(140, 174); 
    curveVertex(127, 181); 
    curveVertex(149, 169);
    curveVertex(167, 163); 
    curveVertex(184, 159); 
    vertex(190, 158);
    vertex(190, 158);
    endShape();


    beginShape();
    vertex(202, 205); 
    curveVertex(186, 216); 
    curveVertex(176, 233); 
    curveVertex(168, 245); 
    curveVertex(159, 257); 
    curveVertex(159, 265);
    curveVertex(158, 268);
    curveVertex(159, 257); 
    curveVertex(168, 245);
    curveVertex(176, 233);
    curveVertex(186, 216);
    vertex(202, 205);
    endShape();

    strokeWeight(0.3);
    beginShape(); 
    vertex(189, 204); 
    vertex(182, 213); 
    vertex(177, 219); 
    curveVertex(171, 231); 
    vertex(163, 237); 
    vertex(158, 246); 
    vertex(154, 252);
    vertex(151, 253);
    vertex(158, 246); 
    vertex(158, 246); 
    vertex(163, 237);
    curveVertex(171, 231);
    vertex(177, 219);
    vertex(182, 213); 
    endShape();

    fill(6, 41, 75);
    stroke(6, 41, 75);
    //noFill();
    beginShape();
    curveVertex(166, 201);
    curveVertex(166, 201);
    curveVertex(153, 222);
    curveVertex(155, 244);
    curveVertex(165, 224);
    curveVertex(164, 208);
    curveVertex(164, 208);
    endShape();

    //shade under the collar
    fill(5, 20, 41, 190);
    stroke(5, 20, 41, 190);
    beginShape();
    vertex(168, 199); 
    vertex(191, 207); 
    curveVertex(198, 209); 
    curveVertex(202, 224); 
    curveVertex(205, 243); 
    curveVertex(210, 242); 
    curveVertex(214, 231); 
    curveVertex(213, 222); 
    curveVertex(228, 220); 
    curveVertex(231, 228); 
    curveVertex(221, 247); 
    curveVertex(234, 235); 
    curveVertex(244, 220); 
    curveVertex(227, 206); 
    curveVertex(197, 204); 
    curveVertex(176, 200); 
    vertex(166, 198);
    endShape();

    stroke(0, 0, 0, 100);
    fill(0, 0, 0, 100);
    beginShape();
    vertex(207, 267); 
    vertex(213, 301); 
    vertex(211, 349); 
    vertex(271, 348); 
    vertex(270, 320); 
    vertex(246, 299); 
    vertex(221, 278); 
    endShape();


    stroke(9, 26, 49, 200);
    fill(0, 0, 0, 130);
    //noFill();
    beginShape();
    vertex(194, 210); 
    curveVertex(191, 215);
    curveVertex(197, 228); 
    curveVertex(197, 251); 
    curveVertex(200, 270); 
    curveVertex(203, 288); 
    curveVertex(204, 325); 
    vertex(204, 349); 
    vertex(173, 348); 
    curveVertex(171, 323); 
    curveVertex(171, 293); 
    curveVertex(176, 261); 
    curveVertex(177, 242); 
    vertex(180, 228);
    vertex(180, 228);
    endShape();

    stroke(0, 0, 0, 50);
    fill(0, 0, 0, 50);
    beginShape();
    vertex(170, 243); 
    curveVertex(173, 250); 
    curveVertex(177, 247); 
    curveVertex(178, 290); 
    curveVertex(173, 346); 
    curveVertex(169, 313); 
    curveVertex(168, 292); 
    curveVertex(166, 276); 
    curveVertex(164, 266); 
    curveVertex(160, 254); 
    vertex(169, 245); 
    endShape();


    fill(156, 173, 196, 190);
    stroke(156, 173, 196, 190);
    beginShape();
    vertex(196, 210); 
    curveVertex(193, 215);
    curveVertex(199, 228); 
    curveVertex(199, 251); 
    curveVertex(202, 270); 
    curveVertex(203, 288); 
    curveVertex(206, 325); 
    vertex(206, 349);
    curveVertex(193, 210); 
    curveVertex(204, 349); 
    curveVertex(210, 349); 
    curveVertex(211, 297); 
    curveVertex(205, 253); 
    curveVertex(204, 236);
    curveVertex(204, 241); 
    vertex(199, 218);
    endShape();

    fill(0, 0, 0, 100);
    stroke(0, 0, 0, 100);
    beginShape();
    vertex(207, 266); 
    vertex(219, 276); 
    vertex(233, 288); 
    curveVertex(250, 301); 
    curveVertex(250, 301);
    curveVertex(275, 323);  
    curveVertex(293, 349);
    curveVertex(271, 323); 
    curveVertex(271, 323); 
    vertex(238, 295);
    endShape();


    strokeWeight(2);
    stroke(0, 0, 50, 100);
    fill(18, 46, 75);
    //noFill();
    //left collar
    beginShape();
    vertex(166, 198); 
    vertex(194, 155); 
    vertex(197, 148); 
    vertex(212, 134); 
    vertex(236, 105); 
    vertex(240, 114); 
    vertex(243, 120); 
    vertex(245, 120); 
    vertex(246, 125); 
    vertex(248, 130); 
    vertex(251, 137); 
    vertex(252, 140); 
    vertex(250, 147); 
    vertex(245, 160); 
    vertex(238, 176); 
    vertex(235, 186); 
    vertex(231, 196); 
    vertex(229, 203); 
    vertex(228, 205);
    vertex(193, 203);
    vertex(167, 197);
    endShape();

    fill(0, 0, 0, 100);
    stroke(0, 0, 0, 100);
    beginShape();
    vertex(233, 114); 
    vertex(203, 153); 
    vertex(178, 195); 
    vertex(176, 194);  
    vertex(200, 154); 
    vertex(211, 141); 
    vertex(229, 119);
    endShape();

    strokeWeight(0.2);
    beginShape();
    vertex(176, 194); 
    vertex(197, 197); 
    vertex(216, 198); 
    vertex(228, 199);
    vertex(216, 198);
    vertex(197, 197);
    vertex(176, 194); 
    endShape();

    fill(0, 0, 0, 120);
    beginShape();
    curveVertex(245, 121);
    curveVertex(245, 121); 
    curveVertex(252, 140); 
    curveVertex(247, 157); 
    curveVertex(230, 199); 
    curveVertex(243, 152); 
    curveVertex(247, 134); 
    curveVertex(247, 134);
    endShape();

    fill(18, 46, 75);
    stroke(0, 0, 50, 100);
    //noFill();
    beginShape();
    curveVertex(254, 192); 
    curveVertex(254, 192); 
    curveVertex(247, 214); 
    curveVertex(231, 237);  
    vertex(207, 265); 
    curveVertex(264, 312); 
    curveVertex(276, 323); 
    curveVertex(300, 349); 
    curveVertex(300, 349); 
    curveVertex(282, 283); 
    curveVertex(264, 223); 
    curveVertex(264, 223);
    endShape();




    fill(0, 0, 0, 100);
    noStroke();

    beginShape();
    vertex(251, 210); 
    vertex(257, 219); 
    vertex(239, 243); 
    vertex(217, 264); 
    vertex(210, 265); 
    vertex(219, 260); 
    vertex(227, 252); 
    vertex(236, 240); 
    vertex(241, 228); 
    vertex(251, 212);
    endShape();

    fill(0);
    stroke(0, 0, 0, 200);
    beginShape();
    vertex(215, 264); 
    vertex(249, 293); 
    vertex(274, 314); 
    vertex(294, 339); 
    vertex(298, 347); 
    vertex(294, 339);
    vertex(274, 314); 
    vertex(249, 293); 
    endShape();

    fill(0, 0, 0, 150);
    stroke(0, 0, 0, 150);
    noStroke(); 
    beginShape();
    curveVertex(253, 205); 
    curveVertex(253, 205); 
    curveVertex(255, 194); 
    curveVertex(264, 216); 
    curveVertex(275, 253); 
    curveVertex(286, 297);
    curveVertex(298, 346); 
    curveVertex(279, 329); 
    curveVertex(274, 286); 
    curveVertex(270, 246); 
    curveVertex(261, 215); 
    curveVertex(253, 205); 
    curveVertex(253, 205); 
    endShape();

    fill(255, 255, 255, 20);
    beginShape();
    curveVertex(250, 230);
    curveVertex(250, 230);
    curveVertex(251, 246); 
    curveVertex(257, 273); 
    curveVertex(256, 248); 
    curveVertex(258, 227); 
    curveVertex(259, 219); 
    curveVertex(253, 223);
    curveVertex(253, 223);
    endShape();

    fill(255, 255, 255, 9);
    noStroke();
    beginShape();
    curveVertex(207, 263);
    curveVertex(207, 263);
    curveVertex(224, 243); 
    curveVertex(230, 235); 
    curveVertex(225, 261); 
    curveVertex(257, 308); 
    curveVertex(221, 278); 
    curveVertex(221, 278); 
    endShape();

    beginShape();
    curveVertex(237, 106); 
    curveVertex(237, 106); 
    curveVertex(204, 173); 
    curveVertex(198, 204); 
    curveVertex(168, 197); 
    curveVertex(197, 148); 
    curveVertex(235, 105); 
    curveVertex(235, 105); 
    endShape();

    //the face
    fill(198, 134, 66);
    stroke(198, 134, 66);
    //noFill();
    beginShape();
    curveVertex(258, 1); 
    curveVertex(258, 1);
    curveVertex(242, 18); 
    curveVertex(237, 44); 
    curveVertex(240, 78); 
    curveVertex(234, 74); 
    curveVertex(228, 74); 
    curveVertex(228, 89); 
    curveVertex(237, 105); 
    curveVertex(242, 117); 
    curveVertex(247, 120); 
    curveVertex(252, 136); 
    curveVertex(261, 155); 
    curveVertex(267, 167); 
    curveVertex(268, 174); 
    curveVertex(272, 183); 
    curveVertex(279, 188); 
    curveVertex(286, 193); 
    curveVertex(293, 194); 
    curveVertex(294, 194); 
    curveVertex(294, 0); 
    curveVertex(294, 0);
    endShape();

    //highlight _ 1
    fill(255, 255, 255, 40);
    beginShape();
    curveVertex(294, 0); 
    curveVertex(294, 0); 
    curveVertex(256, 1); 
    curveVertex(242, 19); 
    curveVertex(237, 44); 
    curveVertex(245, 66); 
    curveVertex(273, 47); 
    curveVertex(289, 20); 
    curveVertex(294, 13); 
    curveVertex(294, 13); 
    endShape();
    //hightlight _ 2
    beginShape();
    curveVertex(294, 57); 
    curveVertex(294, 57); 
    curveVertex(273, 61); 
    curveVertex(257, 75); 
    curveVertex(254, 87); 
    curveVertex(264, 83); 
    curveVertex(280, 90); 
    curveVertex(293, 83); 
    curveVertex(293, 83); 
    endShape();

    //mouthShadow
    fill(0, 0, 0, 100);
    beginShape();
    curveVertex(286, 162); 
    curveVertex(286, 162); 
    curveVertex(294, 166); 
    curveVertex(294, 170); 
    curveVertex(287, 169); 
    curveVertex(287, 169); 
    endShape();

    //eye ball
    fill(255);
    beginShape();
    curveVertex(266, 102); 
    curveVertex(266, 102); 
    curveVertex(275, 107); 
    curveVertex(284, 103); 
    curveVertex(274, 98); 
    curveVertex(274, 98); 
    endShape();


    //eye brow
    fill(60);
    beginShape();
    curveVertex(289, 93); 
    curveVertex(289, 93); 
    curveVertex(279, 91); 
    curveVertex(271, 87); 
    curveVertex(259, 90); 
    curveVertex(267, 92); 
    curveVertex(277, 96); 
    curveVertex(282, 96); 
    curveVertex(282, 96); 
    endShape();

    //eyeShadow
    fill(0, 0, 0, 140);
    noStroke();
    beginShape();
    curveVertex(277, 98); 
    curveVertex(277, 98); 
    curveVertex(285, 93); 
    curveVertex(293, 95); 
    curveVertex(292, 105); 
    curveVertex(279, 115); 
    curveVertex(267, 110); 
    curveVertex(278, 110); 
    curveVertex(285, 102); 
    curveVertex(283, 99); 
    curveVertex(283, 99); 
    endShape();

    //eyeshadow_2
    beginShape();
    curveVertex(259, 103); 
    curveVertex(259, 103); 
    curveVertex(264, 103); 
    curveVertex(272, 99); 
    curveVertex(264, 96); 
    curveVertex(260, 99); 
    curveVertex(260, 99);
    endShape();

    //nostrill
    stroke(30);
    strokeWeight(5);
    point(294, 134);

    //nose shadow
    fill(100);
    stroke(100);
    strokeWeight(.2);
    beginShape();
    curveVertex(294, 115); 
    curveVertex(294, 115); 
    curveVertex(288, 133); 
    curveVertex(289, 136); 
    curveVertex(288, 133); 
    curveVertex(294, 115); 
    endShape();

    //eyepatch 'string'
    fill(50);
    strokeWeight(0.9);
    stroke(0);
    beginShape();
    curveVertex(248, 10);
    curveVertex(248, 10);
    curveVertex(264, 37); 
    curveVertex(294, 70); 
    curveVertex(294, 63); 
    curveVertex(272, 37); 
    curveVertex(258, 18); 
    curveVertex(253, 6); 
    curveVertex(251, 8); 
    curveVertex(251, 8); 
    endShape();

    //mouth area shade thing
    fill(0, 0, 0, 190);
    stroke(0, 0, 0, 170);
    beginShape();
    curveVertex(290, 122);
    curveVertex(290, 122); 
    curveVertex(282, 131); 
    curveVertex(271, 161); 
    curveVertex(273, 152);
    curveVertex(271, 161); 
    curveVertex(282, 131);
    curveVertex(282, 131);
    endShape();


    //beard
    fill(0, 0, 0, 210);
    beginShape();
    curveVertex(294, 145);
    curveVertex(294, 145);
    curveVertex(279, 151); 
    curveVertex(268, 167); 
    curveVertex(270, 181); 
    curveVertex(279, 189); 
    curveVertex(293, 195); 
    curveVertex(293, 195); 
    curveVertex(294, 175); 
    curveVertex(279, 169); 
    curveVertex(281, 164); 
    curveVertex(288, 161); 
    curveVertex(294, 160); 
    curveVertex(294, 160); 
    endShape();

    //iris of the eye
    strokeWeight(7);
    stroke(0);
    point(275, 101);
    //end of nick ----------------------

    //SHEILD AI ---------------------------
    if (pause == false && programOn == true) {
      if (cleanAnimation == false) {
        if (mouseX >= 5 && mouseX <= 64 && mouseY >= 4 && mouseY <= 64) {
          clearSoundEffects();
          mouseOverLogo = true;
          sheildSize = 55;
          logoOffset = 1;
          if (sheildApp == false) {
            fill(35, 197, 245, 150);
            strokeWeight(3);
            stroke(11, 122, 155, 100);
            rect(56, 12, 150, 41, 1, 6, 6, 1);
            fill(255);
            textFont(sheildFont);
            textSize(20);
            text("Shield System", 65, 40);
            fill(35, 197, 245, 150);
            strokeWeight(3);
            stroke(11, 122, 155, 100);
            rect(56, 12, 150, 41, 1, 6, 6, 1);
          }
        } else {
          mouseOverLogo = false;
        }
      }
    }

    if (sheildApp == true) {
      //logo size set
      sheildSize = 55;
      logoOffset = 1;
      fill(35, 197, 245, 150);
      textFont(sheildFont);
      textSize(10);
      text("Altitude:  "+int(random(29980, 30080)), 68, 44);

      if (menuOn == true) {        
        //menu appereance
        stroke(35, 197, 245, 150);
        fill(35, 197, 245, 150);
        strokeWeight(3);
        line(15, 59, 10, 65);
        line(10, 67, 10, 336);
        line(10, 338, 69, 336);
        strokeWeight(7);
        point(69, 336);
        strokeWeight(3);
        line(8, 39, 63, 10);
        line(65, 10, 186, 10);
        strokeWeight(7);
        point(186, 10);
        strokeWeight(3);
        line(59, 25, 219, 25);
        line(219, 27, 219, 99);
        line(218, 101, 198, 123);
        strokeWeight(7);
        point(198, 123);

        //menu choices
        noStroke();
        if (menuChoicesOn == true) {
          resetMenuOffset();
          if (programOn == true) {
            if (mouseX >= 9 && mouseX <= 93 && mouseY <= 107 && mouseY >= 78) {
              clearSoundEffects();
              if (pause != true) {
                if (soundPlayed == false) {
                  Menu.play();
                  soundPlayed = true;
                }

                menuOffsetX = 80;
                menuOffsetY = 20;
                fill(255);
                textFont(sheildFont);
                textSize(20);
                text("Combat System", 16, 106);
              } else {
                fill(255);
                textFont(sheildFont);
                textSize(10);
                text("Combat System", 13, 92);
              }
            } else {

              fill(255);
              textFont(sheildFont);
              textSize(10);
              text("Combat System", 13, 92);
            }
            fill(35, 197, 245, 150);
            rect(12, 79, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

            resetMenuOffset();

            if (mouseX >= 9 && mouseX <= 93 && mouseY <= 153 && mouseY >= 127) {
              clearSoundEffects();
              if (pause != true) {
                if (soundPlayed == false) {
                  Menu.play();
                  soundPlayed = true;
                }
                menuOffsetX = 70;
                menuOffsetY = 20;
                fill(255);
                textFont(sheildFont);
                textSize(30);
                text("Contacts", 21, 158);
              } else {
                fill(255);
                textFont(sheildFont);
                textSize(15);
                text("Contacts", 18, 142);
              }
            } else {

              fill(255);
              textFont(sheildFont);
              textSize(15);
              text("Contacts", 18, 142);
            }
            fill(35, 197, 245, 150);
            rect(12, 127, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

            resetMenuOffset();

            if (mouseX >= 9 && mouseX <= 93 && mouseY <= 204 && mouseY >= 175) {
              clearSoundEffects();
              if (pause != true) {
                if (soundPlayed == false) {
                  Menu.play();
                  soundPlayed = true;
                }              
                menuOffsetX = 34;
                menuOffsetY = 20;
                fill(255);
                textFont(sheildFont);
                textSize(30);
                text("Menu", 28, 205);
              } else {
                fill(255);
                textFont(sheildFont);
                textSize(15);
                text("Menu", 28, 191);
              }
            } else {
              fill(255);
              textFont(sheildFont);
              textSize(15);
              text("Menu", 28, 191);
            }
            fill(35, 197, 245, 100);
            rect(12, 175, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

            resetMenuOffset();
            if (mouseX >= 9 && mouseX <= 93 && mouseY <= 251 && mouseY >= 226) {
              clearSoundEffects();
              if (pause != true) {
                if (soundPlayed == false) {
                  Menu.play();
                  soundPlayed = true;
                }              
                menuOffsetX = 34;
                menuOffsetY = 20;
                fill(255);
                textFont(sheildFont);
                textSize(30);
                text("Game", 17, 254);
              } else {
                fill(255);
                textFont(sheildFont);
                textSize(15);
                text("Game", 24, 240);
              }
            } else {
              fill(255);
              textFont(sheildFont);
              textSize(15);
              text("Game", 24, 240);
            }
            fill(35, 197, 245, 100);
            rect(12, 226, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

            resetMenuOffset();
          }
        } else if (menuChoicesOn == false) {
          //image(sheildLogo, 17, 305);
          beginShape();

          if (mouseX >= 16 && mouseX <= 66 && mouseY >= 306 && mouseY <=323) {
            clearSoundEffects();
            if (soundPlayed == false) {
              //Menu.play();
              soundPlayed = true;
            }     
            vertex(31, 297); 
            vertex(14, 315); 
            vertex(31, 332); 
            vertex(31, 324); 
            vertex(85, 324); 
            vertex(85, 306); 
            vertex(31, 306);
            endShape();
          } else {
            beginShape();
            vertex(29, 305); 
            vertex(18, 314); 
            vertex(29, 323); 
            vertex(29, 319); 
            vertex(62, 319); 
            vertex(62, 310); 
            vertex(29, 310);  
            endShape();
          }
        }
      }
    }


    //sheild logo -------------------------------------------------------
    stroke(0);
    strokeWeight(3);
    noFill();
    ellipse(34, 34, sheildSize, sheildSize);
    noStroke();
    fill(0);
    beginShape();
    vertex(34, 43-logoOffset); 
    vertex(53, 22-logoOffset); 
    vertex(50, 18-logoOffset); 
    vertex(39, 25-logoOffset); 
    vertex(36, 19-logoOffset); 
    vertex(39, 18-logoOffset); 
    vertex(38, 17-logoOffset); 
    vertex(33, 17-logoOffset); 
    vertex(29, 25-logoOffset); 
    vertex(17, 17-logoOffset); 
    vertex(14, 22-logoOffset); 
    vertex(34, 43-logoOffset);
    endShape();

    beginShape();
    vertex(29, 40+logoOffset); 
    vertex(21, 53+logoOffset); 
    vertex(34, 57+logoOffset); 
    vertex(46, 53+logoOffset); 
    vertex(38, 40+logoOffset); 
    vertex(34, 44+logoOffset); 
    endShape();

    beginShape();
    vertex(41+logoOffset, 38+logoOffset); 
    vertex(50+logoOffset, 49+logoOffset); 
    vertex(54+logoOffset, 44+logoOffset); 
    vertex(45+logoOffset, 35+logoOffset);
    endShape();

    beginShape();
    vertex(26-logoOffset, 39+logoOffset); 
    vertex(17-logoOffset, 49+logoOffset); 
    vertex(13-logoOffset, 45+logoOffset); 
    vertex(22-logoOffset, 35+logoOffset);
    endShape();

    beginShape();
    vertex(18-logoOffset, 29+logoOffset); 
    vertex(11-logoOffset, 36+logoOffset); 
    vertex(12-logoOffset, 42+logoOffset); 
    vertex(21-logoOffset, 33+logoOffset);
    endShape();

    beginShape();
    vertex(46+logoOffset, 33+logoOffset); 
    vertex(55+logoOffset, 42+logoOffset); 
    vertex(56+logoOffset, 36+logoOffset); 
    vertex(49+logoOffset, 29+logoOffset); 
    endShape();

    beginShape();
    vertex(13-logoOffset, 24+logoOffset); 
    vertex(11-logoOffset, 28+logoOffset); 
    vertex(11-logoOffset, 33+logoOffset); 
    vertex(17-logoOffset, 28+logoOffset);
    endShape();

    beginShape();
    vertex(50+logoOffset, 28+logoOffset); 
    vertex(56+logoOffset, 33+logoOffset); 
    vertex(55+logoOffset, 27+logoOffset); 
    vertex(54+logoOffset, 24+logoOffset);
    endShape();

    noStroke();
    fill(35, 197, 245, 150);
    ellipse(34, 34, sheildSize+9, sheildSize+9);

    //sheild logo end ---------------------------------------------
    strokeWeight(1);
    //Game settings -----------------------------------------------------
    if (GameOn == true) {
      if (GameOver == false) {
        if (keyPressed == true) {

          if (keyCode == RIGHT) {
            if (craftPositionX + 4 < endingPositionX) {
              craftMovementX += 2;
            }
          }

          if (keyCode == LEFT) {
            if (craftPositionX - 4 > beginingPositionX) {
              craftMovementX -= 2;
            }
          } 
          if (keyCode == LEFT && keyCode == RIGHT) {
          }
        }

        craftPositionX = craftStartX + craftMovementX;
        noStroke();
        fill(35, 197, 245, 150);
        rect(beginingPositionX, beginingPositionY, 100, 100, 7);

        noStroke();
        fill(craftColour);
        triangle(craftPositionX, (endingPositionY - craftOffsetY - 4), craftPositionX - 4, (endingPositionY - craftOffsetY), craftPositionX + 4, (endingPositionY - craftOffsetY));
        if (frameCount % 10 == 0) {
          if (craftColour == 255) {
            craftColour = 200;
          } else {
            craftColour = 255;
          }
        }
        if (enemy == false) {
          enemyPosition =  int(random(1, 8))*10;
          enemy = true;
        }
        if (enemy == true) {
          fill(craftColour);
          if (craftColour == 200) {
            strokeColour = 255;
          } else {
            strokeColour = 200;
          }
          stroke(strokeColour);
          ellipse(beginingPositionX + enemyPosition, beginingPositionY + 20, 5, 5);
        }


        if (endingPositionY -2 - laserYOffset <= beginingPositionY + 20 && endingPositionY -2 - laserYOffset >=  10+ beginingPositionY) {
          if (laserX[arrayNum] > enemyPosition - 3.5+ beginingPositionX && laserX[arrayNum] < enemyPosition + 3.5 + beginingPositionX) {
            println("test");
            points += 10;
            enemy = false;
          }
        }  

        if (laserYOffset < 100) {
          if (newLaser = true) {
            strokeWeight(3);
            stroke(craftColour);
            line(laserX[arrayNum], endingPositionY -2 - laserYOffset, laserX[arrayNum], endingPositionY - 6 - laserYOffset);
            laserYOffset += 8;
          } else {
            laserYOffset = 100;
          }
        } else {
          newLaser = false;
        }
        strokeWeight(1);
        if (frameCount % 1000 == 0) {
          GameOver = true;
          resetGame();
        }
      } else {
        noStroke();
        fill(35, 197, 245, 150);
        rect(beginingPositionX, beginingPositionY, 100, 100, 7);
        fill(25, 255, 255, 150);
        textSize(14);
        text("Score", beginingPositionX + 30, endingPositionY/2 - 20);
        textSize(10);
        text(points, beginingPositionX + 20, endingPositionY/2);
        ellipse(endingPositionX/2+25, endingPositionY/2 + 20, 10, 10);
      }
    }
    //game settings end ---------------------------------------------------------

    //contacts menu-------------------------------------------------------------------
    if (ContactsOn == true) {
      resetMenuOffset();
      if (programOn == true) {
        if (mouseX >= 9 && mouseX <= 93 && mouseY <= 107 && mouseY >= 78) {

          clearSoundEffects();
          if (pause != true) {
            if (soundPlayed == false) {
              Menu.play();
              soundPlayed = true;
            }

            menuOffsetX = 80;
            menuOffsetY = 20;
            fill(255);
            textFont(sheildFont);
            textSize(20);
            text("SpiderMan", 23, 106);
          } else {
            fill(255);
            textFont(sheildFont);
            textSize(10);
            text("SpiderMan", 20, 92);
          }
        } else {

          fill(255);
          textFont(sheildFont);
          textSize(10);
          text("SpiderMan", 20, 92);
        }
        fill(35, 197, 245, 150);
        rect(12, 79, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

        resetMenuOffset();

        if (mouseX >= 9 && mouseX <= 93 && mouseY <= 153 && mouseY >= 127) {

          clearSoundEffects();
          if (pause != true) {
            if (soundPlayed == false) {
              Menu.play();
              soundPlayed = true;
            }
            menuOffsetX = 70;
            menuOffsetY = 20;
            fill(255);
            textFont(sheildFont);
            textSize(30);
            text("Captin", 24, 158);
          } else {
            fill(255);
            textFont(sheildFont);
            textSize(15);
            text("Captin", 21, 142);
          }
        } else {

          fill(255);
          textFont(sheildFont);
          textSize(15);
          text("Captin", 21, 142);
        }
        fill(35, 197, 245, 150);
        rect(12, 127, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

        resetMenuOffset();


        if (mouseX >= 9 && mouseX <= 93 && mouseY <= 251 && mouseY >= 226) {

          clearSoundEffects();
          if (pause != true) {
            if (soundPlayed == false) {
              Menu.play();
              soundPlayed = true;
            }              
            menuOffsetX = 34;
            menuOffsetY = 20;
            fill(255);
            textFont(sheildFont);
            textSize(30);
            text("Happy", 17, 254);
          } else {
            fill(255);
            textFont(sheildFont);
            textSize(15);
            text("Happy", 24, 240);
          }
        } else {
          fill(255);
          textFont(sheildFont);
          textSize(15);
          text("Happy", 24, 240);
        }
        fill(35, 197, 245, 100);
        rect(12, 226, 80+menuOffsetX, 20+menuOffsetY, 0, 10, 4, 0);

        resetMenuOffset();
      }
    }

    //contact menu end-----------------------------------------------------------------


    //pause menu--------------------------------
    if (pause == true) {
      // background overlay graphics
      noStroke();
      fill(255, 255, 255, 100);
      rect(-4, -4, width+4, height+4);

      //text shadow
      fill(190);
      textSize(40);
      text("paused", 80, 110);

      // pause text settings
      fill(255);
      textSize(40);
      text("paused", 82, 107);
    }
    //end of pause menu -----------------------
  }
}
void mouseClicked() {
  print("vertex");
  print("("+mouseX+", "+mouseY+");");
  println(" ");
  if (mouseButton == LEFT) {
    if (pause == false && programOn == true) {
      if (mouseX >= 5 && mouseX <= 64 && mouseY >= 4 && mouseY <= 64) {
        if (sheildApp == false) {
          sheildApp = true;
          println("Shield Systems Initiated");
          if (ShieldApp.isPlaying() == true) {
            ShieldApp.stop();
          }
          ShieldApp.play();
          if (Initiated.isPlaying() != true) {
            Initiated.play();
          }
        } else {
          sheildApp = false;
          cleanAnimation = true;
          menuChoicesOn = true;
          clearCombat();
          if (CombatSystem.isPlaying() == true) {
            CombatSystem.stop();
          }
          GameOn = false;
          GameOver = true;
          ContactsOn = false;
          clearContactVoice();
        }
      } else if (menuChoicesOn == true) {
        //the main menu choices in the sheild AI
        if (mouseX >= 9 && mouseX <= 93 && mouseY <= 107 && mouseY >= 78) {
          menuChoicesOn = false;
          if (ShieldApp.isPlaying() == true) {
            ShieldApp.stop();
          }
          ShieldApp.play();
          CombatSystem.play();
          combat = true;
          skyCleared = true;
        } else if (mouseX >= 9 && mouseX <= 93 && mouseY <= 204 && mouseY >= 175) {
          programOn = false;
        } else if (mouseX >= 9 && mouseX <= 93 && mouseY <= 251 && mouseY >= 226) {
          menuChoicesOn = false;    
          GameOn = true;
        }

        if (mouseX >= 9 && mouseX <= 93 && mouseY <= 153 && mouseY >= 127) {
          menuChoicesOn = false;
          ContactsOn = true;      //opens contact menu
        }
      } else if (menuChoicesOn ==false) {
        //the back sign when menu is off
        if (mouseX >= 16 && mouseX <= 66 && mouseY >= 306 && mouseY <=323) {
          if (ShieldApp.isPlaying() == true) {
            ShieldApp.stop();
          }
          // ShieldApp.play();
          if (combat = true) {
            menuChoicesOn = true;
            clearCombat();
            if (CombatSystem.isPlaying() == true) {
              CombatSystem.stop();
            }
          }

          menuChoicesOn = true;
          GameOver = true;
          GameOn =false;
          ContactsOn = false;
          clearContactVoice();
        } 
        if (GameOn == true) {
          if (mouseX >= 88 && mouseX <= 99 && mouseY >= 97 && mouseY <= 108) {
            GameOver = false;
            points = 0;
          }
        }
        //plays the voice lines based on which menu box thing is pressed
        if (ContactsOn == true) {
          if (mouseX >= 9 && mouseX <= 93 && mouseY <= 107 && mouseY >= 78) {
            clearContactVoice();
            spiderVoice.play();
          } else if (mouseX >= 9 && mouseX <= 93 && mouseY <= 153 && mouseY >= 127) {
            clearContactVoice();
            captinVoice.play();
          } else if (mouseX >= 9 && mouseX <= 93 && mouseY <= 251 && mouseY >= 226) { 
            clearContactVoice();
            happyVoice.play();
          }
        }
      }
    }
  }
}

//resets the menu size offset 
public void resetMenuOffset() {
  menuOffsetX = 0;
  menuOffsetY = 0;
}

//clearing the clean animation boolean that is made to make the sheild logo look good when its pressed to close
void mouseMoved() {
  cleanAnimation = false;
  if ((mouseX >= 9 && mouseX <= 93 && mouseY <= 251 && mouseY >= 226)||(mouseX >= 16 && mouseX <= 66 && mouseY >= 306 && mouseY <=323)||(mouseX >= 9 && mouseX <= 93 && mouseY <= 204 && mouseY >= 175)||(mouseX >= 9 && mouseX <= 93 && mouseY <= 153 && mouseY >= 127)||(mouseX >= 9 && mouseX <= 93 && mouseY <= 107 && mouseY >= 78)) {
  } else {
    soundPlayed = false;
  }
}

//all the keypressed functions
void keyPressed() {
  //what happens if ENTER is pressed
  if (key == ENTER) {
    //checks if it is already on or off or paused using the If statment
    if (programOn == false) {
      programOn = true;  //opens/starts the program
      introMusic.loop();
      shipMovementOffset = 0;
    } else if (pause == false) {
      pause = true;  //pauses the program
    } else if (pause ==  true) {
      pause = false; // if it was paused un pauses the program
    }
  } else if (key == 'p') {  //if the key pressed is P instead
    if (musicPaused == false) {  //checks if the music is paused
      // pauses it
      introMusic.pause();
      musicPaused = true;
    } else if (musicPaused == true) {
      introMusic.loop();
      musicPaused = false;
    }
  }
}  

//if the mouse is Dragged the combat laser follows the mouse
void mouseDragged() {
  if (combat == true) {
    laser = true;
    if (laserPlayed == false) {
      LaserSound.play();
      laserPlayed = true;
    }
    if (MegaLaserReady == true) {
      drainingMegaLaser = true;
    }
    if (drainingMegaLaser == true && megaLaserCharge >= 90) {
      if (MegaLaserOn.isPlaying() == false) {
        MegaLaserOn.play();
      }
    }
  }
}

//function mouse released for the combat system laser system that stops the laser when released
void mouseReleased() {
  if (laser == true) {
    laser = false;
    laserPlayed = false;
    if (drainingMegaLaser == true) {
      megaLaserCharge = 0;
    }
  }
}

//custom function to clear combat system settings
public void clearCombat() {
  combat = false;
  skyCleared = false;
  MegaLaserReady = false;
  megaLaserCharge = 0;
  drainingMegaLaser = false;
}

//custom function to clear normal sound effects
public void clearSoundEffects() {

  //nothing
}

//custom function that resets the minigame laser offset
public void resetGame() {
  laserYOffset = 160;
}

//when the key is released (for the minigame in the menu)
void keyReleased() {
  if (keyCode == UP) {
    arrayNum+=1;
    laserX = append(laserX, craftPositionX); 
    println(laserX[arrayNum]);
    newLaser = true;
    laserYOffset = 0;
  }
}

//custom function to stop the contacts voice
public void clearContactVoice() {

  spiderVoice.stop();
  happyVoice.stop();
  captinVoice.stop();
}