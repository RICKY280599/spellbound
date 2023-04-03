/*
  Mason Enojo
  John McGraw
  Ricardo Sanchez
  Christian Mosey
*/

import processing.sound.*;

//Images, font, and sound loaders
PImage menu;
PFont OutlineFont, NoOutlineFont;
SoundFile menuMusic, menuSelection;

//Background loaders
Background darkSky;

//Booleans used to determine game state
boolean inMenu, easyMode, hardMode, start;

//int used to track option hovered by player (since game only uses keyboard input)
int menuOption = 0;

//LoadGame objects to load respective difficulty game objects
//LoadGame easy = new LoadGame(0);

void setup() {
  size(900, 600);
  inMenu = true;
  OutlineFont = createFont("Fonts/OutlineMain.ttf", 85);
  NoOutlineFont = createFont("Fonts/NoOutlineMain.ttf", 30);
  textFont(OutlineFont);
  textAlign(CENTER, CENTER);
  
  //Load darkSky animated background for main menu, its music and soundFX
  String[] temp = {"Backgrounds/DarkSky/1Resized.png", "Backgrounds/DarkSky/2Resized.png", "Backgrounds/DarkSky/3Resized.png", "Backgrounds/DarkSky/4Resized.png"};
  darkSky = new Background(temp);
  menuMusic = new SoundFile(this, "Music/arcade_acadia.wav");
  menuMusic.amp(0.7);
  menuSelection = new SoundFile(this, "SoundFX/MenuSelection.wav");
}

void draw() {
  if(inMenu) {
    if(!menuMusic.isPlaying()){
      menuMusic.loop();    
    }
    loadMenu();
  }
}

void loadMenu() {
  darkSky.display();
  
  fill(222, 2, 207);
  textFont(OutlineFont);
  text("SPELLBOUND", width/2, height/2);
  
  fill(179, 2, 166);
  textFont(NoOutlineFont);
  text("EASY", (width/3) - (width/6), height-150);
  text("HARD", 2*(width/3) - (width/6), height-150);
  text("ENDLESS", 3*(width/3) - (width/6), height-150);
  
  if(menuOption == 0){
    fill(3, 252, 240);
    text("EASY", (width/3) - (width/6), height-150);
  }
  else if(menuOption == 1){
    fill(3, 252, 240);
    text("HARD", 2*(width/3) - (width/6), height-150);
  }
  else if(menuOption == 2){
    fill(3, 252, 240);
    text("ENDLESS", 3*(width/3) - (width/6), height-150);
  }
}

void keyPressed(){
  if(inMenu){
    updateMenu();
  }
}

void updateMenu(){
  if(key == CODED){
      if(keyCode == RIGHT){
        if(menuOption < 2){
          menuSelection.play();
          menuOption++;
        }
      }
      if(keyCode == LEFT){
        if(menuOption > 0){
          menuSelection.play();
          menuOption--;  
        }
      }
    }
    else{
      if(key == 'd' || key == 'D'){
        if(menuOption < 2){
          menuSelection.play();
          menuOption++;
        }
      }
      if(key == 'a' || key == 'A'){
        if(menuOption > 0){
          menuSelection.play();
          menuOption--;  
        }
      }
    }
}
