//Functionality for both barrier and health
class Barrier {

  PImage entireSet;
  PImage barrierTile;
  PImage health;
  PImage noHealth;
  float originalHealthLength;
  float HP;
  float decrementValue;
  boolean gameOver;

  Barrier(int maxHealth) {
    entireSet = loadImage("BarrierPack/Tiles.png");
    //gets (x, y, width, height) of image
    barrierTile = entireSet.get(89, 40, 7, 9);

    //loads full health bar and no health bar
    entireSet = loadImage("BarrierPack/HealthFull.png");
    health = entireSet.get(57, 93, 433, 21);
    entireSet = loadImage("BarrierPack/HealthEmpty.png");
    noHealth = entireSet.get(53, 189, 442, 30);

    //Reloads HealthFull so that it can be used repeatedly for when enemies decrease the health bar
    entireSet = loadImage("BarrierPack/HealthFull.png");
    originalHealthLength = 433;
    HP = maxHealth;
    decrementValue = originalHealthLength/HP;
    gameOver = false;
  }

  void display() {
    //makes image around 50% transparent
    tint(255, 130);
    image(barrierTile, 108, 25, 45, height - 100);
    noTint();

    //Draws the frame of the health bar
    image(noHealth, 0, 0, 439, 25);

    //Decrementing when enemies hit the barrier is done in Spellbound.pde

    //only draws the health bar if current HP is greater than 0
    if (originalHealthLength > 0) {
      health = entireSet.get(57, 93, int(originalHealthLength), 21);
      image(health, 3, 2);
    } else {
      //Player has lost and a game over screen can now be drawn
      gameOver = true;
    }
  }
}
