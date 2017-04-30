/* Fist Of Fury 
/*  Copyright (c) 2014 Awesome Team. All rights reserved
/*  Version without pure data */

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import SimpleOpenNI.*;

/*setting*/
int     SCREEN_WIDTH = 1344; // 1920;// 70%
int     SCREEN_HEIGHT = 756; //1080;// 70%
String  FONT_NAME_48 = "Copperplate-Bold-50.vlw";//"Chalkduster-48.vlw";
String  FONT_NAME_50 = "";
String  MENU_BG_IMAGE = "images/background.jpg";
String  GAME_PLAY_IMAGE = "images/gamescreen.jpg";
String  SYMBOLS_END_GAME_IMAGE = "images/levelup_icon.png";
String  TEST_DATA_FILE = "data/test_data.txt";
String  INSTRUCTION_IMAGE = "images/instruction.png";
String[]  ITEM_FILE_PATHS = {"data/images/bicycle.png","data/images/garbagebin.png","data/images/fridge.png","data/images/lightbuilb.png","data/images/planttree.png","data/images/solarpanel.png", "data/images/fuel.png", "data/images/aircon.png",};
int     TIME_UP = 40100;//60100;
int     COLLISION_DISTANCE = 75;
int     HEADER_TEXT_COLOR = color(157,181,200); //gray
//GLobal Variables
float x,y,a,b,r,_r,c,d,e,f,g,h,w,y2,r2,_r2;
int count;
int timer;
float RoundTimerClock = 0;
PImage lefthand,righthand,leftfoot,rightfoot;
Menu menu;
PFont font;
SimpleOpenNI  context;
Target newTarget;  
StopWatchTimer sw;
SoundManager soundMgt;
Levelup levelup;
Target[] listTarget = new Target[10];
boolean targetFlip = false; // if true, create a new target, old target disappeared

void setup()
{
    
    context = new SimpleOpenNI(this);
    if(context.isInit() == false)
    {
        println("Can't init SimpleOpenNI, maybe the camera is not connected!"); 
        exit();
        return;  
    }
    // enable depthMap generation 
    context.enableDepth();
    context.mirror();
    // enable skeleton generation for joints and initalise variables
    context.enableUser();
    
    //menu
    menu = new Menu(MENU_BG_IMAGE);
    levelup = new Levelup(SYMBOLS_END_GAME_IMAGE);

    newTarget = generateTarget(); 
    
    RoundTimerClock = millis();
    sw = new StopWatchTimer();
    //Start Stopwatch
    sw.start();
    
    // Sound
    soundMgt = new SoundManager();
    soundMgt.init();
  
    smooth();
    r  = 50;
    _r = 50;
    r2 = 50;
    _r2= 50;
    x  =  100;
    y  =  100;
    w  =  500;
    y2  =  100;
    a  =  0;
    b  =  0;
    c  =  0;
    d  =  0;  
    count  =  0;
    timer  =  0;
    
   
    size(1344, 756);
    surface.setResizable(true);
    
    for (int i = 0; i< listTarget.length; i++){  
           listTarget[i] = generateTarget();
     }
            
    font = createFont(FONT_NAME_48,42,true);//loadFont(FONT_NAME_48);//
    soundMgt.playintro();
}

void draw()
{
    int startTime = millis();
    if (startTime == 0 || startTime < RoundTimerClock + TIME_UP){
         context.update();
        fill(255); // white
        image(context.depthImage(),0,0); 
        // draw the skeleton if it's available
        if(!menu.disappear()){
            menu.display();
        }else{
            soundMgt.playbackground();
            PImage gamePlayBackground = loadImage(GAME_PLAY_IMAGE);
            gamePlayBackground.resize(1344, 756);
            image(gamePlayBackground, 0, 0); 
            
            textFont(font,28);
            fill(HEADER_TEXT_COLOR);
           // text(YOUR_SCORE_TEXT + count,SCREEN_WIDTH/2,0);
        
             //for (int i = 0; i< listTarget.length; i++){     
             //   if (listTarget[i].alive == true) {
             //       listTarget[i].display();
             //       break;
             //   }
             //}
            // Display Timer to user
            time();
            
            // remove the following line when with Kinect device 
            //watchHit(TEST_DATA_FILE);
            if(context.isTrackingSkeleton(1)) {
                drawSimpleFigure();
            }
      }

    }
  else {
      levelup.display();
      sw.stop();
  }
}


Target generateTarget() {
    Target newTargetTemp;
    String itemName = ITEM_FILE_PATHS[int(random(0,5))];
    newTargetTemp = new Target(itemName); 
    return newTargetTemp;
}

void drawAllHitingTargets(String filepath) {
    // data input  
    String[] entries = loadStrings(filepath);
    for(int i = 0; i < entries.length; i++) {
      //Show Target for user to hit
      newTarget.display();
    }
}

void drawSimpleFigure() {
    // draw hitting targets depends on how many entries we have in the data file
    // Data input format: 
    // The longtitude and latitude are represented to their equivalent center position on the page as PVector
    // x1, y1, size1, Wimagepath1\n
    // x2, y2, size2, Wimagepath2\n
    
    // MODE1: draw all targets at once
   
    newTarget.display();
    // Hand Tracking
    PVector jointPos = getJointPosition(SimpleOpenNI.SKEL_LEFT_HAND); 
    float distanceScalar = (400/jointPos.z);
    drawCircleL(jointPos, distanceScalar);
    
    jointPos = getJointPosition(SimpleOpenNI.SKEL_RIGHT_HAND);
    distanceScalar = (400/jointPos.z);
    drawCircleR(jointPos, distanceScalar);
  
    // Feet Tracking 
    //jointPos = getJointPosition(SimpleOpenNI.SKEL_LEFT_FOOT);
    //distanceScalar = (400/jointPos.z);
    //drawCircleL2(jointPos, distanceScalar);
  
    //jointPos = getJointPosition(SimpleOpenNI.SKEL_RIGHT_FOOT);
    //distanceScalar = (400/jointPos.z);
    //drawCircleR2(jointPos, distanceScalar);
      collide(); // old target overlapped
      collide2(); 
    
}

void watchHit(String filepath) {
   String[] entries = loadStrings(filepath);
   newTarget = generateTarget();
   newTarget.display();
   // place data sequencially 
   for(int i=0; i < entries.length; i++) {
     println(entries[i]);
     // uncomment the following when plug into Kinect
     while(!targetFlip && count < entries.length - 1) { 
       // no hitting success, 
       // keep detect for collision
       collide(); //old target overlapped
       collide2(); 
       //collide3();
       //collide4();
     }
     // hitting success, fill an icehole
     String entry = entries[i];
     refillMissingIce(entry);
     targetFlip = false;
   }  
}

//If collision is ffdetected create a new target (Grape) in a random location on the screen and add 1 point to the users score.
void collide() {
    
    if(dist(newTarget.xpos,newTarget.ypos,a,b) < COLLISION_DISTANCE){ 
        newTarget = generateTarget();
        count = count + 1;
        targetFlip = true;
        print ("Count is = " + count);
        soundMgt.playPunchSound();
    }
 }

void collide2() {
    if(dist(newTarget.xpos,newTarget.ypos,c,d) < COLLISION_DISTANCE) {
        newTarget = generateTarget();
        count = count+1;
        targetFlip = true;
        print ("Count is = " + count);  
        soundMgt.playPunchSound();
    }
}

//void collide3() {
//    if(dist(newTarget.xpos,newTarget.ypos,e,f) < COLLISION_DISTANCE) {
//       newTarget = new Target();
//       count = count+1;  
//       targetFlip = true;
//       print ("Count is = " + count);
//       soundMgt.playPunchSound();
//    }
//}

//void collide4() {
//    if(dist(newTarget.xpos,newTarget.ypos,g,h) < COLLISION_DISTANCE) {
//       newTarget = new Target();
//       count = count+1;
//       targetFlip = true;
//       print ("Count is = " + count);  
//       soundMgt.playPunchSound();
//    }
//}

PVector getJointPosition(int joint) {
  PVector jointPositionRealWorld = new PVector();
  PVector jointPositionProjective = new PVector();
  context.getJointPositionSkeleton(1, joint, jointPositionRealWorld);
  context.convertRealWorldToProjective(jointPositionRealWorld, jointPositionProjective);
  
  return jointPositionProjective;
}
// Draw Left Hand
void drawCircleL(PVector position, float distanceScalar) {
    pushMatrix();
    translate(position.x, position.y);
    a = position.x;
    b = position.y;
    fill(255, 136, 9); // black
    ellipse(0, 0,distanceScalar* 100,distanceScalar* 100);
    //lefthand = loadImage(ImagePath); 
    //size(lefthand.width, lefthand.height);
    //image(lefthand, a, b); 
     print ("left hand ");
    popMatrix();
}

//Draw Right hand
void drawCircleR(PVector position, float distanceScalar) {
    pushMatrix();
    translate(position.x, position.y);
    c=position.x;
    d=position.y;
    fill(255, 136, 9); // blue
    ellipse(0, 0, distanceScalar*100, distanceScalar* 100);
     print ("right hand ");
    popMatrix();
}

// Draw Left Foot
void drawCircleL2(PVector position, float distanceScalar) {
    pushMatrix();
    translate(position.x, position.y);
    e=position.x;
    f=position.y;
    fill(0, 0, 255); // blue
    ellipse(0, 0, distanceScalar * 100, distanceScalar*100);
    popMatrix();
}

//Draw Right Foot
void drawCircleR2(PVector position, float distanceScalar) {
   pushMatrix();
   translate(position.x, position.y);
   g=position.x;
   h=position.y;
   fill(0, 0, 255); // blue
   ellipse(0, 0, distanceScalar* 100,distanceScalar* 100);
   popMatrix();
}

// Fill a missing ice hole with scaled picture on the background
void refillMissingIce(String entry) {
  // line format: x1, y1, sizescale1, imagepath1(seperated by [,]or[white space])
  String[] details = splitTokens(entry, ", ");
  float x = float(details[0]);
  float y = float(details[1]);
  int scale = int(details[2]);
  String imgfilepath = details[3];
  // load the image and place it at (x, y) with scale  
  PImage missingIce = loadImage(imgfilepath);
  image(missingIce, x, y);
  missingIce.resize(scale, scale);
}

// -----------------------------------------------------------------
// SimpleOpenNI events
//Standard messages to report tracking status in the message window
void onNewUser(SimpleOpenNI curContext, int userId)
{
   println("onNewUser - userId: " + userId);
   println("\tstart tracking skeleton");
   
   sw.restart();
   curContext.startTrackingSkeleton(userId);
}

void onLostUser(SimpleOpenNI curContext, int userId)
{
   println("onLostUser - userId: " + userId);
   sw.StopTimer();
  
}

void onVisibleUser(SimpleOpenNI curContext, int userId)
{
  //println("onVisibleUser - userId: " + userId);
}

// =================================================================
// Other functions
void time() {
    textAlign(CENTER);
    
   
    if(sw.isRunning()){
       textFont(font,28);
      fill(MESSAGE_TEXT_COLOR);
      text(nf(sw.hour(), 2)+":"+nf(sw.minute(), 2)+":"+nf(sw.second(), 2), SCREEN_WIDTH/2, 40);
    }else{
       textFont(font,40);
      fill(color(random(0),random(255),random(150)));
      text("Lost tracking", SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    }
}

// =================================================
// classes
class StopWatchTimer {
    int startTime = 0, stopTime = 0;
    boolean running = false; 
    void start() {
      startTime = millis();
      running = true;
    }
    void stop() {
      stopTime = millis();
      running = false;
    }
    int getElapsedTime() {
        int elapsed;
        if (running) {
            elapsed = (millis() - startTime);
        }
        else {
           elapsed = (stopTime - startTime);
    }
    return elapsed;
  }
  
  void StopTimer(){
    running = false;
  }
  
  boolean isRunning(){
    return running;
  }
  
  void restart(){
    running = true;
  }
  int second() {
    return (getElapsedTime() / 1000) % 60;
  }
  int minute() {
    return (getElapsedTime() / (1000*60)) % 60;
  }
  int hour() {
    return (getElapsedTime() / (1000*60*60)) % 24;
  }
}
// ====================================================