class Wizard{
  
  //SpriteSheet sheet;
  HashMap<String, SpriteSheet> actions = new HashMap<>();

  Wizard() {
    actions.put("Attack1", new SpriteSheet("WizardPack/Attack1.png", 8, 6));
    actions.put("Attack2", new SpriteSheet("WizardPack/Attack2.png", 8, 6));
    actions.put("Death", new SpriteSheet("WizardPack/Death.png", 7, 6));
    actions.put("Fall", new SpriteSheet("WizardPack/Fall.png", 2, 6));
    actions.put("Hit", new SpriteSheet("WizardPack/Hit.png", 4, 6));
    actions.put("Jump", new SpriteSheet("WizardPack/Jump.png", 2, 6));
    actions.put("Run", new SpriteSheet("WizardPack/Run.png", 8, 6));
    actions.put("Idle", new SpriteSheet("WizardPack/Idle.png", 6, 6));
  }
  
  void display(String action, float xp, float yp){
    actions.get(action).display(xp, yp);
  }
  
}
