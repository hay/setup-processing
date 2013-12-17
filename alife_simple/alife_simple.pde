/**
 * ALIFE - Artificial Life sketch - Simple version
 * By Hay Kranen < huskyr@gmail.com > < http://www.haykranen.nl >
 * Released under the terms of the MIT license 
 */

// Verander deze waardes voor grappige effecten
int numberOfCells = 50; // het aantal blokjes op het scherm
int cellMinimalSize = 20; // minimale grootte van een blokje 
int cellMaximumSize = 50; // maximale grootte van een blokje
float cellMinimalSpeed = 1; // minimale snelheid van een blokje
float cellMaximumSpeed = 3; // maximale snelheid van een blokje
boolean clearScreen = true; // maak het scherm leeg na elke tekenbeurt
boolean drawRectangles = true; // zet dit op false om cirkels te tekenen
boolean shakyCells = false; // als je dit op true zet krijgen de blokjes Parkinson

// Hier maken we een array aan met alle cellen (als je numberOfCells hoger maakt worden het er dus meer)
Cell[] cells = new Cell[ numberOfCells ];

// Met dit stukje code zetten we het scherm voor de eerste keer klaar
void setup() {
  size(900, 500); // hoe groot is het scherm?
  background(0); // maak de achtergrond voor de eerste keer zwart
  
  // Maak alle nieuwe cellen aan  
  for (int i = 0; i < numberOfCells; i++) {
    cells[i] = new Cell();
  }
}

// De rest van de code wordt ongeveer 60 keer per seconde uitgevoerd om de cellen te tekenen
// Dit is dus eigenlijk het belangrijkste deel van de code
void draw() {
  if (clearScreen == true) {
    // Maak de achtergrond zwart. Zet 'clearScreen' eens op false (helemaal bovenin) of verander het getal
    // van 0 in iets hogers (bijvoorbeeld 1000)
    background(0);
  }
  
  // Dit is het belangrijkste deel van de code, hier gaan we door alle cellen heenlopen en kijken 
  // we wat de nieuwe waardes moeten zijn
  for (int i = 0; i < numberOfCells; i++) {
    // Zoek de cel op zodat de onderstaande code makkelijker te lezen is
    Cell cell = cells[i];
    
    if (drawRectangles == true) {
      // drawRectangles staat op true, teken vierkantjes
      rect(cell.x, cell.y, cell.size, cell.size);
    } else {
      // drawRectangles staat op false, teken cirkels
      ellipse(cell.x, cell.y, cell.size, cell.size);
    }
   
    // Vul de vorm met de kleur
    fill(cell.col);
    
    // Als we graag cellen met 'Parkinson' willen veranderen we gewoon elke keer de richting
    // waar ze naar toe gaan
    if (shakyCells == true) {
      float direction = random(0,3);
      cell.direction = round(direction);
    }    
    
    // Welke kant gaat de cel op bij het volgende frame?    
    if (cell.direction == 0) {
      // naar boven
      cell.y = cell.y - cell.speed;
    } 
    
    if (cell.direction == 1) {
      // naar rechts
      cell.x = cell.x + cell.speed;
    }
   
    if (cell.direction == 2) {
      // naar beneden
      cell.y = cell.y + cell.speed;
    }
    
    if (cell.direction == 3) {
      // naar links
      cell.x = cell.x - cell.speed;
    }
    
    // Is de cell buiten het scherm, en zo ja, zet 'm dan weer terug op een 
    // plek die we wel kunnen zien
    if (cell.x > width) {
      // De cell staat buiten het scherm aan de rechterkant, zet 'm terug naar links
      cell.x = 0;
    }
    
    if (cell.x < 0) {
      // De cell staat links buiten het scherm, zet 'm helemaal rechts
      cell.x = width;
    }
    
    if (cell.y > height) {
      // De cell staat beneden buiten het scherm, zet 'm weer bovenaan
      cell.y = 0;
    }
    
    if (cell.y < 0) {
      // De cell staat boven buiten het scherm, zet 'm onderaan
      cell.y = height;
    }
  }
}
