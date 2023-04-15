class LoadGame{
  
  boolean easy, hard, endless;
  
  Background backgrnd;
  Layout layout;
  float barrierHP, enemySpeed;
  int enemyCount;
  
  Barrier barrier;
  
  
  //Sets and loads appropriate difficulty level chosen by player.
  LoadGame(int difficulty){
    
    barrierHP = 10;
    layout = new Layout();
     
    if(difficulty == 0){
      easy = true;
      enemyCount = 25;
      enemySpeed = 1.0;
      String[] temp = {"Backgrounds/EasySky/1.png", "Backgrounds/EasySky/2.png", "Backgrounds/EasySky/3.png", "Backgrounds/EasySky/4.png"};
      backgrnd = new Background(temp, false);
      
      //Sets the barrier HP to 50
      barrier = new Barrier(50);
    }
    if(difficulty == 1){
      hard = true;
      enemyCount = 50;
      //TODO: Set appropriate enemy speed.
      String[] temp = {"Backgrounds/HardSky/1.png", "Backgrounds/HardSky/2.png", "Backgrounds/HardSky/3.png", "Backgrounds/HardSky/4.png"};
      backgrnd = new Background(temp, false);
      
      //Sets the barrier HP to 50
      barrier = new Barrier(50);
    }
    if(difficulty == 2){
      endless = true;
      enemyCount = -1;
      //TODO: Set appropriate enemy speed.
      String[] temp = {"Backgrounds/EndlessSky/1.png", "Backgrounds/EndlessSky/2.png", "Backgrounds/EndlessSky/3.png", "Backgrounds/EndlessSky/4.png"};
      backgrnd = new Background(temp, false);
      
      //Sets the barrier HP to 50
      barrier = new Barrier(50);
    }
  }
    
  
  void display(){
    backgrnd.display();
    layout.display();
    barrier.display();
    stroke(0);
    //for(int i = 25; i < height; i += 100){
    //  line(0, i, width, i);
    //}
    textFont(NoOutlineFont, 20);
    fill(3, 252, 240);
    text("Enemies Left: " + (spawner.enemyCount), (width - 330), 25);
    wiz.update();
    
    if (easyMode && spawner.enemyCount == 0){
     text(("Easy Mode Complete!"), 10, 25);
    }
    if (hardMode && spawner.enemyCount == 0){
     text(("Hard Mode Complete!"), 10, 25);
    }
    if (endlessMode){
     text(("Wave: " + (spawner.wave-1)), 10, 25);
    }
  }
}
