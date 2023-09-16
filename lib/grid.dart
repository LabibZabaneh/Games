import 'package:flutter/material.dart';
import 'box.dart';
import 'display_text.dart';

class Grid extends StatefulWidget {
  List<int> values;
  List<bool> winValues;
  bool turn;
  String displayText;
  bool gameOver = false;
  bool draw = false;

  Grid({super.key, required this.values, required this.turn, required this.displayText, required this.winValues});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DisplayText(text: widget.displayText, gameOver: isGameOver(), draw: widget.draw),
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
    checkGameOver();
    changeTurn();
  }

  void changeTurn(){
    setState(() {
      widget.turn = !widget.turn;
      changeDisplayText();
    });
  }

  bool isEmpty(int boxId){
    if (widget.values[boxId] == 0){
      return true;
    }
    return false;
  }

  bool getValue(int boxId){
    if (widget.values[boxId] == 1){
      return true;
    }
    return false;
  }

  Widget renderBox(int boxId){
    return Box(boxId: boxId, move: move, value: getValue(boxId),
      isEmpty: isEmpty(boxId), win: getWinValues(boxId), gameOver: isGameOver(),);
  }

  void changeDisplayText(){
    if (isGameOver()){
      widget.displayText = widget.draw ? "Draw!" :(widget.turn ? "O wins!" : "X wins!");
    } else {
      widget.displayText = widget.turn ? "X to play" : "O to play";
    }
  }

  void checkGameOver(){
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
    } else if (checkDraw()){
      widget.gameOver = true;
      widget.draw = true;
    }
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

  bool checkDraw(){
    for (int i=0;i<9;i++){
      if (widget.values[i] == 0){
        return false;
      }
    }
    return true;
  }

  void setWinValues(int i, int j, int z){
    widget.winValues[i] = true;
    widget.winValues[j] = true;
    widget.winValues[z] = true;
  }

  bool getWinValues(int i){
    return widget.winValues[i];
  }
}
