public interface Enemy {
  void updatePosition(float speed);
  public void updateDefeat();
  float getYpos();
  float getXpos();
  boolean isActive();
  void setActive(boolean active);
}
