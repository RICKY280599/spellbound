class GroundEnemy {
  
  HashMap<String, SpriteSheet> actions = new HashMap<>();
  float xpos, ypos;
  // boolean to determine whether the enemy is a skeleton or goblin
  boolean isGoblin;
  boolean isAttacking = false;
  int enemyType;
  float speed;
  boolean isDead = false;

  GroundEnemy(float enemyspeed) {
    enemyType = (int) random(1, 3);

    if (enemyType == 1) {
      isGoblin = true;
    }
    speed = enemyspeed;
    // Add actions to hashmap
    actions.put("GoblinRun", new SpriteSheet("GroundPack/GoblinRun.png", 8, 6));
    actions.put("GoblinAttack", new SpriteSheet("GroundPack/GoblinAttack.png", 8, 6));
    actions.put("GoblinDeath", new SpriteSheet("GroundPack/GoblinDeath.png", 4, 6));
    actions.put("SkeletonWalk", new SpriteSheet("GroundPack/SkeletonWalk.png", 4, 6));
    actions.put("SkeletonAttack", new SpriteSheet("GroundPack/SkeletonAttack.png", 8, 6));
    actions.put("SkeletonDeath", new SpriteSheet("GroundPack/SkeletonDeath.png", 4, 6));

    xpos = 925;
    ypos = ((int) random(2, 5)) * 100 + 25;
  }

  // Updates position of the current enemy
  void updatePosition() {
    if (!isAttacking) {
      xpos -= speed;
      // Checks if the enemy has reached the barrier
      if (xpos <= 100) {
        isAttacking = true;
      }
    }
    displayAnimation();
  }

  // Displays animation based on where the enemy is, and whether they are attacking yet
  void displayAnimation() {
    if (isGoblin) {
      if (!isDead) {
        if (isAttacking) {
          actions.get("GoblinAttack").display(xpos, ypos);
        } else {
          actions.get("GoblinRun").display(xpos, ypos);
        }
      } else {
        actions.get("GoblinDeath").display(xpos, ypos);
      }
    } else {
      if (!isDead) {
        if (isAttacking) {
          actions.get("SkeletonAttack").display(xpos, ypos);
        } else {
          actions.get("SkeletonWalk").display(xpos, ypos);
        }
      } else {
        actions.get("SkeletonDeath").display(xpos, ypos);
      }
    }
  }
}
