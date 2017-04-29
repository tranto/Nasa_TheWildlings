/*  Copyright (c) 2014 Awesome Team. All rights reserved
*  Version without pure data */
String PUNCH_AUDIO = "audio/punch.wav";
String KICK_AUDIO_PATH = "audio/kick.wav"; 
String GAME_BACKGROUND_AUDIO_PATH = "audio/background.wav";
String INTRO_AUDIO_PATH = "audio/Intro.wav";
String PUNCH_KICK_AUDIO_PATH = "audio/punchkick.wav";

class SoundManager{

  AudioPlayer player;
  Minim minim;//audio context
  boolean isPlayBackground;
  void init(){
     minim = new Minim(Awesome.this);
     player = minim.loadFile(PUNCH_AUDIO, 2048);
     isPlayBackground = false;
  }
  
  void playPunchSound(){
    int randomSound = (int) random(2);
    switch(randomSound){
      case 0:{
          player = minim.loadFile(PUNCH_AUDIO, 2048);
          break;
      }
      case 1:
      {
          player = minim.loadFile(KICK_AUDIO_PATH, 2048);
          break;
      }
      case 2:
      {
          player = minim.loadFile(PUNCH_KICK_AUDIO_PATH, 2048);
          break;
      }
      default:
      {
          player = minim.loadFile(PUNCH_AUDIO, 2048);
          break;
      }
      
    }
     
     player.play();
  }
  
  void stopPunchSound(){
      player.close();
  }
  
  void playbackground(){
    if(isPlayBackground){
        return;
    }
    isPlayBackground = true;
    //player.close();
    player = minim.loadFile(GAME_BACKGROUND_AUDIO_PATH, 2048);
    player.play();
  }
  
  void stopbackground(){
     player.close();
  }

  void playintro(){
    player.close();
    player = minim.loadFile(INTRO_AUDIO_PATH, 2048);
    player.play();
  }
  
  void stopintro(){
     player.close();
  }

}