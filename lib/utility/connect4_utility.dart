class Connect4Utility {

  static int evaluateMove(List<List<int>> gameValues, int column, int player){
    List<List<int>> values = copy(gameValues);
    if (!doesColumnHasSpace(values, column)){
      return -1; // move not possible
    }
    values = move(values, column, player);
    return countPossibleWins(values, player);
  }

  static int countPossibleWins(List<List<int>> values, int player){
    int count = 0;
    for (int row=0;row<values.length;row++){
      for (int col=0;col<values[0].length;col++){
        if (values[row][col] == player || values[row][col] == 0){
          evaluateVertical(values, row, col, player) ? count++ : null;
          evaluateHorizontal(values, row, col, player) ? count++ : null;
        }
      }
    }
    return count;
  }

  static bool evaluateHorizontal(List<List<int>> values, int row, int col, int player){
    if (col > values[0].length-4){
      return false;
    }
    return evaluateHelper(values, row, col, player, true);
  }

  static evaluateVertical(List<List<int>> values, int row, int col, int player){
    if (row > values.length-4){
      return false;
    }
    return evaluateHelper(values, row, col, player, false);
  }

  static bool evaluateHelper(List<List<int>> values, int row, int col, int player, bool direction){
    int i = 1;
    bool foundPlayer = false;
    while (i < 4){
      if (values[direction ? row : row+i][direction ? col+i : col] == player){
        foundPlayer = true;
      } else if (values[direction ? row : row+i][direction ? col+i : col] != 0){ // equals opposing player cell
        return false;
      }
      i++;
    }
    return foundPlayer;
  }

  static int checkPossibleHorizontal(List<List<int>> values, int row, int col, int player){
    int result = 0;
    if (col <= values[0].length-4){ // check right side
      if (checkSide(values, row, col, player, true)){
        result++;
      }
    }
    if (col > 2){
      if (checkSide(values, row, col, player, false)){
        result++;
      }
    }
    return result;
  }

  static bool checkSide(List<List<int>> values, int row, int col, int player, bool direction){
    for (int i=1;i<4;i++){
      print("Row: $row, Col: $col, I: $i");
      if (values[row][direction ? col+i : col-i] == 0 || values[row][direction ? col+i : col-i] == player){ // if player or empty
        if (i == 3){
          return true;
        }
      } else {
        return false;
      }
    }
    return false;
  }

  static bool doesNextMoveWin(List<List<int>> gameValues, int column, int value){ // does the next (not current) move wins
    List<List<int>> values = copy(gameValues);
    if (!doesColumnHasSpace(values, column)){
      return false;
    }
    values = move(values, column, value);
    for (int i=0;i<values[0].length;i++){
      if (doesMoveWin(values, i, value)){
        return true;
      }
    }
    return false;
  }

  static bool doesMoveWin(List<List<int>> gameValues, int column, int value){ // does the current move wins
    List<List<int>> values = copy(gameValues);
    if (!doesColumnHasSpace(values, column)){
      return false;
    }
    values = move(values, column, value);
    if (checkGameOver(values).isNotEmpty){
      return true;
    }
    return false;
  }

  static List<List<int>> copy(List<List<int>> list){
    return [for (var sublist in  list) [...sublist]]; // returns a deep copy
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
    } else if (checkDiagonal(value, row, column, true)){
      return [[row, column], [row+1, column+1], [row+2, column+2], [row+3, column+3]];
    } else if (checkDiagonal(value, row, column, false)){
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
      if (row > 1 || column < 3) {
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