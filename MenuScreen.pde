/*  Copyright (c) 2014 Awesome Team. All rights reserved
*  Version without pure data */

/* some settings */
String GAME_NAME = "SAVE THE POLLS";
int LIMIT_TIME = 40;
int TIME_TO_CHANGE = 20;
int SMALLEST_CIRCLE_WIDTH = 20 ;
int SMALLEST_CIRCLE_HEIGHT = 20;
int TITLE_FONT_SIZE = 50;
int SUB_FONT_SIZE = 20;
int COUNT_DOWN_FONT_SIZE = 80;

class Menu{
    PImage background;
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
       this.font = loadFont(FONT_NAME_48);
       background = loadImage(ImagePath);
       //size(800, 600);//background.width, background.height);
       background(800); 
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
         drawSimpleTarget();
         textFont(font, TITLE_FONT_SIZE);
         float textWidth = textWidth(GAME_NAME);
         fill(255);
         text(GAME_NAME, (SCREEN_WIDTH - textWidth)/2, 100);
         String startText = "Ready";
         textWidth = textWidth(startText);
         textSize(20);
      
         float x = SMALLEST_CIRCLE_WIDTH * 6 * sin(theta);
         float y = SMALLEST_CIRCLE_HEIGHT * 6 *cos(theta);
         theta += 0.02;
         text(startText, x + SCREEN_WIDTH/2 , y + 260);
         String readyText = "" + countDown;
     
         textWidth = textWidth(readyText);
      
         if(timeToCount == TIME_TO_CHANGE){
            countDown --;
            timeToCount = 0;
         }
         timeToCount++;
         textSize(COUNT_DOWN_FONT_SIZE);
         fill(0);
         text(readyText, 375, 315);
         if(countDown <= 0){
            disappear = true;
         }
      }
  }
    
  void drawSimpleTarget() {
     timeToChangeColor++;
     if(timeToChangeColor == LIMIT_TIME){
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