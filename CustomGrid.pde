enum Pattern{
  MainGrid,
  SubGrid,
}
  
class CustomGrid{
  CustomGrid(){
  }
  int grid = 8;
  
  Pattern pattern = Pattern.MainGrid;
  int mainGridWeight = 2;
  int subGrid = 8;
  int subGridWeight = 1;
  
  CustomGrid Main(int gridNum, int mainGridWeight){
    pattern = Pattern.MainGrid;
    this.grid = gridNum;
    this.mainGridWeight = mainGridWeight;
    return this;
  }
  
  CustomGrid SubGrid(int gridNum, int subGridNum, int subGridWeight){
    pattern = Pattern.SubGrid;
    this.grid = gridNum;
    this.subGrid = subGridNum;
    this.subGridWeight = subGridWeight;
    return this;
  }
  
  String getName(String dst){
    String filename = dst+"T_";
    filename += "Grid" + grid;
    switch(pattern){
      case MainGrid:
        filename += "_MainW" + mainGridWeight;
        break;
      case SubGrid:
        filename += "_Sub" + subGrid + "W" + subGridWeight;
        break;
      default:
        break;
    }
    return filename + ".svg";
  }
  
  void render(){
    fill(0);
    noStroke();
    rect(0, 0, width, height);
    switch(pattern){
      case MainGrid:
        drawGrid();
        break;
      case SubGrid:
        drawSubGrid();
        break;
      default:
        break;
    }
  }
  
  void export(){
    beginRecord(SVG, getName("./dst/"));
    render();
    endRecord();
  }
  
  void drawGrid(){
    float gw = 1.0*width/grid;
    float gh = 1.0*height/grid;
    stroke(255);
    noFill();
    strokeWeight(mainGridWeight);
    strokeCap(SQUARE);
    for(int x = 0; x <= grid; ++x){
      line(x*gw, 0, x*gw, height);    
    } 
    for(int y = 0; y <= grid; ++y){
      line(0, y*gh, width, y*gh); 
    }
  }
  
  void drawSubGrid(){
    float gw = 1.0*width/grid;
    float gh = 1.0*height/grid;
    float sw = gw/subGrid;
    float sh = gh/subGrid;
    stroke(255);
    noFill();
    strokeWeight(subGridWeight);
    strokeCap(SQUARE);
    for(int x = 0; x <= grid; ++x){
      for(int sx = 1; sx < subGrid; ++sx){
        line(x*gw+sx*sw, 0, x*gw+sx*sw, height);
      }
    } 
    for(int y = 0; y <= grid; ++y){
      for(int sy = 1; sy < subGrid; ++sy){
        line(0, y*gh+sy*sh, width, y*gh+sy*sh);
      }
    }
  }
}
