class Cell {
  int direction, id, life;
  float x, y, speed;
  color col;
  
  // constructor
  Cell(int _id) {
    id = _id;
    x = random(matrixWidth);
    y = random(matrixHeight);
    col = getRandomColor();
    direction = int(random(4));
    speed = random(minCellSpeed, maxCellSpeed);
    life = int(random(maxLife)) + minLife;
  }
  
  void update() {
    checkOutOfBounds();
    updatePosition();
  }
  
  void checkOutOfBounds() {
    // Out of bounds?
    if (x > matrixWidth) {
      x = 0;
    }
    
    if (x < 0) {
      x = matrixWidth;
    }
    
    if (y > matrixHeight) {
      y = 0;
    }
    
    if (y < 0) {
      y = matrixHeight;
    }
  }
  
  void updatePosition() {    
    // Determine the right direction
    switch(direction) {
      case 0:
        // up
        y = y - speed;
        break;
      case 1:
        // right
        x = x + speed;
        break;
      case 2:
        // down
        y = y + speed;
        break;
      case 3:
        // left
        x = x - speed;
        break;
    }        
  }
  
  color getRandomColor() {
    if (blackAndWhite) {
      if (alphaFillAndStoke) {
        return color(255, 100);
      } else {
        return color(255);
      }
    } else {
      if (alphaFillAndStoke) {
        return color( random(255), random(255), random(255), 100 );
      } else {
        return color( random(255), random(255), random(255) );
      }
    }
  }    
  
  boolean collidesWith(Cell other) {
    return int(x) == int(other.x) && int(y) == int(other.y) && id != other.id;
  }
  
  void bumpWith(Cell other) {
    if (bumpSpeed) {
      speed = (speed + other.speed) / 2;
    }
    
    if (bumpStick) {
      direction = other.direction;
    }
    
    if (bumpReverse) {
      direction = (direction + 2) % 4;
      other.direction = (direction + 2) % 4;
    }
    
    if (bumpColor) {
      col = other.col;
    }
    
    if (bumpAlpha) {
      col = col & 0xffffff | (int(random(255)) << 24);
    }
  }
  
  void draw() {
    float dx = x * screenSize;
    float dy = y * screenSize;
    life = life - 1;
    
    if (circleCells) {
      ellipse(dx, dy, screenSize, screenSize);
    } else {
      rect(dx, dy, screenSize, screenSize);
    }
    
    if (fillCells) {
      fill( col );
    }
    
    if (strokeCells) {
      if (alphaFillAndStoke) {
        stroke( getRandomColor() );
      } else {
        stroke( getRandomColor() );
      }
    }
  }    
}
