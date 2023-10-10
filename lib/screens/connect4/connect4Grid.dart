import 'dart:math';

import 'package:flutter/material.dart';
import 'package:games/widgets/display_text.dart';
import 'package:games/widgets/score_keeping.dart';
import 'package:games/widgets/connect4Circle.dart';
import 'package:games/widgets/display_text.dart';
import 'package:games/utility/connect4_utility.dart';

class Connect4Grid extends StatefulWidget {
  List<List<int>> values = [[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0],[0,0,0,0,0]];
  bool turn = true;
  bool draw = false;
  bool gameOver = false;
  String displayText = "Blue to play";
  int Function(bool) getPlayerScore;
  Function(bool) changeScore;
  Function changeScoreTurn;
  bool gameType;
  int difficulty;
  
  Connect4Grid({super.key, required this.getPlayerScore, required this.changeScore, required this.changeScoreTurn,
    required this.gameType, required this.difficulty});

  @override
  State<Connect4Grid> createState() => _Connect4GridState();
}

class _Connect4GridState extends State<Connect4Grid> {

  @override
  Widget build(BuildContext context) {
    makeComputerMove();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DisplayScore(player: "Player 1", score: widget.getPlayerScore(true)),
            DisplayText(text: widget.displayText, gameOver: widget.gameOver, draw: widget.draw),
            DisplayScore(player: "Player 2", score: widget.getPlayerScore(false))
          ],
        ),
        rowOfCircles(0),
        rowOfCircles(1),
        rowOfCircles(2),
        rowOfCircles(3),
        rowOfCircles(4)
      ],
    );
  }

  Widget rowOfCircles(int row){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        renderCircle(row, 0),
        renderCircle(row, 1),
        renderCircle(row, 2),
        renderCircle(row, 3),
        renderCircle(row, 4),
      ],
    );
  }

  Widget renderCircle(int row, int column){
    return Connect4Circle(column: column, move: move, value: getValue(row, column), gameOver: widget.gameOver);
  }

  void move(int column){
    setState(() {
      for (int i=4;i>=0;i--){ // choose the lowest available cell
        if (widget.values[i][column] == 0){
          widget.turn ? widget.values[i][column] = 1 : widget.values[i][column] = 2;
          break;
        }
      }
      List<List<int>> winValues = Connect4Utility.checkGameOver(widget.values);
      if (winValues.isNotEmpty){
        setWinValues(winValues);
        widget.gameOver = true;
        widget.changeScore(!widget.turn);
        widget.changeScoreTurn();
      }
      if (Connect4Utility.checkDraw(widget.values)){
        widget.draw = true;
        widget.gameOver = true;
      }
      changeTurn();
      changeDisplayText();
    });
  }

  Future<void> makeComputerMove() async {
    if (widget.gameType && !widget.gameOver){
      if (!widget.turn){
        await Future.delayed(const Duration(milliseconds: 300));
        if (widget.difficulty > 1){
          makeMediumMove();
        } else {
          makeEasyMove();
        }
      }
    }

  }

  void makeHardMove(){
    int bestMove = -1;
    int bestMoveScore = -1;
    for (int i=0;i<widget.values[0].length;i++){
      int currentMoveScore = Connect4Utility.evaluateMove(widget.values, i, widget.turn ? 1 : 2 ); // a heuristic to evaluate the game state
      if (currentMoveScore > bestMoveScore) {
        if (!Connect4Utility.doesNextMoveLose(widget.values, i, widget.turn ? 1 : 2 )){ // if i play this move, will i lose on the next move
          bestMove = i;
          bestMoveScore = currentMoveScore;
        }
      }
    }
    move(bestMove);
  }

  void makeMediumMove(){
    for (int i=0;i<widget.values[0].length;i++){
      if (Connect4Utility.doesMoveWin(widget.values, i, widget.turn ? 1 : 2)){ // check if computer can win
        move(i);
        return;
      }
    }
    for (int j=0;j<widget.values[0].length;j++){
      if (Connect4Utility.doesMoveWin(widget.values, j, widget.turn ? 2 : 1)){ // check if user can win (next move)
        move(j);
        return;
      }
    }
    for (int z=0;z<widget.values[0].length;z++){
      if (Connect4Utility.doesNextMoveWin(widget.values, z, widget.turn ? 1 : 2)){
        move(z);
        return;
      }
    }

    widget.difficulty > 2 ? makeHardMove() : makeEasyMove();
  }

  void makeEasyMove(){
    Random random = Random();
    bool available = false;
    while(!available){
      int col = random.nextInt(5);
      if (hasColumnSpace(col)){
        move(col);
        break;
      }
    }
  }

  void setWinValues(List<List<int>> winValues){
    for (int i=0;i<winValues.length;i++){
      int row = winValues[i][0];
      int column = winValues[i][1];
      widget.values[row][column] = 3;
    }
  }

  void changeTurn(){
    widget.turn = !widget.turn;
  }

  void changeDisplayText(){
    if (widget.gameOver) {
      if (widget.draw){
        widget.displayText = "Draw!";
      } else {
        widget.turn ? widget.displayText = "Yellow Wins!" : widget.displayText = "Blue Wins!";
      }
    } else {
      widget.turn ? widget.displayText = "Blue to Play" : widget.displayText = "Yellow to Play";
    }
  }

  int getValue(int row, int column){
    return widget.values[row][column];
  }

  bool hasColumnSpace(int col){
    return widget.values[0][col] == 0; // if first cell empty there is space
  }

}
