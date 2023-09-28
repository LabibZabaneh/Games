import 'package:flutter/material.dart';
import 'package:games/widgets/display_text.dart';
import 'package:games/widgets/score_keeping.dart';
import 'package:games/widgets/connect4Circle.dart';

class Connect4Grid extends StatefulWidget {
  List<List<int>> values = [[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0],[0,0,0,0,0,0]];
  bool turn = true;
  
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
            const DisplayText(text: "Player 1 to play", gameOver: false, draw: false),
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
    return Connect4Circle(row: row, column: column, move: move,isEmpty: isEmpty(row, column), value: getValue(row, column));
  }

  void move(int row, int column){
    setState(() {
      widget.turn ? widget.values[row][column] = 1 : widget.values[row][column] = 2;
      widget.turn = ! widget.turn;
    });
  }

  bool isEmpty(int row, int column){
    return widget.values[row][column] == 0 ? true : false;
  }

  bool getValue(int row, int column){
    return widget.values[row][column] == 1 ? true : false;
  }
}
