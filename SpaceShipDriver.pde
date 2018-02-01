float playerSize = 15;
float minionsSize = 5;
PVector playerPosition = new PVector(300, 500);
PVector thrust = new PVector(0, 0);
PVector velocity= new PVector(0.05, 0);

ArrayList<PVector> bullets = new ArrayList<PVector>(100);
float bulletsSize = 1.0;
float bulletSpeed = 3.0;

PVector planetPosition = new PVector(300, 200);
float planetSize = 50;
float planetGravityRangeSize = 150;
float planetGravityPower = 0.03;
float planetHealth = 100;

void setup(){
    size(600, 600);
  
    smooth(4);
}

void draw() { // tick
    renderSetup();
    renderPlanets();
    renderPlayer();
    renderBullets();
    checkCollision();
    updateLocation();
}

void renderSetup() {
    fill(255);
    stroke(255);
    background(0);
}

void renderPlanets() {
  
    // planet 1
    
    fill(0);
    ellipse(planetPosition.x, planetPosition.y, planetGravityRangeSize, planetGravityRangeSize);
    
    fill(planetHealth, planetHealth * 2, 255);
    ellipse(planetPosition.x, planetPosition.y, planetSize, planetSize);
    
    
  //// planet 2
  
  //fill(0);
  //ellipse(400, 0, 250, 250);
  
  //fill(255);
  //ellipse(400, 0, 100, 100);
  

}

void renderPlayer() {
    fill(255, 69, 0);
    ellipse(playerPosition.x, playerPosition.y, playerSize, playerSize);
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

void renderMinions() {
    fill(255);
    ellipse(playerPosition.x, playerPosition.y, playerSize, playerSize);
}

void checkCollision() {
    for (int i = 0; i < bullets.size(); i++) {
        PVector bulletPosition = bullets.get(i);
        
        if (bulletPosition.dist(planetPosition) <= planetSize/2) {
            // hit
            planetHealth--;
            
            if (planetHealth <= 0) {
                planetPosition = new PVector(random(600) , -100 );
                planetSize = random(300);
                planetGravityRangeSize = random(planetSize, planetSize + 200);
                planetHealth = random(500);
                planetGravityPower = random(0,1);
            }
        }
        
    }
    
    if (playerPosition.dist(planetPosition) <= planetGravityRangeSize/2) {
        playerPosition.lerp(planetPosition, planetGravityPower);
        
    }
}

void updateLocation() {
    velocity.y += 0.0005;
    playerPosition.add(thrust);
    thrust.x = 0;
    planetPosition.y += velocity.y;
    if (planetPosition.y + planetSize/2 >= 600) {
          planetPosition = new PVector(random(600) , -100 );
          planetSize = random(300);
          planetGravityRangeSize = random(planetSize, planetSize + 200);
          planetHealth = random(500);
          planetGravityPower = random(0.01, 0.5);
    }
    
    for (int i = 0; i < bullets.size(); i++) {
        PVector bulletPosition = bullets.get(i);
        bulletPosition.y -= velocity.y + bulletSpeed; 
    }
}

void keyPressed() {
    if (key == 'a'){
      thrust.x -= 10;
      
    } else if (key == 'd'){
      thrust.x += 10;
      
    } else if (key == ' '){
      
      if (bullets.size() <= 100)
        bullets.add(new PVector(playerPosition.x, playerPosition.y));
    }
}