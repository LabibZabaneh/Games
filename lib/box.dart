import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final int boxId;
  final bool isEmpty;
  final bool value; // either X or O
  final Function(int) move;

  const Box({super.key, required this.boxId, required this.move, required this.value, required this.isEmpty});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        move(this.boxId);
      },
      child: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child: isEmpty ? null : (value ? Icon(Icons.clear, size: 50, color: Colors.blue) : Icon(Icons.circle_outlined, size: 50, color: Colors.amber)),
      ),
    );
  }
}
