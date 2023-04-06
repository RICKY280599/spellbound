class GroundEnemy implements Enemy {
  
  HashMap<String, SpriteSheet> actions = new HashMap<>();
  float xpos, ypos;
  // boolean to determine whether the enemy is a skeleton or goblin
  boolean isGoblin;
  boolean isSkeleton;
  boolean isAttacking = false;
  int enemyType;
  float speed;
  boolean alive;
  int frameNumber;
  boolean active = false;

  GroundEnemy(float enemyspeed) {
    enemyType = (int)random(1, 4);
    alive = true;

    if (enemyType == 1) {
      isGoblin = true;
    }
    else if (enemyType == 2) {
      isSkeleton = true;
    }
    speed = enemyspeed;
    // Add actions to hashmap
    actions.put("GoblinRun", new SpriteSheet("GroundPack/GoblinRun.png", 8, 6));
    actions.put("GoblinAttack", new SpriteSheet("GroundPack/GoblinAttack.png", 8, 6));
    actions.put("GoblinDeath", new SpriteSheet("GroundPack/GoblinDeath.png", 4, 6));
    actions.put("SkeletonWalk", new SpriteSheet("GroundPack/SkeletonWalk.png", 4, 6));
    actions.put("SkeletonAttack", new SpriteSheet("GroundPack/SkeletonAttack.png", 8, 6));
    actions.put("SkeletonDeath", new SpriteSheet("GroundPack/SkeletonDeath.png", 4, 6));
    actions.put("MushroomRun", new SpriteSheet("GroundPack/MushroomRun.png", 8, 6));
    actions.put("MushroomAttack", new SpriteSheet("GroundPack/MushroomAttack.png", 8, 6));
    actions.put("MushroomDeath", new SpriteSheet("GroundPack/MushroomDeath.png", 4, 6));
    
    

    xpos = 925;
    ypos = ((int) random(2, 5)) * 100 + 25;
  }

  // Updates position of the current enemy
  void updatePosition(float speed) {
   if(active){ 
    if (!isAttacking) {
      xpos -= speed;
      // Checks if the enemy has reached the barrier
      if (xpos <= 100) {
        isAttacking = true;
      }
    }
    if (isGoblin) {
      if (alive) {
        if (isAttacking) {
          displayAnimation("GoblinAttack", xpos, ypos);
        } else {
          displayAnimation("GoblinRun", xpos, ypos);
        }
      } else {
        if (frameCount < frameNumber + 4) {
       displayAnimation("GoblinDeath", xpos, ypos);
        }
      }
    } else if (isSkeleton) {
      if (alive) {
        if (isAttacking) {
          displayAnimation("SkeletonAttack", xpos, ypos);
        } else {
          displayAnimation("SkeletonWalk", xpos, ypos);
        }
      } else {
        if (frameCount < frameNumber + 4) {
       displayAnimation("SkeletonDeath", xpos, ypos);
        }
      }
    }
    else {
      if (alive) {
        if (isAttacking){
          displayAnimation("MushroomAttack", xpos, ypos);
        }
        else{
        displayAnimation("MushroomRun", xpos, ypos);
        }
       }
       else{
         if (frameCount < frameNumber + 4) {
       displayAnimation("MushroomDeath", xpos, ypos);
        }
       }
    }
 }
  }

  // Displays animation based on where the enemy is, and whether they are attacking yet
  void displayAnimation(String action, float xp, float yp) {
    if (isGoblin) {
      if (alive) {
        if (isAttacking) {
          actions.get("GoblinAttack").display(xp, yp);
        } else {
          actions.get("GoblinRun").display(xp, yp);
        }
      } else {
        actions.get("GoblinDeath").display(xp, yp);
      }
    } else if (isSkeleton) {
      if (alive) {
        if (isAttacking) {
          actions.get("SkeletonAttack").display(xp, yp);
        } else {
          actions.get("SkeletonWalk").display(xp, yp);
        }
      } else {
        actions.get("SkeletonDeath").display(xp, yp);
      }
    }
    else {
      if (alive) {
        if (isAttacking){
          actions.get("MushroomAttack").display(xpos,ypos);
        }
        else{
        actions.get("MushroomRun").display(xpos,ypos);
        }
       }
       else{
        actions.get("MushroomDeath").display(xpos,ypos); 
       }
    }
  }
  
  void updateDefeat() {
    alive = false;
    frameNumber = frameCount;
  }
  
  float getYpos(){
   return ypos; 
  }
  float getXpos(){
  return xpos;
  }
  
  public boolean isActive() {
   return active; 
  }
  
  public void setActive(boolean active){
   this.active = active; 
  }
}
