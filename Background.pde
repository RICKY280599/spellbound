class Background{

  PImage[] images;
  float[] px;
  float direction;
  boolean isDynamic;

  Background(String[] fileNames, boolean dynamic, float dir){
    images = new PImage[fileNames.length];
    for(int i = 0; i < fileNames.length; i++){
      images[i] = loadImage(fileNames[i]);
    }
    px = new float[images.length];
    direction = dir;
    isDynamic = dynamic;
  }
  
  void display(){
    if(isDynamic){
      background(images[0]);
      image(images[1], 50, -30);
      for (int i = 2 ; i < images.length; i++){
        image(images[i], (px[i]*i)-width, 0);
        image(images[i], px[i]*i, 0); 
        if((px[i]*i) > width){
          px[i] = 0;
        }
        px[i] += direction;
      }
    }
    else{
      background(images[0]);
      for(int i = 1; i < images.length; i++){
        image(images[i], 0, 0);
      }
    }
  }
  
}
