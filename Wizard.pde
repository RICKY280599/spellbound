class Wizard {

  //SpriteSheet sheet;
  HashMap<String, SpriteSheet> actions = new HashMap<>();
  float xpos, ypos;
  PImage mount;
  boolean isFlying;
  boolean easyAttack;
  boolean hardAttack;
  int currentFrame;

  Wizard() {
    actions.put("Attack1", new SpriteSheet("WizardPack/Attack1.png", 8, 6));
    actions.put("Attack2", new SpriteSheet("WizardPack/Attack2.png", 8, 6));
    actions.put("Death", new SpriteSheet("WizardPack/Death.png", 7, 6));
    actions.put("Fall", new SpriteSheet("WizardPack/Fall.png", 2, 6));
    actions.put("Hit", new SpriteSheet("WizardPack/Hit.png", 4, 6));
    actions.put("Jump", new SpriteSheet("WizardPack/Jump.png", 2, 6));
    actions.put("Run", new SpriteSheet("WizardPack/Run.png", 8, 6));
    actions.put("Idle", new SpriteSheet("WizardPack/Idle.png", 6, 6));

    //Load Wizard's cloud mount
    mount = loadImage("WizardPack/FlyingCloud.png");
    isFlying = true;

    //Initial wizard position
    xpos = -50;
    ypos = height - 215;
    
    //Set attack status
    easyAttack = false;
    hardAttack = false;
  }

  void display(String action, float xp, float yp) {
    actions.get(action).display(xp, yp);
    if (isFlying) {
      image(mount, xp+85, yp+125);
    }
  }

  void update() {
    //goes back to idle after attack animation is finished
    if (easyAttack == true && frameCount < currentFrame + 49) {
      display("Attack1", xpos, ypos);
    } else if (hardAttack == true && frameCount < currentFrame + 49) {
      display("Attack2", xpos, ypos);
    } else {
      display("Idle", xpos, ypos);
      easyAttack = false;
      hardAttack = false;
    }
  }

  void updatePosition() {
    if (key == CODED) {
      if (keyCode == UP && ypos > 0) {
        ypos -= 100;
      }
      if (keyCode == DOWN && ypos < height - 300) {
        ypos += 100;
      }
    }

    //Check if flying
    if (ypos <= (height - 215) - (100 * 3)) {
      isFlying = true;
    } else {
      isFlying = false;
    }
  }
  
  void updateEasyAttack() {
    easyAttack = true;
    currentFrame = frameCount;
  }
  
  void updateHardAttack() {
    hardAttack = true;
    currentFrame = frameCount;
  }
}
