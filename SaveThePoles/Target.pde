/*  Copyright (c) 2014 Awesome Team. All rights reserved
*  Version without pure data */
int WIDTH_LIMIT_LEFT = 150;
int WIDTH_LIMIT_RIGHT = 650;
int HEIGHT_LIMIT_TOP = 100;
int HEIGHT_LIMIT_BOTTOM = 400;

class Target {
  color c1;
  float xpos;
  float ypos;
  int sizeW = 30;
  int sizeH = 30;
  float topBorderG;
  float bottomBorderG;
  float rightBorderG;
  float leftBorderG;
  boolean alive = true;
  
  
  Target() {
    //c = color(random(180, 255), 44, 208); // Random purple colour
    xpos = int(random(WIDTH_LIMIT_LEFT, WIDTH_LIMIT_RIGHT));
    ypos = int(random(HEIGHT_LIMIT_TOP, HEIGHT_LIMIT_BOTTOM));
    setBordersG();
  }
  void setBordersG() {
    topBorderG = ypos - sizeW/2;
    bottomBorderG = ypos + sizeW/2;
    rightBorderG = xpos + sizeH/2;
    leftBorderG = xpos - sizeH/2;
  }
  void display() {
    rectMode(CENTER);
    stroke(0);
    c1 = color(random(255), random(255), random(255));
    fill(c1);
    setBordersG();    
    
    ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
    ellipse(xpos, ypos, sizeW, sizeH);  // Draw white ellipse using RADIUS mode
      
      
    fill(c1/8);
    ellipseMode(RADIUS);  // Set ellipseMode to RADIUS
    ellipse(xpos, ypos, sizeW/1.5, sizeH/1.5);  // Draw white ellipse using RADIUS mode


    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    fill(c1/2); 
    ellipse(xpos, ypos, sizeW, sizeH);  // Draw gray ellipse using CENTER mode
    
    ellipseMode(CENTER);  // Set ellipseMode to CENTER
    fill(c1/1.5); 
    ellipse(xpos, ypos, sizeW/2, sizeH/2); 
  

    
  }
  void destroyed(){
      alive = false;
  }
//  void tele() {
//     xpos = int(random(700));
//     ypos = int(random(500));
//  }
}