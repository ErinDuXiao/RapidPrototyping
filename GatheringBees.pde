ArrayList<PVector> flowers = new ArrayList<PVector>();
ArrayList<PVector> flowerSizes = new ArrayList<PVector>();
ArrayList<PVector> bees = new ArrayList<PVector>();
ArrayList<PVector> beeBuzz = new ArrayList<PVector>();
ArrayList<Boolean> beeBuzzFlgs = new ArrayList<Boolean>();
ArrayList<PVector> currentBeeBuzzRange = new ArrayList<PVector>();
float beeSize = 20;
float beeBuzzRange = 150;
int beeMin = 30;
int beeMax = 50;

int buzzCounter;

void setup(){
    size(600, 600);
}

void draw() { // tick
    renderSetup();
    renderFlowers();
    renderBuzz();
    renderBees();
    
}

void renderSetup() {
    stroke(255);
    background(184, 242, 140);
}

void renderFlowers() {
    fill(255, 100, 180);

    float flowerNum = random(0, 3);
    
    // add flowers
    for (int i=0; i < flowerNum && flowers.size() <= flowerNum && flowers.size() < 3; i++) {
        flowers.add(new PVector(random(0, 600), random(0, 600)));
        flowerSizes.add(new PVector());
    }
    
    // show
    for (int i=0; i < flowers.size(); i++) {
        PVector loc = flowers.get(i);
        PVector flowerSize = flowerSizes.get(i);
        ellipse(loc.x, loc.y, flowerSize.x, flowerSize.y);
        if (flowerSize.x >= 270) {
            flowers.remove(loc);
            flowerSizes.remove(flowerSize);
        } else {
            flowerSize.x += 0.1;
            flowerSize.y += 0.1;
        }
    }
}


void renderBees() {
    fill(255, 255, 170);
    stroke(0);
    
    float beeNum = random(beeMin, beeMax);
    
    // add bees
    for (int i=0; i < beeNum && bees.size() <= beeNum && bees.size() < beeMax; i++) {
        bees.add(new PVector(random(0, 600), random(0, 600)));
    }
    
    // show
    for (int i=0; i < bees.size(); i++) {
        PVector loc = bees.get(i);
        loc.add(new PVector(sin(frameCount * random(50)) * random(60)/70, cos(frameCount * random(50)) * random(60)/70));
        ellipse(loc.x, loc.y, beeSize, beeSize);
    }
}

void renderBuzz() {
    fill(0,0,0,0);
    for (int i=0; i < beeBuzz.size(); i++) {
        PVector loc = beeBuzz.get(i);
        PVector beeBuzzSize = currentBeeBuzzRange.get(i);
        
        if (beeBuzzSize.x <= beeBuzzRange && beeBuzzSize.y <= beeBuzzRange) {
            ellipse(loc.x, loc.y, beeBuzzSize.x, beeBuzzSize.y);
            
            for (int j=0; j < bees.size(); j++) {
                PVector bee = bees.get(j);
                
                if (beeBuzz.contains(bee)) {
                    continue;
                }
                
                //if (loc.x == bee.x && loc.y == bee.y) {
                //   continue;
                //}
                
                //println(loc.dist(bee));
                if (loc.dist(bee) <= beeBuzzSize.x/2 + beeSize/2) {
                    
                    bee.lerp(loc, 0.1);
                    
                    //if (random(20)%4 <= 1) {
                    //  bee.add(new PVector(abs(loc.x - bee.x) * 0.3, abs(loc.y - loc.y) * 0.3));
                    //} else if (random(20)%4 <= 2) {
                    //  bee.add(new PVector(abs(loc.x - bee.x) * 0.3, abs(loc.y - loc.y) * -0.3));
                    //} else if (random(20)%4 <= 3) {
                    //  bee.add(new PVector(abs(loc.x - bee.x) * -0.3, abs(loc.y - loc.y) * 0.3));
                    //} else {
                    //  bee.add(new PVector(abs(loc.x - bee.x) * -0.3, abs(loc.y - loc.y) * -0.3));
                    //}
                
                    beeBuzz.add(bee);
                    currentBeeBuzzRange.add(new PVector(0, 0));
                }
            }
            
            beeBuzzSize.x++;
            beeBuzzSize.y++;
        } else {
            beeBuzz.remove(loc);
            currentBeeBuzzRange.remove(beeBuzzSize);
        }
    }
  
}

void mouseClicked() {
    for (int i=0; i < bees.size(); i++) {
        PVector loc = bees.get(i);
        if (loc.dist(new PVector(mouseX, mouseY)) <= beeSize/2) {
            beeBuzz.add(loc);
            currentBeeBuzzRange.add(new PVector(0, 0));
        }
    }
}