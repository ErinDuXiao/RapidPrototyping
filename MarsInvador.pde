PVector playerPosition = new PVector(300, 500);
float playerSize = 15;
PVector thrust = new PVector(0, 0);
PVector playerColor = new PVector(100, 255, 255);

ArrayList<PVector> bullets = new ArrayList<PVector>(100);
float bulletsSize = 2.0;
float bulletSpeed = 3.0;

ArrayList<PVector> minions = new ArrayList<PVector>(50);
float minionsSize = 15;
PVector minionsColor = new PVector(255, 255, 100);

PVector enemyPosition = new PVector(300, 10);
float enemySize = 500;
float enemyHealth = 100;

ArrayList<PVector> enemybullets = new ArrayList<PVector>(20);
float enemybulletSize = 20.0;
float enemybulletSpeed = 3.0;

void setup(){
    size(600, 600);
    minions.add(new PVector(playerPosition.x + 1, playerPosition.y - 1));
    minions.add(new PVector(playerPosition.x - 1, playerPosition.y - 1));
    minions.add(new PVector(playerPosition.x - 1, playerPosition.y - 2));
    minions.add(new PVector(playerPosition.x + 1, playerPosition.y - 2));
    
    for (int i = 0; i <= 20; i++) {
        enemybullets.add(new PVector(i * 70, -600 - i * 5));
    }

}

void draw() { // tick
    renderSetup();
    renderEnemy();
    renderPlayer();
    renderMinions();
    renderBullets();
    checkCollision();
    updateLocation();
}

void renderSetup() {
    fill(255);
    stroke(255);
    background(0);
}

void renderEnemy() {
  
    fill(255, 150, enemyHealth);
    ellipse(enemyPosition.x, enemyPosition.y, enemySize, enemySize);
    
    // attack
    for (int i = 0; i < enemybullets.size(); i++) {
        PVector bulletPosition = enemybullets.get(i);
        bulletPosition.y += enemybulletSpeed;
        ellipse(bulletPosition.x, bulletPosition.y, enemybulletSize, enemybulletSize);
        if (bulletPosition.y > 600) {
            enemybullets.remove(bulletPosition);
        }
    }
    
    if (enemybullets.size() == 0) {
        for (int i = 0; i <= 20; i++) {
          enemybullets.add(new PVector(i * 70, -600 - i * 50));
        }
    }
    
}

void renderPlayer() {
    fill(playerColor.x, playerColor.y, playerColor.z);
    rect(playerPosition.x, playerPosition.y, playerSize, playerSize);
}

void renderMinions() {
    
    for (int i = 0; i < minions.size(); i++) {
        PVector minionsPos = minions.get(i);
        
        float distanceFromPlayer = playerPosition.dist(minionsPos);
        
        float stepAlpha = 0;
        if (distanceFromPlayer > 30 + i * 50) {
            stepAlpha = 0.05;
        }
        
        minionsPos.lerp(playerPosition, stepAlpha);
        fill(i * 50, minionsColor.y, minionsColor.z);
        rect(minionsPos.x, minionsPos.y, minionsSize, minionsSize);

    }
}

void renderBullets() {
    for (int i = 0; i < bullets.size(); i++) {
        PVector bulletPosition = bullets.get(i);
        ellipse(bulletPosition.x, bulletPosition.y, bulletsSize, bulletsSize);
        if (bulletPosition.y <= 0) {
            bullets.remove(bulletPosition);
        }
    }
}

void checkCollision() {
    for (int i = 0; i < bullets.size(); i++) {
        PVector bulletPosition = bullets.get(i);
        
        if (bulletPosition.dist(enemyPosition) <= enemySize/2) {
            // hit
            enemyHealth--;
            
            if (enemyHealth <= 0) {
                // destroy the big enemy
            }
        }
        
    }
}

void updateLocation() {
    playerPosition.x = mouseX;
    playerPosition.y = mouseY;
    
    for (int i = 0; i < bullets.size(); i++) {
        PVector bulletPosition = bullets.get(i);
        bulletPosition.y -= bulletSpeed; 
    }
}

void keyPressed() {
   if (key == ' '){
      
    if (bullets.size() <= 80)
        bullets.add(new PVector(playerPosition.x, playerPosition.y));
        
        for (int i = 0; i < minions.size(); i++) {
            PVector minionPos = minions.get(i);
            bullets.add(new PVector(minionPos.x, minionPos.y));
        }
    }
}