/*  Copyright (c) 2014 Awesome Team. All rights reserved
*  Version without pure data */


String GAME_OVER_TEXT = "GAME OVER";
String YOUR_SCORE_TEXT = "Your score is: ";
int LIMIT_POSITION = 200;
int SYMBOL_WIDTH = 300;
int SYMBOL_HEIGHT = 346;

class Levelup{
    PImage background;
    float titlePositionY ;
    float imagePositionY;
    PFont font;
    
    Levelup(String ImagePath){
       background = loadImage(ImagePath);
       //size(300, 346);
       //size(SYMBOL_WIDTH, SYMBOL_HEIGHT);
       titlePositionY = 0;
       imagePositionY = imagePositionY + 20;
       this.font = loadFont(FONT_NAME_48);
    }
  
   void display(){
       fill(color(random(0), random(255), random(197,214)));
          
       if(imagePositionY < LIMIT_POSITION){
          PImage iTemp = loadImage(GAME_PLAY_IMAGE);
          image(iTemp,0, 0);
          image(background,250, imagePositionY);
          
          textFont(this.font, 30);
          textSize(50);
          text(GAME_OVER_TEXT, SCREEN_WIDTH/2, 80);
          textSize(30);
          text(YOUR_SCORE_TEXT + count, SCREEN_WIDTH/2, 150);
          imagePositionY += 10; 
       }
       
   }
  
  
}