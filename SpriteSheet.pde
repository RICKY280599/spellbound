class SpriteSheet{

  PImage sheet;
  PImage[] images;
  int xCount;
  int yCount;
  int frame;
  int customFrameRate;
  int cnt;
  
  SpriteSheet(String sheetName, int count, int fRate){
    xCount = count;
    yCount = 1;
    images = new PImage[xCount];
    sheet = loadImage(sheetName);
    frame = 0;
    customFrameRate = fRate;
    cnt = 0;
    
    int xp = 0;
    for(int i = 0; i < xCount; i++){
      images[i] = sheet.get(xp, 0, sheet.width/xCount, sheet.height);
      xp += sheet.width/xCount;
    }
  }
  
  SpriteSheet(String sheetName, int count, int fRate, boolean reverse){
    xCount = count;
    yCount = 1;
    images = new PImage[xCount];
    sheet = loadImage(sheetName);
    frame = 0;
    customFrameRate = fRate;
    cnt = 0;
    
    int xp = 0;
    if (reverse){
      for(int i = 0; i < xCount; i++){
        images[images.length - i] = sheet.get(xp, 0, sheet.width/xCount, sheet.height);
        xp += sheet.width/xCount;
      }
    }
    else{
      for(int i = 0; i < xCount; i++){
        images[i] = sheet.get(xp, 0, sheet.width/xCount, sheet.height);
        xp += sheet.width/xCount;
      }
    }
  }
  
  SpriteSheet(String sheetName, int count, int fRate, float scale){
    xCount = count;
    yCount = 1;
    images = new PImage[xCount];
    sheet = loadImage(sheetName);
    frame = 0;
    customFrameRate = fRate;
    cnt = 0;
    
    int xp = 0;
    for(int i = 0; i < xCount; i++){
      images[i] = sheet.get(xp, 0, sheet.width/xCount, sheet.height);
      images[i].resize(int((sheet.width/xCount) * scale), int(sheet.height/yCount * scale));
      xp += sheet.width/xCount;
    }
  }
  
  SpriteSheet(String sheetName, int countX, int countY, int fRate, float scale){
    xCount = countX;
    yCount = countY;
    images = new PImage[xCount*yCount];
    sheet = loadImage(sheetName);
    frame = 0;
    customFrameRate = fRate;
    cnt = 0;
    
    int xp = 0;
    int yp = 0;
    int count = 0;
    for(int i = 0; i < xCount; i++){
      for(int j = 0; j < yCount; j++){
        images[count] = sheet.get(xp, yp, sheet.width/xCount, sheet.height/yCount);
        images[count].resize(int((sheet.width/xCount) * scale), int(sheet.height/yCount * scale));
        count++;
        xp += sheet.width/xCount;
      }
      yp += sheet.height/yCount;
    }
  }
  
  void display(float xp, float yp){
    //frame = (frame+1)%imageCount;
    frame = ((cnt+1)/customFrameRate)%(xCount*yCount);
    cnt++;
    image(images[frame], xp, yp);
  }

}
