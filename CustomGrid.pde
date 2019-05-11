enum Pattern{
  MainGrid,
  SubGrid,
  Corner
}

enum CornerPattern{
  Plus,
  Cross,
  Circle
}

class CustomGrid{
  CustomGrid(){
  }
  int grid = 8;
  
  Pattern pattern = Pattern.MainGrid;
  CornerPattern cornerPattern = CornerPattern.Plus;
  float strokeWidth = 2;
  int subGrid = 8;
  
  boolean dashed = false;
  float cornerShapeSize = 10;
  
  CustomGrid Main(int gridNum){
    pattern = Pattern.MainGrid;
    this.grid = gridNum;
    return this;
  }
  
  CustomGrid SubGrid(int gridNum, int subGridNum){
    pattern = Pattern.SubGrid;
    this.grid = gridNum;
    this.subGrid = subGridNum;
    return this;
  }
  
  CustomGrid Corner(int gridNum, CornerPattern cornerPattern, int cornerShapeSize){
    pattern = Pattern.Corner;
    this.grid = gridNum;
    this.cornerPattern = cornerPattern;
    this.cornerShapeSize = cornerShapeSize;
    return this;
  }
  
  CustomGrid Dashed(boolean dashed){
    this.dashed = dashed;
    return this;
  }
  
  CustomGrid StrokeWidth(float strokeWidth){
    this.strokeWidth = strokeWidth;
    return this;
  }
  
  String getName(String dst){
    String filename = dst+"T_";
    filename += "Grid" + grid;
    String dash_str = dashed ? "Dash" : "";
    switch(pattern){
      case MainGrid:
        filename += "_Main" + dash_str + "W" + int(strokeWidth);
        break;
      case SubGrid:
        filename += "_Sub" + subGrid + dash_str + "W" + int(strokeWidth);
        break;
      case Corner:
        break;
      default:
        break;
    }
    if(pattern == Pattern.Corner){
      switch(cornerPattern){
        case Plus:
          filename += "_Plus" + "W" + int(strokeWidth) + "S" + int(cornerShapeSize);
          break;
        case Cross:
          filename += "_Cross" + "W" + int(strokeWidth) + "S" + int(cornerShapeSize);
          break;
        case Circle:
          filename += "_Ciecle" + "W" + int(strokeWidth) + "S" + int(cornerShapeSize);
          break;
        default:
          break;
      }
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
      case Corner:
        drawCorner();
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
    strokeWeight(strokeWidth);
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
    strokeWeight(strokeWidth);
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
  
  void drawCorner(){
    float gw = 1.0*width/grid;
    float gh = 1.0*height/grid;
    
    switch(cornerPattern){
      case Plus:
        stroke(255);
        noFill();
        strokeWeight(strokeWidth);
        strokeCap(SQUARE);
        break;
      case Cross:
        stroke(255);
        noFill();
        strokeWeight(strokeWidth);
        strokeCap(SQUARE);
        break;
      case Circle:
        noStroke();
        fill(255);
        ellipseMode(CENTER);
        break;
      default:
        break;
    }
    for(int y = 0; y <= grid; ++y){
      for(int x = 0; x <= grid; ++x){
        float px = x*gw;
        float py = y*gh;
        switch(cornerPattern){
          case Plus:
            line(px-cornerShapeSize, py, px+cornerShapeSize, py);
            line(px, py-cornerShapeSize, px, py+cornerShapeSize);
            break;
          case Cross:
            float corner = cos(0.25*PI) * cornerShapeSize;
            line(px-corner, py-corner, px+corner, py+corner);
            line(px-corner, py+corner, px+corner, py-corner);
            break;
          case Circle:
            circle(px, py, cornerShapeSize);
            break;
          default:
            break;
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
