class FlyingEnemy {

  //SpriteSheet sheet;
  HashMap<String, SpriteSheet> actions = new HashMap<>();
  float xpos, ypos;
  boolean alive;
  int frameNumber;

  FlyingEnemy() {
    alive = true;
    actions.put("Attack", new SpriteSheet("FlyingPack/Eye1/Attack.png", 8, 6));
    actions.put("Flight", new SpriteSheet("FlyingPack/Eye1/Flight.png", 8, 6));
    actions.put("Death", new SpriteSheet("FlyingPack/Eye1/Death.png", 4, 6));

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

  void display(String action, float xp, float yp) {
    actions.get(action).display(xp, yp);
  }

  void updateSprite(int speed) {
    // Draws the sprite
    //checks first to see if the enemy had not been defeated
    if (alive) {
      if (xpos > 105) {
        display("Flight", xpos, ypos);
      } else {
        //starts attacking when at the barrier
        display("Attack", xpos, ypos);
      }
    } else {
      //stops after death animation is done
      if (frameCount < frameNumber + 4) {
        display("Death", xpos, ypos);
      }
    }

    // Updates the position of the sprite
    //will make enemy move to the left (towards the player's barrier)
    if (xpos > 100 && alive == true) {
      xpos -= speed;
    }
  }

  void updateDefeat() {
    alive = false;
    frameNumber = frameCount;
  }
}
