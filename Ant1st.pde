ArrayList<PVector> foodLocation = new ArrayList<PVector>();
float[] foodSize = new float[3];

ArrayList<PVector> ants = new ArrayList<PVector>();
ArrayList<PVector> myants = new ArrayList<PVector>();
float antSize = 5;
float antNumber = 50;

PVector nestLocation = new PVector(300, 300);

float[][] foodPheromoneInfo = new float[121][121];
float[][] nestPheromoneInfo = new float[121][121];

void setup(){
    size(600, 600);
    for (int i = 0; i < antNumber; i++) {
        ants.add(new PVector(random(0, 600), random(0, 600)));
    }
    
    for (int i=0; i < 3; i++) {
      foodLocation.add(new PVector(random(10, 590), random(10, 590)));
      foodSize[i] = random(10, 50);
    }
}

void draw() { // tick
    renderSetup();
    //renderNest();
    renderFoods();
    renderAnts();
    
    for(int i = 0; i < foodPheromoneInfo.length ;i++) {
        for(int j = 0; j < foodPheromoneInfo.length ;j++) {
            foodPheromoneInfo[i][j] -= 0.01;
        }
    }
}

void renderSetup() {
    fill(0);
    stroke(0);
    background(255, 235, 205);
    

}
void renderNest() {
    fill(0);
    ellipse(nestLocation.x, nestLocation.y, 20, 20);
}

void renderFoods() {  
    stroke(255);
    fill(255, 70, 70);  
    for (int i=0; i < foodLocation.size(); i++) {
        PVector foodLoc = foodLocation.get(i);
        ellipse(foodLoc.x, foodLoc.y, foodSize[i], foodSize[i]);
    }
    
}

void renderAnts() {
    fill(0);
    stroke(0);
    PVector myAnt = ants.get(0);
    myAnt = new PVector(mouseX, mouseY);
    ellipse(myAnt.x, myAnt.y, antSize, antSize);
    
    int x = (int)(myAnt.x/antSize);
    int y = (int)(myAnt.y/antSize);
    
    foodPheromoneInfo[x][y] += 0.1;
    
    // show
    for (int i=1; i < ants.size(); i++) {
        PVector loc = ants.get(i);
        if(myAnt.dist(loc) < 30) {
            ants.remove(loc);
            myants.add(loc);
        }
        
        loc.add(new PVector(sin(frameCount) * cos(frameCount), sin(frameCount) * cos(frameCount)));
        
        //x = (int)(loc.x/antSize);
        //y = (int)(loc.y/antSize);
        
        //if(y > 5 && y < 120 && x > 5 && x < 120) {
        //    float forward = foodPheromoneInfo[x][y-1] + foodPheromoneInfo[x-1][y-1] + foodPheromoneInfo[x+1][y-1];
        //    float back = foodPheromoneInfo[x][y+1] + foodPheromoneInfo[x-1][y+1] + foodPheromoneInfo[x+1][y+1];
        //    if (forward > back) {
        //        loc.add(new PVector(0,-1));
        //        foodPheromoneInfo[x][y] += 0.1;
        //    } else if (forward < back) {
        //        loc.add(new PVector(0,+1));
        //        foodPheromoneInfo[x][y] += 0.1;
        //    } else {
        //        loc.add(new PVector(random(-1,1),random(-1,1)));
        //    }

        //    float left = foodPheromoneInfo[x-1][y-1] + foodPheromoneInfo[x-1][y] + foodPheromoneInfo[x-1][y+1];
        //    float right = foodPheromoneInfo[x+1][y-1] + foodPheromoneInfo[x+1][y] + foodPheromoneInfo[x+1][y+1];
            
        //    if (left > right) {
        //        loc.add(new PVector(-1,0));
        //        foodPheromoneInfo[x][y] += 0.1;
        //    } else if (left < right) {
        //        loc.add(new PVector(+1,0));
        //        foodPheromoneInfo[x][y] += 0.1;
        //    } else {
        //        loc.add(new PVector(random(-1,1),random(-1,1)));
        //    }
        //}

        
        ellipse(loc.x, loc.y, antSize, antSize);
    }
    
    PVector prev = myAnt;
    for (int i=0; i < myants.size(); i++) {
        PVector current = myants.get(i);
        
        if (prev.dist(current) > 30) {
            current.lerp(prev, 0.1);
        }
        
        ellipse(current.x, current.y, antSize, antSize);
        ellipse(current.x, current.y-1, antSize, antSize);
        
        prev = current;
        
        for (int j = 0; j < foodLocation.size();j++) {
            PVector foodLoc = foodLocation.get(j);
            if (foodLoc.dist(myAnt) < foodSize[j] && myants.size() > foodSize[j]) {
                foodSize[j] -= 0.01;
            }
        }
    }
}

void mouseClicked() {
    foodPheromoneInfo[(int)(mouseX/antSize)][(int)(mouseY/antSize)] += 0.1;
}