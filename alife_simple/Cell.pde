class Cell {
  int direction, col;
  float x, y, speed, size;
  int numberOfColors = 255 * 255 * 255; 
  
  Cell() {
    x = random(width);
    y = random(height);
    float colNumber = random(-numberOfColors, 0);
    col = round(colNumber);
    speed = random(cellMinimalSpeed, cellMaximumSpeed);
    size = random(cellMinimalSize, cellMaximumSize);
    float dir = random(0, 3);
    direction = round(dir);
  }
}
