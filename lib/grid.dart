import 'package:flutter/material.dart';
import 'box.dart';
import 'display_text.dart';

class Grid extends StatefulWidget {
  List<int> values;
  bool turn;

  Grid({super.key, required this.values, required this.turn});

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {

  void move(int boxId){
    if (widget.values[boxId] == 0){ // if the box is empty
      widget.values[boxId] = widget.turn ? 1 : 2;
    }
    changeTurn();
  }

  void changeTurn(){
    setState(() {
      widget.turn = !widget.turn;
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
    return Box(boxId: boxId, move: move, value: getValue(boxId), isEmpty: isEmpty(boxId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DisplayText(),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [renderBox(0), renderBox(1), renderBox(2)]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [renderBox(3), renderBox(4), renderBox(5)]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [renderBox(6), renderBox(7), renderBox(8)])
          ],
      ),
    );
  }
}
