import 'package:flutter/material.dart';

class Connect4Circle extends StatelessWidget {
  final bool isEmpty;
  final bool value;
  final int column;
  final Function(int column) move;

  Connect4Circle({super.key, required this.column, required this.move,required this.isEmpty, required this.value});

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
            color: isEmpty ? Colors.white : (value ? Colors.blue : Colors.amber),
            borderRadius: BorderRadius.circular(100)
        ),
      ),
    );
  }
}
