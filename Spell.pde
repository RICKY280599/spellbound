class Spell {
  SpriteSheet animation;
  boolean type; //0 for hard 1 for easy
  float xPos;
  float yPos;
  int xSpeed;
  int frame;
  boolean remove;
  Spell(boolean easy){
    if (easy){
      type = true;
      animation = new SpriteSheet("Spells/water2.png", 5, 4, 5, 1);
      xPos = wiz.getPosition(true);
      yPos = wiz.getPosition(false);
      xSpeed = 0;
      frame = 0;
      remove = false;
      playWaterCast();
    }
    else{
      type = false;
      animation = new SpriteSheet("Spells/ice.png", 8, 3, 1);
      xPos = wiz.getPosition(true);
      yPos = wiz.getPosition(false);
      xSpeed = 12;
      frame = 0;
      remove = false;
      playIceCast();
    }
  }
  void display(){
    if (type){
      if (yPos > 285){
        yPos = 285;
      }
      animation.display(xPos + 150, yPos - 70);
    }
    else{
      if (frame > 20){
        animation.display(xPos + 150, yPos + 20);
      }
    }
  }
  
  boolean getRemove(){
    return remove;
  }
  
  void updatePosition(){
   if (frame > 20 && !type){
     xPos += xSpeed;
   }
   if (!type){
     Iterator<Enemy> itr = spawner.enemies.iterator();
      //System.out.print(spells.size());
      while (itr.hasNext()) {
        Enemy enemy = itr.next();
        if (enemy.isActive()) {
          if (enemy.getXpos() > xPos-80 && enemy.getXpos() < xPos+160 && enemy.getYpos() > yPos-20 && enemy.getYpos() < yPos+60) {
           enemy.updateDefeat();
           itr.remove();
           spawner.removeEnemy();
           playIceHit();
           animation = new SpriteSheet("Spells/iceEffect.png", 26, 4, 1);
           yPos = yPos - 20;
           xPos = xPos + 15;
           xSpeed = 0;
           frame = 1000;
          }
        }
      }
   }
   display();
   frame++;
   if (!type && xPos > 1000){
    remove = true;
    //System.out.println("removed");
   }
   if (!type && frame > 1050){
    remove = true; 
   }
   
   if (frame > 90 && type){
    remove = true; 
   }
  }
}
