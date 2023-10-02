class Connect4Utility {

  static List<List<int>> checkGameOver(List<List<int>> values){  // returns [] if game not over, and the winning cells if game over
    List<List<int>> result = [];
    for (int i=0;i<values.length;i++){
      for (int j=0;j<values[0].length;j++){
        if (values[i][j] != 0){
          result = checkNeighbours(values,i,j);
          if (result.isNotEmpty){
            return result;
          }
        }
      }
    }
    return result;
  }

  static List<List<int>> checkNeighbours(List<List<int>> value, int row, int column){
    if (checkHorizontal(value, row, column)){
      return [[row, column], [row, column+1], [row, column+2], [row, column+3]];
    } else  if (checkVertical(value, row, column)){
      return [[row, column], [row+1, column], [row+2, column], [row+3, column]];
    } else  if (checkDiagonal(value, row, column, true)){
      return [[row, column], [row+1, column+1], [row+2, column+2], [row+3, column+3]];
    } else  if (checkDiagonal(value, row, column, false)){
      return [[row, column], [row+1, column-1], [row+2, column-2], [row+3, column-3]];
    }
    return [];
  }

  static bool checkHorizontal(List<List<int>> values, int row, int column){
    if (values.length-column<4){
      return false;
    }
    int i = 1;
    int value = values[row][column];
    while (i < 4){
      if (value == values[row][column+i]){
        if (i == 3){
          return true;
        }
        i++;
      } else {
        break;
      }
    }
    return false;
  }

  static bool checkVertical(List<List<int>> values, int row, int column){
    if (values.length-row<4){
      return false;
    }
    int i = 1;
    int value = values[row][column];
    while (i < 4){
      if (value == values[row+i][column]){
        if (i == 3){
          return true;
        }
        i++;
      } else {
        break;
      }
    }
    return false;
  }

  static bool checkDiagonal(List<List<int>> values, int row, int column, bool side){
    if (side){
      if (values.length-row<4 || values.length-column<4){
        return false;
      }
    } else {
      if (row > 1 || column < 1){
        return false;
      }
    }
    int i = 1;
    int value = values[row][column];
    while (i < 4){
      if (value == values[row+i][side ? column+i : column-i]){
        if (i == 3){
          return true;
        }
        i++;
      } else {
        break;
      }
    }
    return false;
  }
}