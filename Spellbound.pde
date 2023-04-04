/*
 Mason Enojo
 John McGraw
 Ricardo Sanchez
 Christian Mosey
*/
import java.util.*;
import processing.sound.*;

//Images, font, sound, and spritesheet loaders
PImage menu;
PFont OutlineFont, NoOutlineFont;
SoundFile menuMusic, menuSelection;
Wizard wiz;
WordList wrds;
List<String> easyList = new ArrayList();
List<String> hardList = new ArrayList();

FlyingEnemy eyeEnemy;

//Background loaders
Background darkSky;

//Booleans used to determine game state
boolean inMenu, easyMode, hardMode, endlessMode, start;

//int used to track option hovered by player (since game only uses keyboard input)
int menuOption = 0;

//LoadGame objects to load respective difficulty game objects
LoadGame easy;
LoadGame hard;
LoadGame endless;

void setup() {
  size(900, 600);
  inMenu = true;
  OutlineFont = createFont("Fonts/OutlineMain.ttf", 85);
  NoOutlineFont = createFont("Fonts/NoOutlineMain.ttf", 30);
  textFont(OutlineFont);
  textAlign(CENTER, CENTER);
  
  easy = new LoadGame(0);
  hard = new LoadGame(1);
  endless = new LoadGame(2);
  
  //Load darkSky animated background for main menu, its music and soundFX
  String[] temp = {"Backgrounds/DarkSky/1.png", "Backgrounds/DarkSky/2.png", "Backgrounds/DarkSky/3.png", "Backgrounds/DarkSky/4.png"};
  darkSky = new Background(temp);
  menuMusic = new SoundFile(this, "Music/arcade_acadia.wav");
  menuMusic.amp(0.7);
  menuSelection = new SoundFile(this, "SoundFX/MenuSelection.wav");
  handleEasyList();
  handleHardList();
  //WordList words = WordList(easyList);
  //Load Wizard object
  wiz = new Wizard();
  wrds = new WordList();
  wrds.setLists(easyList, hardList);
  
  //Load FlyingEnemy Object
  eyeEnemy = new FlyingEnemy();
}

void handleEasyList(){
  String[] tempStr = loadStrings("WordList/easyWordList.txt");
  for (String line : tempStr){
   easyList.addAll(Arrays.asList(line.split(",")));  
  }
  for(String word : easyList){
   //System.out.println(word); 
  }
  //System.out.println(easyList.size()); 
}
void handleHardList(){
  String[] tempStr = loadStrings("WordList/hardWordList.txt");
  for (String line : tempStr){
   hardList.addAll(Arrays.asList(line.split(",")));  
  }
  for(String word : easyList){
   //System.out.println(word); 
  }
  //System.out.println(easyList.size()); 
}

void draw() {
  
  if (inMenu) {
    if (!menuMusic.isPlaying()) {
      menuMusic.loop();
    }
    loadMenu();
  }
  
  if(easyMode){
    easy.display();
    wrds.display();
  }
  
  if(hardMode){
    hard.display();
    wrds.display();  
  }
  
  if(endlessMode){
    endless.display();
    wrds.display();
  }
}

void loadMenu() {
  darkSky.display();
  wiz.display("Idle", 340, 100);

  fill(222, 2, 207);
  textFont(OutlineFont);
  text("SPELLBOUND", width/2, height/2);

  fill(179, 2, 166);
  textFont(NoOutlineFont);
  text("EASY", (width/3) - (width/6), height-150);
  text("HARD", 2*(width/3) - (width/6), height-150);
  text("ENDLESS", 3*(width/3) - (width/6), height-150);

  if (menuOption == 0) {
    fill(3, 252, 240);
    text("EASY", (width/3) - (width/6), height-150);
  } else if (menuOption == 1) {
    fill(3, 252, 240);
    text("HARD", 2*(width/3) - (width/6), height-150);
  } else if (menuOption == 2) {
    fill(3, 252, 240);
    text("ENDLESS", 3*(width/3) - (width/6), height-150);
  }
}

void keyPressed() {
  if (inMenu) {
    updateMenu();
  }
  
  if (easyMode || hardMode || endlessMode) {
    wiz.updatePosition();
    wrds.update();
  }
}

void updateMenu() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (menuOption < 2) {
        menuSelection.play();
        menuOption++;
      }
    }
    if (keyCode == LEFT) {
      if (menuOption > 0) {
        menuSelection.play();
        menuOption--;
      }
    }
  } else {
    if (key == 'd' || key == 'D') {
      if (menuOption < 2) {
        menuSelection.play();
        menuOption++;
      }
    }
    if (key == 'a' || key == 'A') {
      if (menuOption > 0) {
        menuSelection.play();
        menuOption--;
      }
    }
    if(key == ENTER){
      menuSelection.play();
      //Easy mode selected
      if(menuOption == 0){
        System.out.println(easyList.size());
        System.out.println(hardList.size());
        wrds.generateWord(true);
        wrds.generateWord(false);
        System.out.println(wrds.getWord(true));
        System.out.println(wrds.getWord(false));
        easyMode = true;
        inMenu = false;
      }
      //Hard mode selected
      if(menuOption == 1){
        wrds.generateWord(true);
        wrds.generateWord(false);
        System.out.println(wrds.getWord(true));
        System.out.println(wrds.getWord(false));
        hardMode = true;
        inMenu = false;
      }
      //Endless mode selected
      if(menuOption == 2){
        wrds.generateWord(true);
        wrds.generateWord(false);
        System.out.println(wrds.getWord(true));
        System.out.println(wrds.getWord(false));
        endlessMode = true;
        inMenu = false;
      }
    }
  }
}
