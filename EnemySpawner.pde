public class EnemySpawner {
 ArrayList<Enemy> enemies = new ArrayList<>();
 float speed;
 int enemyCount;
 int spawnTimer = 0;
 int spawnInterval = 300;
 int nextEnemyIndex = 0;
 
 public void EnemyInitializer(float enemyspeed, int enemyCount){
   for (int i = 0; i < enemyCount; i++){
      speed = enemyspeed;
      Enemy newEnemy;
      if (random(0,2) < 1) {
        newEnemy = new GroundEnemy(enemyspeed); 
      } else {
        newEnemy = new FlyingEnemy(enemyspeed);
      }
      enemies.add(newEnemy);
       }
      }
 
 public void spawnEnemy() {
  if(nextEnemyIndex < enemies.size()) {
   Enemy enemyToSpawn = enemies.get(nextEnemyIndex);
   enemyToSpawn.setActive(true);
   nextEnemyIndex++;
   
   for (Enemy enemy : enemies) {
    if (enemy.isActive()) {
      enemy.updatePosition(speed);
   }
  }
 }
 }
  
  public void handleEnemyDefeat(float wizardYPosition){
    Enemy closestEnemy = null;
    float minDistance = Float.MAX_VALUE;
   for (Enemy enemy : enemies) {
     if (enemy.getYpos() == wizardYPosition + 15 || enemy.getYpos() == wizardYPosition + 40) {
      float distance = enemy.getXpos() - (-50);
      
      if (distance > 0 && distance < minDistance) {
        minDistance = distance;
        closestEnemy = enemy;
     }
  }
}

if (closestEnemy != null){
 closestEnemy.updateDefeat();
 enemies.remove(closestEnemy);
}
}
}
