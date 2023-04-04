import java.util.*;
import java.io.*;
class LoadGame{
  
  boolean easy, hard, endless;
  
  float barrierHP, enemySpeed;
  int enemyCount;
  
  List<String> wordList;
  
  //Sets and loads appropriate difficulty level chosen by player.
  LoadGame(int difficulty){
    
    barrierHP = 10;
     
    if(difficulty == 0){
      easy = true;
      enemyCount = 25;
      WordList words = WordList(easyList);
      //TODO: Set appropriate enemy speed.
    }
    if(difficulty == 1){
      hard = true;
      enemyCount = 50;
      //TODO: Set appropriate enemy speed.
    }
    if(difficulty == 2){
      endless = true;
      enemyCount = -1;
      //TODO: Set appropriate enemy speed.
    }
 }
  
  void display(){
    background(255);
    stroke(0);
    for(int i = 25; i < height; i += 100){
      line(0, i, width, i);
    }
    textFont(NoOutlineFont, 20);
    text("Enemies Left: " + (enemyCount == -1 ? "inf." : enemyCount), (width - 180), 15);
    wiz.update();
  }

}
