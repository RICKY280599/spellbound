class Spell{
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
      animation = new SpriteSheet("Spells/water2.png", 5,4,5,4);
      xPos = wiz.getPosition(true);
      yPos = wiz.getPosition(false);
      xSpeed = 0;
      frame = 0;
      remove = false;
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
      
    }
  }
  
  boolean getRemove(){
    return remove;
  }
  
  void updatePosition(){
   xPos += xSpeed;
   display();
   frame++;
   if (frame > 90 && type){
    remove = true; 
   }
  }
}
