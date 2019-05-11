import processing.svg.*;
PFont font;
CustomGrid customGrid = new CustomGrid();

void setup(){
  size(1024, 1024);
  font = createFont("SansSerif", 32);
  textFont(font);
}

void draw(){
  //customGrid.StrokeWidth(4).Corner(1, CornerPattern.Plus, width/12).render();
  //customGrid.StrokeWidth(4).Corner(1, CornerPattern.Cross, width/12).render();
  customGrid.StrokeWidth(4).Corner(1, CornerPattern.Circle, width/12).render();
}

void keyPressed(){
  switch(key){
    case 's':
      customGrid.StrokeWidth(4).Dashed(false); // style 
      customGrid.Main(1).export();
      customGrid.Main(2).export();
      customGrid.Main(4).export();
      customGrid.Main(5).export();
      
      customGrid.StrokeWidth(4).Dashed(false); // style
      customGrid.SubGrid(1, 2).export();
      customGrid.SubGrid(2, 2).export();
      customGrid.SubGrid(2, 5).export();
      customGrid.SubGrid(4, 2).export();
      customGrid.SubGrid(4, 4).export();
      customGrid.SubGrid(4, 5).export();
      customGrid.SubGrid(5, 4).export();
      customGrid.SubGrid(5, 5).export();
      
      customGrid.StrokeWidth(4).Dashed(true); // style 
      customGrid.Main(1).export();
      customGrid.Main(2).export();
      customGrid.Main(4).export();
      customGrid.Main(5).export();
      
      customGrid.StrokeWidth(4).Dashed(true); // style
      customGrid.SubGrid(1, 2).export();
      customGrid.SubGrid(2, 2).export();
      customGrid.SubGrid(2, 5).export();
      customGrid.SubGrid(4, 2).export();
      customGrid.SubGrid(4, 4).export();
      customGrid.SubGrid(4, 5).export();
      customGrid.SubGrid(5, 4).export();
      customGrid.SubGrid(5, 5).export();
      
      customGrid.StrokeWidth(8); // style
      customGrid.Corner(1, CornerPattern.Plus, width/12).export();
      customGrid.Corner(1, CornerPattern.Cross, width/12).export();
      customGrid.Corner(1, CornerPattern.Circle, width/12).export();
      
      customGrid.StrokeWidth(4); // style
      customGrid.Corner(2, CornerPattern.Plus, width/24).export();
      customGrid.Corner(2, CornerPattern.Cross, width/24).export();
      customGrid.Corner(2, CornerPattern.Circle, width/24).export();
      
      customGrid.Corner(4, CornerPattern.Plus, width/48).export();
      customGrid.Corner(4, CornerPattern.Cross, width/48).export();
      customGrid.Corner(4, CornerPattern.Circle, width/48).export();
      exit();
      break;
    default:
      break;
  }
}
