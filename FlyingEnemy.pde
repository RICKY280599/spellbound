class FlyingEnemy implements Enemy {

  //SpriteSheet sheet;
  HashMap<String, SpriteSheet> actions = new HashMap<>();
  float xpos, ypos;
  boolean alive;
  int frameNumber;
  float speed;
  boolean active = false;
  boolean defeated = false;

  FlyingEnemy(float enemySpeed) {
    speed = enemySpeed;
    alive = true;
    actions.put("Attack", new SpriteSheet("FlyingPack/Eye1/Attack.png", 8, 6, 1));
    actions.put("Flight", new SpriteSheet("FlyingPack/Eye1/Flight.png", 8, 6, 1));
    actions.put("Death", new SpriteSheet("FlyingPack/Eye1/Death.png", 4, 6, 1));

    //Initial enemy position
    xpos = 925;
    //outputs 0 or 1 to randomize starting position
    int placement = int(random(2));
    print(placement);
    if (placement == 0) {
      //top row
      ypos = height - 600;
    } else {
      //second to top row
      ypos = height - 500;
    }
  }

  void displayAnimation(String action, float xp, float yp) {
    actions.get(action).display(xp, yp);
  }

  void updatePosition(float speed) {
    // Draws the sprite
    //checks first to see if the enemy had not been defeated
   if (active) {
    if (alive) {
      if (xpos > 105) {
        displayAnimation("Flight", xpos, ypos);
      } else {
        //starts attacking when at the barrier
        displayAnimation("Attack", xpos, ypos);
      }
    } else {
      //stops after death animation is done
        displayAnimation("Death", xpos, ypos);
        active = false;
    }

    // Updates the position of the sprite
    //will make enemy move to the left (towards the player's barrier)
    if (xpos > 100 && alive == true) {
      xpos -= speed;
    }
  }
  }

  void updateDefeat() {
    alive = false;
    updatePosition(spawner.speed);
    spawner.minDistance = Float.MAX_VALUE;
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
