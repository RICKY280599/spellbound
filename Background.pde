class Background{

  PImage[] images;
  float px;
  float direction;

  Background(String[] fileNames){
    images = new PImage[fileNames.length];
    for(int i = 0; i < fileNames.length; i++){
      images[i] = loadImage(fileNames[i]);
    }
    px = 0;
    direction = 0.50;
  }
  
  void display(){
    image(images[0], 0, 0);
    for(int i = 1; i < images.length; i++){
      image(images[i], (px*i)-width, 0);
      image(images[i], px*i, 0);
      if((px*i) >= width || (px*i) < 0){
        direction = -1*direction;
      }
    }
    px = px + direction;
  }
  
}
