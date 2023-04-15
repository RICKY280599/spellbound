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
public SoundFile fail;
Wizard wiz;
WordList wrds;
List<String> easyList = new ArrayList();
List<String> hardList = new ArrayList();
List<Spell> spells = new ArrayList();

//Initializing spawner and enemy objects
EnemySpawner spawner;
Enemy enemy;

//Variables to spawn enemies periodically
int spawnTimer = 0;
int spawnDelay = 120;

//Check if enemies arraylist has been initialized yet
boolean enemiesInitialized;

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
public int gamesWon;

//Barrier variables
int barrierEnemyCount;

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
  darkSky = new Background(temp, true);
  menuMusic = new SoundFile(this, "Music/arcade_acadia.wav");
  menuMusic.amp(0.7);
  menuSelection = new SoundFile(this, "SoundFX/MenuSelection.wav");
  fail = new SoundFile(this, "SoundFX/fail.wav");
  fail.amp(0.4);
  handleEasyList();
  handleHardList();
  //WordList words = WordList(easyList);
  //Load Wizard object
  wiz = new Wizard();

  wrds = new WordList();
  wrds.setLists(easyList, hardList);
  spawner = new EnemySpawner();
}

void playFail() {
  fail.play();
}

void handleEasyList() {
  String[] tempStr = loadStrings("WordList/easyWordList.txt");
  for (String line : tempStr) {
    easyList.addAll(Arrays.asList(line.split(",")));
  }
  for (String word : easyList) {
    //System.out.println(word);
  }
  //System.out.println(easyList.size());
}
void handleHardList() {
  String[] tempStr = loadStrings("WordList/hardWordList.txt");
  for (String line : tempStr) {
    hardList.addAll(Arrays.asList(line.split(",")));
  }
  for (String word : easyList) {
    //System.out.println(word);
  }
  //System.out.println(easyList.size());
}

void draw() {
  //resets active enemies to 0 so it can be checked again each loop
  barrierEnemyCount = 0;

  if (inMenu) {
    if (!menuMusic.isPlaying()) {
      menuMusic.loop();
    }
    loadMenu();
  }

  if (easyMode) {
    if (easy.barrier.gameOver == false) {
      easy.display();
      wrds.display();
      //Check if enemies are initialized every loop
      if (!enemiesInitialized) {
        //Enemies are speed 1.3, 25 count
        spawner.EnemyInitializer(1.3, 25);
        enemiesInitialized = true;
      }
      //Spawn enemies every 5 seconds
      if (spawnTimer >= spawnDelay) {
        spawner.spawnEnemy();
        spawnTimer = 0;
      }
      //counts the total number of active enemies at the barrier
      for (Enemy enemy : spawner.enemies) {
        if (enemy.isActive() && enemy.getXpos() <= 100) {
          barrierEnemyCount++;
        }
      }
      
      for (Enemy enemy : spawner.enemies) {
        if (enemy.isActive()) {
          if (spawner.spawnedEnemies < spawner.enemyCount) {
            enemy.updatePosition(spawner.speed);
          }
          //Causes HP to decrease if an enemy is at the barrier (every 1 second or frameCount % frameRate == 0 assuming frameRate is always at a constant 60)
          if (enemy.getXpos() <= 100 && frameCount % 60 == 0) {
            easy.barrier.originalHealthLength -= easy.barrier.decrementValue * barrierEnemyCount;
          }
        }
      }

      Iterator<Spell> itr = spells.iterator();
      //System.out.print(spells.size());
      while (itr.hasNext()) {
        Spell spell = itr.next();
        if (spell.getRemove()) {
          itr.remove();
        } else {
          spell.updatePosition();
        }
      }
    } else {
      //TEMPORARY game over screen
      background(0);
      textSize(50);
      text("You lost!", width/2 - 250, height/2);
    }
  }

  if (hardMode) {
    if (hard.barrier.gameOver == false) {
      hard.display();
      wrds.display();
      if (!enemiesInitialized) {
        spawner.EnemyInitializer(1.5, 50);
        enemiesInitialized = true;
      }
      if (spawnTimer >= spawnDelay) {
        spawner.spawnEnemy();
        spawnTimer = 0;
      }
      //counts the total number of active enemies at the barrier
      for (Enemy enemy : spawner.enemies) {
        if (enemy.isActive() && enemy.getXpos() <= 100) {
          barrierEnemyCount++;
        }
      }

      for (Enemy enemy : spawner.enemies) {
        if (enemy.isActive()) {
          if (spawner.spawnedEnemies < spawner.enemyCount) {
            enemy.updatePosition(spawner.speed);
          }
          //Causes HP to decrease if an enemy is at the barrier (every 1 second or frameCount % frameRate == 0 assuming frameRate is always at a constant 60)
          if (enemy.getXpos() <= 100 && frameCount % 60 == 0) {
            hard.barrier.originalHealthLength -= hard.barrier.decrementValue * barrierEnemyCount;
          }
        }
      }
      Iterator<Spell> itr = spells.iterator();
      //System.out.print(spells.size());
      while (itr.hasNext()) {
        Spell spell = itr.next();
        if (spell.getRemove()) {
          itr.remove();
        } else {
          spell.updatePosition();
        }
      }
    } else {
      //TEMPORARY game over screen
      background(0);
      textSize(50);
      text("You lost!", width/2 - 250, height/2);
    }
  }

  if (endlessMode) {
    if (endless.barrier.gameOver == false) {
      endless.display();
      wrds.display();
      if (spawner.getActiveEnemyCount() == 0 && spawner.spawnNewWave) {
        spawner.spawnWave();
        spawner.wave++;
      }
      if (spawnTimer >= spawnDelay) {
        spawner.spawnEnemy();
        spawnTimer = 0;
      }
      //counts the total number of active enemies at the barrier
      for (Enemy enemy : spawner.enemies) {
        if (enemy.isActive() && enemy.getXpos() <= 100) {
          barrierEnemyCount++;
        }
      }

      for (Enemy enemy : spawner.enemies) {
        if (enemy.isActive()) {
          enemy.updatePosition(spawner.speed);
          //Causes HP to decrease if an enemy is at the barrier (every 1 second or frameCount % frameRate == 0 assuming frameRate is always at a constant 60)
          if (enemy.getXpos() <= 100 && frameCount % 60 == 0) {
            endless.barrier.originalHealthLength -= endless.barrier.decrementValue * barrierEnemyCount;
          }
        }
      }
      Iterator<Spell> itr = spells.iterator();
      //System.out.print(spells.size());
      while (itr.hasNext()) {
        Spell spell = itr.next();
        if (spell.getRemove()) {
          itr.remove();
        } else {
          spell.updatePosition();
        }
      }
    } else {
      //TEMPORARY game over screen
      background(0);
      textSize(50);
      text("You lost!", width/2 - 250, height/2);
    }
  }
  
  spawnTimer++;
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
    if (key == ENTER) {
      menuSelection.play();
      //Easy mode selected
      if (menuOption == 0) {
        wrds.generateWord(true);
        wrds.generateWord(false);
        easyMode = true;
        inMenu = false;
      }
      //Hard mode selected
      if (menuOption == 1) {
        wrds.generateWord(true);
        wrds.generateWord(false);
        hardMode = true;
        inMenu = false;
      }
      //Endless mode selected
      if (menuOption == 2) {
        wrds.generateWord(true);
        wrds.generateWord(false);
        endlessMode = true;
        inMenu = false;
      }
    }
  }
}
