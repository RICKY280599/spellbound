class Layout {

  HashMap<String, PImage> tiles = new HashMap<>();
  PImage img;

  Layout() {
    img = loadImage("Tiles/Stone.png");
    tiles.put("Stone", img);
    img = loadImage("Tiles/Grass.png");
    tiles.put("Grass", img);
    img = loadImage("Tiles/GroundWPilar.png");
    tiles.put("GroundWPillar", img);
    img = loadImage("Tiles/Pillar.png");
    tiles.put("Pillar", img);
    img = loadImage("Tiles/Platform.png");
    tiles.put("Platform", img);
    img = loadImage("Tiles/FloatingPlatform.png");
    tiles.put("FloatingPlatform", img);
  }


  void display() {
    //Display grass floor
    img = tiles.get("Grass");
    noStroke();
    fill(0);
    rect(0, (height - 75) - 100, width, 100);
    for (float px = width; px > (-img.width); px -= 80) {
      image(img, px, (height - 90) - 100);
    }

    //Display bases of pillar
    img = tiles.get("GroundWPillar");
    image(img, 620, (height - 105) - 100);
    image(img, -93, (height - 105) - 100);

    //Display pillars
    img = tiles.get("Pillar");
    image(img, 718, (height - 105) - 150);
    image(img, 5, (height - 105) - 150);

    //Display platforms attached to pillar
    img = tiles.get("Platform");
    image(img, 653, (height - 105) - 180);
    image(img, -60, (height - 105) - 180);

    //connect platforms
    img = tiles.get("FloatingPlatform");
    for (float px = width; px > (-img.width); px -= 80) {
      image(img, px, (height - 90) - 195);
    }

    //Display stone floor
    img = tiles.get("Stone");
    rect(0, (height - 75), width, 75);
    for (float px = width; px > (-img.width); px -= 80) {
      image(img, px, (height - 90));
    }
  }
}
