class LoadGame{
  
  boolean easy, hard, endless;
  
  Background backgrnd;
  Layout layout;
  float barrierHP, enemySpeed;
  int enemyCount;
  
  //Sets and loads appropriate difficulty level chosen by player.
  LoadGame(int difficulty){
    
    barrierHP = 10;
    layout = new Layout();
     
    if(difficulty == 0){
      easy = true;
      enemyCount = 25;
      //TODO: Set appropriate enemy speed.
      String[] temp = {"Backgrounds/EasySky/1.png", "Backgrounds/EasySky/2.png", "Backgrounds/EasySky/3.png", "Backgrounds/EasySky/4.png"};
      backgrnd = new Background(temp, false);
    }
    if(difficulty == 1){
      hard = true;
      enemyCount = 50;
      //TODO: Set appropriate enemy speed.
      String[] temp = {"Backgrounds/HardSky/1.png", "Backgrounds/HardSky/2.png", "Backgrounds/HardSky/3.png", "Backgrounds/HardSky/4.png"};
      backgrnd = new Background(temp, false);
    }
    if(difficulty == 2){
      endless = true;
      enemyCount = -1;
      //TODO: Set appropriate enemy speed.
      String[] temp = {"Backgrounds/EndlessSky/1.png", "Backgrounds/EndlessSky/2.png", "Backgrounds/EndlessSky/3.png", "Backgrounds/EndlessSky/4.png"};
      backgrnd = new Background(temp, false);
    }
 }
  
  void display(){
    backgrnd.display();
    layout.display();
    stroke(0);
    for(int i = 25; i < height; i += 100){
      line(0, i, width, i);
    }
    textFont(NoOutlineFont, 20);
    fill(3, 252, 240);
    text("Enemies Left: " + (enemyCount == -1 ? "inf." : enemyCount), (width - 180), 15);
    wiz.update();
    eyeEnemy.updateSprite(1);
  }
}
