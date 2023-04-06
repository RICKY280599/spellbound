public interface Enemy {
 void updatePosition(float speed);
 void updateDefeat();
 float getYpos();
 float getXpos();
 boolean isActive();
 void setActive(boolean active);
}
