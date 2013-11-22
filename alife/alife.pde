/**
 * ALIFE - Artificial Life sketch
 * By Hay Kranen < huskyr@gmail.com > < http://www.haykranen.nl >
 * Released under the terms of the MIT license 
 */
 
int minNumberOfCells = 100;
int startNumberOfCells = 100;
int maxNumberOfCells = 1000;
int matrixWidth = 40;
int matrixHeight = 40;
int screenSize = 20;
int minLife = 100;
int maxLife = 500;
boolean bumpColor = false;
boolean bumpStick = false;
boolean bumpSpeed = false;
boolean circleCells = false;
boolean bumpReverse = false;
boolean clearScreen = true;
boolean bumpAlpha = false;
boolean strokeCells = false;
boolean fillCells = true;
boolean rotateCells = false;
boolean blackAndWhite = false;
boolean alphaFillAndStoke = false;
boolean bumpBirth = true;
boolean bumpDeath = true;
boolean cellsDie = true;
float minCellSpeed = 0.1;
float maxCellSpeed = 0.3;
float bumpBirthDieChange = 0.54; // The sweet spot seems to be around 0.54

ArrayList<Cell> cells;

void setup() {
  int sw = matrixWidth * screenSize;
  int sh = matrixHeight * screenSize; 
  size(sw, sh);
  background(0);
  
  if (!strokeCells) {
    noStroke();
  }
  
  if (!fillCells) {
    noFill();
  }
  
  cells = new ArrayList<Cell>();
  
  for (int i = 0; i < startNumberOfCells; i++) {
    cells.add( new Cell(i) );
  }
}

void draw() {
  if (clearScreen) {
    background(0);
  }
  
  for (int i = 0; i < cells.size(); i++) {
    Cell cell = cells.get(i);
    
    cell.update();
        
    // Check for death
    if (cell.life < 1) {
      killCell(i);
    }
    
    int collideWith = getCollide(cell);
    
    if (collideWith != -1) {
      Cell other = cells.get( collideWith );
      cell.bumpWith( other );
      
      if (bumpBirth && bumpDeath) {
        makeOrKillCell(cell.id);
      } else if (bumpBirth && !bumpDeath) {
        makeCell();
      } else if (!bumpBirth && bumpDeath) {
        killCell(cell.id);
      }
    }
    
    if (rotateCells) {
      pushMatrix();
      translate(0, 0);
      rotate(cell.x * cell.speed);
    }
    
    cell.draw();
    
    if (rotateCells) {
      popMatrix();
    }
  }
  
  frame.setTitle("alife: " + cells.size() + " cells");
}

int getCollide(Cell cell) {
  for (int i = 0; i < cells.size(); i++) {
    Cell other = cells.get(i);
    if (cell.collidesWith(other)) {
      return i;
    }
  }
  
  return -1;
}

void makeCell() {
  if (cells.size() < maxNumberOfCells) {
    cells.add( new Cell(cells.size() + 1) );
  }
}

void makeOrKillCell(int id) {
  float r = random(1);
  
  if (r < bumpBirthDieChange) {
    makeCell();
  } else {
    killCell(id);
  }
}

void killCell(int id) {
  if (cells.size() >= minNumberOfCells && cellsDie) {
    for (int i = 0; i < cells.size(); i++) {
      if (cells.get(i).id == id) {
        cells.remove(i);
      }
    }
  }
}

void mousePressed() {
  for (int i = 0; i < 10; i++) {
    makeCell();
  }
}
