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
    square(75, 535, 50);
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
     System.out.println(input);
     System.out.println(easyWord);
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
       System.out.println("easy complete");
       wiz.updateEasyAttack();
       generateWord(true);
       input = "";
     }
     if (input.equalsIgnoreCase(hardWord)){
       System.out.println("hard complete");
       wiz.updateHardAttack();
       generateWord(false);
       input = "";
     }
   }
 }
}
