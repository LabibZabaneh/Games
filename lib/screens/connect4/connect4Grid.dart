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
  
  Connect4Grid({super.key, required this.getPlayerScore, required this.changeScore, required this.changeScoreTurn, required this.gameType});

  @override
  State<Connect4Grid> createState() => _Connect4GridState();
}

class _Connect4GridState extends State<Connect4Grid> {

  @override
  Widget build(BuildContext context) {
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
