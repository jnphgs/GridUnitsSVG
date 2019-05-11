import processing.svg.*;
boolean bSave = false;
PFont font;
CustomGrid customGrid = new CustomGrid();

void setup(){
  size(1024, 1024);
  font = createFont("SansSerif", 32);
  textFont(font);
}

void draw(){
  if(bSave){
    
    customGrid.Dashed(true).Main(1, 2).export();
    customGrid.Main(2, 2).export();
    customGrid.Main(3, 2).export();
    customGrid.Main(4, 2).export();
    customGrid.Main(5, 2).export();
    customGrid.SubGrid(1, 2, 1).export();
    customGrid.SubGrid(2, 2, 1).export();
    customGrid.SubGrid(2, 5, 1).export();
    customGrid.SubGrid(3, 3, 1).export();
    customGrid.SubGrid(3, 5, 1).export();
    customGrid.SubGrid(4, 2, 1).export();
    customGrid.SubGrid(4, 4, 1).export();
    customGrid.SubGrid(4, 5, 1).export();
    customGrid.SubGrid(5, 4, 1).export();
    customGrid.SubGrid(5, 5, 1).export();
    bSave = false;
    exit();
  }
  
  customGrid.Dashed(true).Main(4, 4).render();
  
}

void keyPressed(){
  switch(key){
    case 's':
      bSave = true;
      break;
    default:
      break;
  }
}
