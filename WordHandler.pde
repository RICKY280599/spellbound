class WordList{
 String easyWord; 
 String hardWord;
 String input;
 int currentWord;
 List<String> easyList;
 List<String> hardList;
 WordList(){
   easyWord = "";
   input = "";
   hardWord = "";
   currentWord = -1;
   easyList = new ArrayList();
   hardList = new ArrayList();
 }
 String getWord(boolean easy){
   if(easy){
     return easyWord; 
   }
   else{
     return hardWord; 
   }
 }
 void generateWord(boolean easy){
   if (easy){
     easyWord = easyList.get(int(random(easyList.size()))); 
   }
   else{
     hardWord = hardList.get(int(random(hardList.size()))); 
   }
 }
 void setLists(List<String> easyWords, List<String> hardWords){
  easyList = easyWords;
  hardList = hardWords;
 }
 void display(){
    textAlign(LEFT);
    fill(3, 252, 240);
    PImage easyIcon = loadImage("spells/waterIcon.png");
    easyIcon.resize(50,50);
    image(easyIcon, 75, 535);
    PImage easyIconFrame = loadImage("spells/waterIconFrame.png");
    easyIconFrame.resize(50,50);
    image(easyIconFrame, 75, 535);
    text(getWord(true),150,570);
    if (currentWord == 0 || currentWord == 2){
      fill(179, 2, 166);
      text(input,150,570);
    }
    fill(3, 252, 240);
    square(425, 535, 50);
    text(getWord(false),500,570); 
    if (currentWord == 1 || currentWord == 2){
      fill(179, 2, 166);
      text(input,500,570);
    }
    fill(3, 252, 240);
 }
 void update(){
   if (key != CODED){
     if (input == ""){
        currentWord = -1; 
     }
     input += key;
     if (easyWord.indexOf(input.toLowerCase()) != 0 && hardWord.indexOf(input.toLowerCase()) != 0){
       input = "";
     }
     if (easyWord.indexOf(input.toLowerCase()) == 0 && hardWord.indexOf(input.toLowerCase()) == 0){
        currentWord = 2; 
     }  
     else if(easyWord.indexOf(input.toLowerCase()) == 0){
        currentWord = 0; 
     }
     else if (hardWord.indexOf(input.toLowerCase()) == 0){
         currentWord = 1;
     }
     if (input.equalsIgnoreCase(easyWord)){
       wiz.updateEasyAttack();
       Spell spell = new Spell(true);
       spells.add(spell);
       spawner.handleEnemyDefeat(wiz.ypos);
       generateWord(true);
       input = "";
     }
     if (input.equalsIgnoreCase(hardWord)){
       wiz.updateHardAttack();
       spawner.handleEnemyDefeat(wiz.ypos);
       generateWord(false);
       input = "";
     }
 }
}
}
