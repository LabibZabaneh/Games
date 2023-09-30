import 'package:flutter/material.dart';

class Connect4Circle extends StatelessWidget {
  final int value;
  final int column;
  final Function(int column) move;

  Connect4Circle({super.key, required this.column, required this.move, required this.value});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        move(column);
      },
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            color: value == 0 ? Colors.white : (value == 1 ? Colors.blue : (value == 2 ? Colors.amber : Colors.green)),
            borderRadius: BorderRadius.circular(100)
        ),
      ),
    );
  }
}
