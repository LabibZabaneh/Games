import 'package:flutter/material.dart';

class TicTacToeBox extends StatelessWidget {
  final int boxId;
  final bool isEmpty;
  final bool value; // either X or O
  final bool gameOver;
  final bool win;
  final Function(int) move;


  const TicTacToeBox({super.key, required this.boxId, required this.move, required this.value,
    required this.isEmpty, required this.gameOver, required this.win});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!gameOver && isEmpty){
          move(boxId);
        }
      },
      child: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: win ? Colors.green.shade300 : Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child: isEmpty ? null : (value ? Icon(Icons.clear, size: 50, color: Colors.blue) : Icon(Icons.circle_outlined, size: 50, color: Colors.amber)),
      ),
    );
  }
}
