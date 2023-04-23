public class EnemySpawner {
  ArrayList<Enemy> enemies = new ArrayList<>();
  float speed;
  int enemyCount = -1;
  int spawnTimer = 0;
  int spawnInterval = 300;
  int nextEnemyIndex = 0;
  int spawnedEnemies;

  float minDistance = 300;
  int wave = 1;
  boolean spawnNewWave = true;
  float hardDistance = 900;

  public void EnemyInitializer(float enemyspeed, int enemyCount) {
    for (int i = 0; i < enemyCount; i++) {
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
    if (nextEnemyIndex < enemies.size()) {
      Enemy enemyToSpawn = enemies.get(nextEnemyIndex);
      enemyToSpawn.setActive(true);
      nextEnemyIndex++;
    }
  }

  public void handleEnemyDefeat(float wizardYPosition, boolean isHardWord) {
    ArrayList<Enemy> closestEnemies = new ArrayList<>();
    //Enemy closestEnemy = null;
    //Enemy[] closestEnemies = new Enemy[];
    //float[] minDistances = new float[] {Float.MAX_VALUE, Float.MAX_VALUE, Float.MAX_VALUE};

    if (!isHardWord) {
      for (Enemy enemy : enemies) {
        if (enemy.getYpos() == wizardYPosition + 15 || enemy.getYpos() == wizardYPosition + 40 || enemy.getYpos() == wizardYPosition + 115 || enemy.getYpos() == wizardYPosition + 140 || enemy.getYpos() == wizardYPosition - 85 || enemy.getYpos() == wizardYPosition - 60) {
          float distance = enemy.getXpos();
          if (distance > 0 && distance < 250) {
            closestEnemies.add(enemy);
          }
        }
      }
      for (Enemy closeEnemy : closestEnemies) {
        if (closeEnemy != null) {
          closeEnemy.updateDefeat();
          enemies.remove(closeEnemy);
          enemyCount--;
          nextEnemyIndex = 0;

          if (endlessMode && enemies.size() == 0) {
            spawnNewWave = true;
          }
        }
      }
    }
  }

  public int getActiveEnemyCount() {
    int activeCount = 0;
    for (Enemy enemy : enemies) {
      if (enemy.isActive()) {
        activeCount++;
      }
    }
    return activeCount;
  }

  public void removeEnemy() {
    nextEnemyIndex = 0;
    enemyCount--;

    if (endlessMode && enemies.size() == 0) {
      spawnNewWave = true;
    }
  }

  public void spawnWave() {
    int enemyCount = (wave * 10);
    //originally float enemySpeed = 1.0 + (0.05 * wave);
    float enemySpeed = 1.5 + (0.5 * wave);

    EnemyInitializer(enemySpeed, enemyCount);
    nextEnemyIndex = 0;
    spawnNewWave = false;
  }
}
