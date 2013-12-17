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
    
    if (direction == 0) {
      // up 
      y = y - speed;
    } else if (direction == 1) {
      // right
      x = x + speed;
    } else if (direction == 2) {
      // down
      y = y + speed;
    } else if (direction == 3) {
      // left
      x = x - speed;
    }
  }

  color getRandomColor() {
    if (blackAndWhite) {
      if (alphaFillAndStoke) {
        return color(255, 100);
      } 
      else {
        return color(255);
      }
    } 
    else {
      if (alphaFillAndStoke) {
        return color( random(255), random(255), random(255), 100 );
      } 
      else {
        return color( random(255), random(255), random(255) );
      }
    }
  }    

  boolean collidesWith(Cell other) {
    // Hier gaan we checken of de andere cell botst met de huidige cell:
    if (
      int(x) == int(other.x) && // als de x van de cell hetzelfde is van die andere
      int(y) == int(other.y) && // én als de y ook hetzelfde is
      id != other.id // én als het nummer van de cell niet hetzelfde is (want dan is het dezelfde cell!)
    ) {
      // Dan is er een botsing
      return true;
    } else {
      // En anders niet
      return false;
    }
  }

  void bumpWith(Cell other) {
    if (bumpSpeed) {
      speed = (speed + other.speed) / 2;
    }

    if (bumpStick) {
      direction = other.direction;
    }

    if (bumpReverse) {
      //Modulo, ook wel heftig
      direction = (direction + 2) % 4;
      other.direction = (direction + 2) % 4;
    }

    if (bumpColor) {
      col = other.col;
    }
  }

  void draw() {
    float dx = x * screenSize;
    float dy = y * screenSize;
    life = life - 1;

    if (circleCells) {
      ellipse(dx, dy, screenSize, screenSize);
    } 
    else {
      rect(dx, dy, screenSize, screenSize);
    }

    if (fillCells) {
      fill( col );
    }

    if (strokeCells) {
      if (alphaFillAndStoke) {
        stroke( getRandomColor() );
      } 
      else {
        stroke( getRandomColor() );
      }
    }
  }
}

