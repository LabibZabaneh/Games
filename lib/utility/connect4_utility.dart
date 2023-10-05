class Connect4Utility {

  static bool doesMoveWin(List<List<int>> gameValues, int column, int value){
    List<List<int>> values = [for (var sublist in gameValues) [...sublist]]; // create a deep copy
    if (!doesColumnHasSpace(values, column)){
      return false;
    }
    values = move(values, column, value);
    if (checkGameOver(values).isNotEmpty){
      return true;
    }
    return false;
  }

  static List<List<int>> move(List<List<int>> values, int column, int value){
    for (int i=values[0].length-1;i>=0;i--){
      if (values[i][column] == 0){
        values[i][column] = value;
        return values;
      }
    }
    return [];
  }

  static bool doesColumnHasSpace(List<List<int>> values, int column){
    if (values[0][column] == 0){
      return true;
    }
    return false;
  }

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

  static bool checkDraw(List<List<int>> values){
    for (int i=0;i<values.length;i++) {
      for (int j = 0; j < values[0].length; j++) {
        if (values[i][j] == 0){
          return false;
        }
      }
    }
    return true;
  }

  static List<List<int>> checkNeighbours(List<List<int>> value, int row, int column){
    if (checkHorizontal(value, row, column)){
      return [[row, column], [row, column+1], [row, column+2], [row, column+3]];
    } else  if (checkVertical(value, row, column)){
      return [[row, column], [row+1, column], [row+2, column], [row+3, column]];
    } else  if (checkDiagonal(value, row, column, true)){
      return [[row, column], [row+1, column+1], [row+2, column+2], [row+3, column+3]];
    } else  if (checkDiagonal(value, row, column, false)){
      return [[row, column], [row-1, column-1], [row-2, column-2], [row-3, column-3]];
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
      if (row < 3 || column < 3) {
        return false;
      }
    }
    int i = 1;
    int value = values[row][column];
    while (i < 4){
      if (value == values[side ? row+i : row-i][side ? column+i : column-i]){
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