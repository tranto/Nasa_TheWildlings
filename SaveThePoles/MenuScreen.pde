/*  Copyright (c) 2014 Awesome Team. All rights reserved
*  Version without pure data */

/* some settings */
String GAME_NAME = "SAVE THE POLLS";
String ICECUBE_PATH = "images/icecube.png";
int LIMIT_TIME_TARGET = 40;
int TIME_TO_CHANGE = 20;
int SMALLEST_CIRCLE_WIDTH = 20 ;
int SMALLEST_CIRCLE_HEIGHT = 20;
int TITLE_FONT_SIZE = 50;
int SUB_FONT_SIZE = 20;
int COUNT_DOWN_FONT_SIZE = 42;
int ICECUBE_WIDTH = 154;
int ICECUBE_HEIGHT = 128;
int PADDING_TOP = 80;
class Menu{
    PImage background;
    PImage iceCube;
    PFont font;
    color sampleColor;
    float sampleTargetX;
    float sampleTargetY;
    int timeToChangeColor = 0;
    float theta = 0.75;
    boolean disappear;
    int countDown = 9;
    int timeToCount = 0;
    
    //constructor    
    Menu(String ImagePath){
       this.font   = loadFont(FONT_NAME_48);
       background  = loadImage(ImagePath);
       iceCube     = loadImage(ICECUBE_PATH);
       background.resize(1344, 756);
       sampleColor = color(255, random(200,217), random(197,214));
       float targetWidth = SMALLEST_CIRCLE_WIDTH * 4;
       float targetHeight = SMALLEST_CIRCLE_WIDTH * 4;
       sampleTargetX = (SCREEN_WIDTH - targetWidth)/2;
       sampleTargetY = (SCREEN_HEIGHT - targetHeight)/2;
       disappear = false;
       
    }
    
    void display(){
      if(!disappear){
         image(background,0, 0);
         image(iceCube, (SCREEN_WIDTH - ICECUBE_WIDTH)/2, (SCREEN_HEIGHT - ICECUBE_HEIGHT)/2 + PADDING_TOP);
        // drawSimpleTarget();
         textFont(font, TITLE_FONT_SIZE);
         String countDownNumber = "" + countDown;
         float textWidth = textWidth(countDownNumber);
         
         if(timeToCount == TIME_TO_CHANGE){
            countDown --;
            timeToCount = 0;
         }
         timeToCount++;
         textSize(COUNT_DOWN_FONT_SIZE);
         fill(HEADER_TEXT_COLOR);
         text(countDownNumber, (SCREEN_WIDTH - textWidth)/2, (SCREEN_HEIGHT - ICECUBE_HEIGHT)/2 + iceCube.height + 20);
         if(countDown <= 0){
            disappear = true;
         }
      }
  }
    
  void drawSimpleTarget() {
     timeToChangeColor++;
     if(timeToChangeColor == LIMIT_TIME_TARGET){
        timeToChangeColor = 0;
        sampleColor = color(255, random(200,217), random(197,214));
     }
     noStroke();
     float targetWidth = SMALLEST_CIRCLE_WIDTH * 4;
     float targetHeight = SMALLEST_CIRCLE_HEIGHT * 4;
    
        
     float temp = 0.35;
     for(int i = 0; i <10; i++){
         fill(sampleColor/(i+ 10));
         ellipseMode(CENTER);  // Set ellipseMode to CENTER
         ellipse(sampleTargetX + 40, sampleTargetY + 30, targetWidth/temp, targetHeight/temp);  // Draw white ellipse using RADIUS mode
         temp += 0.1;
     }

  }
  
  void setappear(){
     disappear = false;
  }
  
  boolean disappear(){
    if(!disappear){
      float X2 = sampleTargetX + SMALLEST_CIRCLE_WIDTH * 4;  
      float Y2 = sampleTargetY + SMALLEST_CIRCLE_HEIGHT * 4;
       if (mouseX < X2 && mouseX > sampleTargetX && mouseY > sampleTargetY && mouseY < Y2){
           disappear = true;
           return true;
        }
    }
    return disappear;
  }
  
  
}