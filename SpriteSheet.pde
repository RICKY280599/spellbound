class SpriteSheet{

  PImage sheet;
  PImage[] images;
  int imageCount;
  int frame;
  int customFrameRate;
  int cnt;
  
  SpriteSheet(String sheetName, int count, int fRate){
    imageCount = count;
    images = new PImage[imageCount];
    sheet = loadImage(sheetName);
    frame = 0;
    customFrameRate = fRate;
    cnt = 0;
    
    int xp = 0;
    for(int i = 0; i < imageCount; i++){
      images[i] = sheet.get(xp, 0, sheet.width/imageCount, sheet.height);
      xp += sheet.width/imageCount;
    }
  }
  
  void display(float xp, float yp){
    //frame = (frame+1)%imageCount;
    frame = ((cnt+1)/customFrameRate)%imageCount;
    cnt++;
    image(images[frame], xp, yp);
  }

}
