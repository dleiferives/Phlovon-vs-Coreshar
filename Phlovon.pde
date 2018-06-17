static int _WIDTH = 640; // set me

//Auto Generated from _WIDTH ---
static int _HEIGHT = (int)(_WIDTH * .8);
static float playWindowHeight = _WIDTH * .65;
static float cellSize = _WIDTH/20;
static float menuPosY = playWindowHeight + 1;
static float menuHeight = _HEIGHT - menuPosY;
//--------------

Cell[][] Grid = new Cell[20][13];
PImage[] TowerSprites;

PImage field;
PImage path;
PImage pathMask;

Cell hoverCell = null;

//Gameplay Variables----
ArrayList<Tower> AllTowers = new ArrayList<Tower>();
//------------------

void setup() {
  size(620  , 512);

  //initialize Grid ---
  for (int x = 0; x < Grid.length; x++) {
    for (int y = 0; y < Grid[0].length; y++) {
      Grid[x][y] = new Cell(x, y);
    }
  }
  //--------

  field = loadImage("grass.png");
  path = loadImage("dirt.png");
  pathMask = loadImage("mask.png");
  path.mask(pathMask);
  
  TowerSprites = new PImage[]{
    loadImage("towers/t1.png"),
    //more sprites
  };
}

void draw() {
  image(field, 0, 0, width, playWindowHeight);
  image(path, 0, 0, width, playWindowHeight);
  
  for(int i = 0; i < AllTowers.size(); i++){
    AllTowers.get(i).drawMe();
  }
  

  mouseCheck();
}

void mouseCheck() {
  int x = (int)(mouseX / cellSize);
  int y = (int)(mouseY / cellSize);

  if (x < Grid.length && y < Grid[0].length){
    hoverCell = Grid[x][y];
    hoverCell.outlineMe();
  }
}

void mousePressed(){
  if(hoverCell != null){
    if(hoverCell.buildable()) hoverCell.buildOn(new Tower(hoverCell.x, hoverCell.y, 0));
  }
}

class Cell {
  int x;
  int y;
  
  Tower occupant = null;
  
  void buildOn(Tower t){
    if(buildable()){
      occupant = t;
      AllTowers.add(occupant);
    }
  
  }
  
  boolean buildable(){
    if(occupant == null)return true;
    else return false;
  }
  
  void outlineMe() {
    noFill();
    stroke(#00FF00);
    rect(x * cellSize, y * cellSize, cellSize, cellSize);
  }

  Cell(int _x, int _y) {
    x = _x;
    y = _y;
  }
}

class Tower {
  int cellX;
  int cellY;
  int spriteIndex;
  int tint;
  
  void drawMe(){
    image(TowerSprites[spriteIndex], cellX * cellSize, cellY * cellSize, cellSize, cellSize);
  }
  
  Tower(int x, int y, int sprite){
    cellX = x;
    cellY = y;
    spriteIndex = sprite;
  }
} 
