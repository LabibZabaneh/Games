class Computer {

  static bool doesMoveWin(List<int> values, int boxValue, int boxId){
    List<int> gameValues = List.from(values);
    gameValues[boxId] = boxValue;
    List<List<int>> game = convert2d(gameValues);

    int result = calculateGameResult(game);

    return (result > 0) ? true : false;
  }

  static int calculateGameResult(List<List<int>> game){
    for (int i=0;i<3;i++){
      bool col = check3(game[0][i], game[1][i], game[2][i]);
      bool row = check3(game[i][0], game[i][1], game[i][2]);
      if ((col || row) && game[i][i] != 0){
        return game[i][i]; // Game won
      }
    }
    bool diagonal1 = check3(game[0][0], game[1][1], game[2][2]);
    bool diagonal2 = check3(game[0][2], game[1][1], game[2][0]);
    if ((diagonal1 || diagonal2) && game[1][1] != 0){
      return game[1][1]; // Game won
    }
    if (isDraw(game)){
      return 0; // Draw
    }
    return -1; // Game not finished
  }

  static bool isDraw(List<List<int>> game){
    for (int i=0;i<3;i++){
      for (int j=0;j<3;j++){
        if (game[i][j] == 0){
          return false;
        }
      }
    }
    return true;
  }

  static bool check3(int a, int b, int c){
    if (a == b && b == c && a == c){
      return true;
    }
    return false;
  }

  static List<List<int>> convert2d(List<int> values){
    List<List<int>> game = [];
    for (int i=0;i<9;i+=3){
      List<int> temp = [values[i],values[i+1], values[i+2]];
      game.add(temp);
    }
    return game;
  }
}