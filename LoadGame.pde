class LoadGame {

  boolean easy, hard, endless;

  Background backgrnd;
  Layout layout;
  int barrierHP;
  float enemySpeed;
  int enemyCount;
  boolean win = false;
  int recentFrameRate;
  //Initializes barrier object that holds the health bar
  Barrier barrier;

  //Sets and loads appropriate difficulty level chosen by player.
  LoadGame(int difficulty) {

    //barrierHP was originally set to 50
    barrierHP = 10;
    layout = new Layout();
    gameOver = false;

    if (difficulty == 0) {
      easy = true;
      enemyCount = 25;
      //Could change it so that LoadGame.pde can set the enemy speeds for each difficulty using the enemySpeed variable
      //enemySpeed = 1.0;
      String[] temp = {"Backgrounds/EasySky/1.png", "Backgrounds/EasySky/2.png", "Backgrounds/EasySky/3.png", "Backgrounds/EasySky/4.png"};
      backgrnd = new Background(temp, true, 0.25);

      //Sets the barrier HP
      barrier = new Barrier(barrierHP);
    }
    if (difficulty == 1) {
      hard = true;
      enemyCount = 50;
      //Sets enemy speed directly in SpellBound.pde
      String[] temp = {"Backgrounds/HardSky/1.png", "Backgrounds/HardSky/2.png", "Backgrounds/HardSky/3.png", "Backgrounds/HardSky/4.png"};
      backgrnd = new Background(temp, true, 0.25);

      //Sets the barrier HP
      barrier = new Barrier(barrierHP);
    }
    if (difficulty == 2) {
      endless = true;
      enemyCount = -1;
      //Sets enemy speed in EnemySpawner.pde
      String[] temp = {"Backgrounds/EndlessSky/1.png", "Backgrounds/EndlessSky/2.png", "Backgrounds/EndlessSky/3.png", "Backgrounds/EndlessSky/4.png"};
      backgrnd = new Background(temp, true, 0.25);

      //Sets the barrier HP
      barrier = new Barrier(barrierHP);
    }
  }


  void display() {
    if (!gameOver) {
      backgrnd.display();
      layout.display();
      barrier.display();
      wrds.display();
      stroke(0);
      //for(int i = 25; i < height; i += 100){
      //  line(0, i, width, i);
      //}
      textFont(NoOutlineFont, 20);
      fill(3, 252, 240);
      text("Enemies Left: " + (spawner.enemyCount), (width - 330), 25);
      if (fps) {
        if ((frameCount % 10) == 0) {
          recentFrameRate = (int)frameRate;
        }
        text("fps: " + recentFrameRate, (width-330), 50);
      }
      wiz.update();

      if (easyMode && spawner.enemyCount == 0) {
        text(("Easy Mode Complete!"), 10, 25);
        gameOver = true;
        win = true;
      }
      if (hardMode && spawner.enemyCount == 0) {
        text(("Hard Mode Complete!"), 10, 25);
        gameOver = true;
        win = true;
      }
      if (endlessMode) {
        fill(#E33E3E);
        text(("Wave: " + (spawner.wave-1)), 730, 55);
        fill(3, 252, 240);
      }
    } else {
      background(0);
      fill(3, 252, 240);
      textFont(NoOutlineFont, 60);
      if (win == true) {
        background(#B6B7C6);
        text("YOU WIN!", (width/2) - (width/4) - 30, height/2);
      } else {
        background(0);
        text("GAME OVER", (width/2) - (width/4) - 30, height/2);
      }
      textFont(NoOutlineFont, 20);
      text("PLAY AGAIN", (width/3) - (width/6) - 95, height-150);
      text("MAIN MENU", 2*(width/3) - (width/6) - 95, height-150);
      text("EXIT GAME", 3*(width/3) - (width/6) - 95, height-150);

      if (overMenuOption == 0) {
        fill(179, 2, 166);
        text("PLAY AGAIN", (width/3) - (width/6) - 95, height - 150);
      } else if (overMenuOption == 1) {
        fill(179, 2, 166);
        text("MAIN MENU", 2*(width/3) - (width/6) - 95, height-150);
      } else if (overMenuOption == 2) {
        fill(179, 2, 166);
        text("EXIT GAME", 3*(width/3) - (width/6) - 95, height-150);
      }
    }
  }
}
