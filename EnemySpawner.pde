public class EnemySpawner {
 ArrayList<Enemy> enemies = new ArrayList<>();
 float speed;
 int enemyCount;
 int spawnTimer = 0;
 int spawnInterval = 300;
 int nextEnemyIndex = 0;
 int spawnedEnemies;
 float minDistance = Float.MAX_VALUE;
 
 public void EnemyInitializer(float enemyspeed, int enemyCount){
   for (int i = 0; i < enemyCount; i++){
      speed = enemyspeed;
      Enemy newEnemy;
      this.enemyCount = enemyCount;
      if (Math.random() < 0.5) {
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
  }
 }
  
  public void handleEnemyDefeat(float wizardYPosition){
   Enemy closestEnemy = null;
  
   for (Enemy enemy : enemies) {
     if (enemy.getYpos() == wizardYPosition + 15 || enemy.getYpos() == wizardYPosition + 40) {
      float distance = enemy.getXpos();
      if (distance > 100 && distance < minDistance) {
        minDistance = distance;
        closestEnemy = enemy;
        }
      }
   }
      if (closestEnemy != null) {
        closestEnemy.updateDefeat();
        enemies.remove(closestEnemy);
        nextEnemyIndex = 0;
        easy.enemyCount--;
     }
   }
   

public int getActiveEnemyCount() {
  int activeCount = 0;
  for (Enemy enemy : enemies) {
    if (enemy.isActive()){
     activeCount++; 
    }
  }
  return activeCount;
}
}
