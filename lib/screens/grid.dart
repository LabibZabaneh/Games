import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';
import '../widgets/box.dart';
import '../widgets/display_text.dart';
import '../widgets/score_keeping.dart';
import '../utility/computer.dart';

class Grid extends StatefulWidget {
  bool gameType;
  List<int> values;
  List<bool> winValues;
  bool turn;
  String displayText;
  Function(bool) changeScore;
  int Function(bool) getPlayerScore;
  bool Function() getScoreTurn;
  Function changeScoreTurn;
  int difficulty;
  bool gameOver = false;
  bool draw = false;

  Grid({super.key, required this.gameType, required this.values, required this.turn, required this.displayText, required this.winValues,
    required this.changeScore, required this.changeScoreTurn, required this.getPlayerScore, required this.getScoreTurn, required this.difficulty});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {

  @override
  Widget build(BuildContext context) {
    computerToPlay();
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DisplayScore(player: "Player 1", score: widget.getPlayerScore(true)),
              DisplayText(text: widget.displayText, gameOver: isGameOver(), draw: widget.draw),
              DisplayScore(player: widget.gameType ? "Computer" : "Player 2", score: widget.getPlayerScore(false))
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [renderBox(0), renderBox(1), renderBox(2)]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [renderBox(3), renderBox(4), renderBox(5)]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [renderBox(6), renderBox(7), renderBox(8)])
          ],
      ),
    );
  }

  void move(int boxId){
    if (widget.values[boxId] == 0){ // if the box is empty
      widget.values[boxId] = widget.turn ? 1 : 2;
    }
    checkGameOver(widget.values);
    if (widget.gameOver){
      widget.changeScoreTurn();
    }
    changeTurn();
  }

  void computerToPlay(){
    if (widget.gameType && !isGameOver()){
      if (widget.getScoreTurn()){
        if (widget.turn){
          moveComputer();
        }
      } else {
        if (!widget.turn){
          moveComputer();
        }
      }
    }
  }

  Future<void> moveComputer() async {
    await Future.delayed(const Duration(milliseconds: 300));
    // check if computer can win, then if opponent can win, then if center empty, then if side empty then random
    makeComputerMove(widget.turn) ? null : (makeComputerMove(!widget.turn) ? null : (centerMove(widget.values, widget.turn ? 1 : 2) ? null : (sideMove(widget.values, widget.turn ? 1 : 2) ? null : makeRandomComputerMove())));
  }

  bool makeComputerMove(bool turn){
    if (widget.difficulty > 1){
      for (int i=0;i<9;i++){
        if (Computer.doesMoveWin(widget.values, turn ? 1 : 2, i) && isEmpty(widget.values, i)){
          move(i);
          return true;
        }
      }
    }
    return false;
  }

  bool centerMove(List<int> values, int boxValue){
    if (widget.difficulty == 3){
      if (boxValue == 2){
        if (values[4] == 0){
          move(4);
          return true;
        }
      }
    }
    return false;
  }

  bool sideMove(List<int> values, int boxValue){
    if (widget.difficulty == 3){
      bool found = false;
      if (boxValue == 2){
        while (!found){
          List<int> options = [1, 3, 5, 7];
          Random random = Random();
          int result = options[random.nextInt(options.length)];
          if (values[result] == 0){
            move(result);
            return true;
          }
        }
      }
    }
    return false;
  }

  void makeRandomComputerMove(){
    Random random = Random();
    bool available = false;
    while (!available){
      int randomNumber = random.nextInt(9);
      if (isEmpty( widget.values, randomNumber)){
        setState(() {
          move(randomNumber);
          available = true;
        });
      }
    }
  }

  void changeTurn(){
    setState(() {
      widget.turn = !widget.turn;
      changeDisplayText();
    });
  }

  bool getValue(int boxId){
    if (widget.values[boxId] == 1){
      return true;
    }
    return false;
  }

  Widget renderBox(int boxId){
    return Box(boxId: boxId, move: move, value: getValue(boxId),
      isEmpty: isEmpty(widget.values, boxId), win: getWinValues(boxId), gameOver: isGameOver());
  }

  void changeDisplayText(){
    if (widget.gameOver){
      if (widget.draw){
        widget.displayText = "  Draw!  ";
      } else if (widget.turn){
        widget.displayText = " O Wins! ";
        widget.changeScore(false);
      } else {
        widget.displayText = " X Wins! ";
        widget.changeScore(true);
      }
    } else if (widget.turn){
      widget.displayText = "X to play";
    } else {
      widget.displayText = "O to play";
    }
  }

  bool checkGameOver(List<int> values){
    if (checkRow(0)){
      setWinValues(0, 1, 2);
      widget.gameOver = true;
    } else if (checkRow(3)){
      widget.gameOver = true;
      setWinValues(3, 4, 5);
    } else if (checkRow(6)){
      widget.gameOver = true;
      setWinValues(6, 7, 8);
    } else if (checkColumn(0)){
      widget.gameOver = true;
      setWinValues(0, 3, 6);
    } else if (checkColumn(1)){
      widget.gameOver = true;
      setWinValues(1, 4, 7);
    } else if (checkColumn(2)){
      widget.gameOver = true;
      setWinValues(2, 5, 8);
    } else if (checkDiagonal(0)){
      widget.gameOver = true;
      setWinValues(0, 4, 8);
    } else if (checkDiagonal(2)){
      widget.gameOver = true;
      setWinValues(2, 4, 6);
    } else if (checkDraw(widget.values)){
      widget.gameOver = true;
      widget.draw = true;
    } else {
      return false;
    }
    return true;
  }

  bool isGameOver(){
    return widget.gameOver;
  }

  bool checkRow(int i){
    if ((widget.values[i] != 0) && (widget.values[i+1] != 0) && ((widget.values[i+2] != 0))){
      if ((widget.values[i] == widget.values[i+1]) && (widget.values[i] == widget.values[i+2])){
        return true;
      }
    }
    return false;
  }

  bool checkColumn(int i){
    if ((widget.values[i] != 0) && (widget.values[i+3] != 0) && ((widget.values[i+6] != 0))){
      if ((widget.values[i] == widget.values[i+3]) && (widget.values[i] == widget.values[i+6])){
        return true;
      }
    }
    return false;
  }

  bool checkDiagonal(int i){
    if (i == 0){
      if ((widget.values[0] != 0) && (widget.values[4] != 0) && ((widget.values[8] != 0))){
        if ((widget.values[0] == widget.values[4]) && (widget.values[0] == widget.values[8])){
          return true;
        }
      }
    }
    if (i == 2){
      if ((widget.values[2] != 0) && (widget.values[4] != 0) && ((widget.values[6] != 0))){
        if ((widget.values[2] == widget.values[4]) && (widget.values[2] == widget.values[6])){
          return true;
        }
      }
    }
    return false;
  }

  void setWinValues(int i, int j, int z){
    widget.winValues[i] = true;
    widget.winValues[j] = true;
    widget.winValues[z] = true;
  }

  bool getWinValues(int i){
    return widget.winValues[i];
  }

  bool isEmpty(List<int> values, int boxId){
    if (widget.values[boxId] == 0){
      return true;
    }
    return false;
  }

  bool checkDraw(List<int> values){
    for (int i=0;i<9;i++){
      if (values[i] == 0){
        return false;
      }
    }
    return true;
  }

  Future<void> moveComputer2() async {
    await Future.delayed(const Duration(milliseconds: 300));
    for (int i=0;i<9;i++){
      if (isEmpty(widget.values, i)){

      }
    }
  }
}
