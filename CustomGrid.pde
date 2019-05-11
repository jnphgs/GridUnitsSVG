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
  boolean dashed = false;
  
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
  
  CustomGrid Dashed(boolean dashed){
    this.dashed = dashed;
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
      if(dashed){
        drawDashedLine(x*gw, 0, x*gw, height, grid, 10);
      }else{
        line(x*gw, 0, x*gw, height);
      }
    } 
    for(int y = 0; y <= grid; ++y){
      if(dashed){
        drawDashedLine(0, y*gh, width, y*gh, grid, 10);
      }else{
        line(0, y*gh, width, y*gh);
      }
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
        if(dashed){
          drawDashedLine(x*gw+sx*sw, 0, x*gw+sx*sw, height, grid, 10);
        }else{
          line(x*gw+sx*sw, 0, x*gw+sx*sw, height);
        }
      }
    } 
    for(int y = 0; y <= grid; ++y){
      for(int sy = 1; sy < subGrid; ++sy){
        if(dashed){
          drawDashedLine(0, y*gh+sy*sh, width, y*gh+sy*sh, grid, 10);
        }else{
          line(0, y*gh+sy*sh, width, y*gh+sy*sh);
        }
      }
    }
  }
  
  void drawDashedLine(float x1, float y1, float x2, float y2, int grid, int dotNum){
    PVector v1 = new PVector(x1, y1);
    PVector v2 = new PVector(x2, y2);
    PVector dir = PVector.sub(v2, v1);
    float lineLen = dir.mag();
    int totalDot = grid*dotNum*2;
    float dotLen = lineLen / totalDot;
    dir.normalize();
    for(int i = 0; i < totalDot-1; ++i){
      float start = (0.5+i)*dotLen;
      float end = (1.5+i)*dotLen;
      if(i%2 == 0){
        line(v1.x+start*dir.x, v1.y+start*dir.y, v1.x+end*dir.x, v1.y+end*dir.y);
      }
    }
  }
}
