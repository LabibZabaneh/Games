import 'package:flutter/material.dart';
import 'package:games/widgets/display_text.dart';
import 'package:games/widgets/score_keeping.dart';
import 'package:games/widgets/connect4Circle.dart';
import 'package:games/widgets/display_text.dart';

class Connect4Grid extends StatefulWidget {
  List<List<int>> values = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]];
  bool turn = true;
  String displayText = "Player 1 to play";
  
  Connect4Grid({super.key});

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
            DisplayScore(player: "Player 1", score: 0),
            DisplayText(text: widget.displayText, gameOver: false, draw: false),
            DisplayScore(player: "Player 2", score: 0)
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
    return Connect4Circle(column: column, move: move,isEmpty: isEmpty(row, column), value: getValue(row, column));
  }

  void move(int column){
    setState(() {
      for (int i=4;i>=0;i--){
        if (widget.values[i][column] == 0){
          widget.turn ? widget.values[i][column] = 1 : widget.values[i][column] = 2;
          changeTurn();
          break;
        }
      }
    });
  }

  void changeTurn(){
    widget.turn = !widget.turn;
    changeDisplayText();
  }

  void changeDisplayText(){
    if (widget.turn){
      widget.displayText = "Player 1 to play";
    } else {
      widget.displayText = "PLayer 2 to play";
    }
  }

  bool isEmpty(int row, int column){
    return widget.values[row][column] == 0 ? true : false;
  }

  bool getValue(int row, int column){
    return widget.values[row][column] == 1 ? true : false;
  }
}
