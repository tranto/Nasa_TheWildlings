/*  Copyright (c) 2014 Awesome Team. All rights reserved
*  Version without pure data */


String GAME_OVER_TEXT = "LEVEL UP";
String FIRST_TEXT = "You have successfully prevented loss of 1.84%";
String SECOND_TEXT = "per km2 of Ice from year 2016,in the Region of ";
String THIRD_TEXT = "Baffin Bay Gulf of St.Lawrence alone.";
int LIMIT_POSITION = 200;
int SYMBOL_WIDTH = 300;
int SYMBOL_HEIGHT = 346;
int MESSAGE_TEXT_COLOR = color(40, 108, 147);
String BACKGROUND_PATH = "images/blankBg.jpg";
class Levelup{
    PImage icony;
    float titlePositionY ;
    float imagePositionY;
    PFont font;
    
    Levelup(String ImagePath){
       icony = loadImage(ImagePath);
       titlePositionY = 0;
       imagePositionY = imagePositionY + 10;
       this.font = loadFont(FONT_NAME_48);
    }
  
   void display(){
         fill(MESSAGE_TEXT_COLOR);
          
       if(imagePositionY < LIMIT_POSITION){
          PImage iTemp = loadImage(BACKGROUND_PATH);
          image(iTemp,0, 0);
          int polarBearPosition = (SCREEN_WIDTH - icony.width)/20 - 40;
          image(icony,polarBearPosition, imagePositionY);
          textAlign(LEFT);
          textFont(this.font, 30);
          textSize(50);
          text(GAME_OVER_TEXT, (SCREEN_WIDTH - textWidth(GAME_OVER_TEXT))/2, 80);
          textSize(30);
          text(FIRST_TEXT , polarBearPosition + icony.width , imagePositionY+70);
          textSize(30);
          text(SECOND_TEXT , polarBearPosition + icony.width,imagePositionY + 110);
          text(THIRD_TEXT , polarBearPosition + icony.width,imagePositionY + 150);
          imagePositionY += 10; 
       }
       
   }
  
  
}