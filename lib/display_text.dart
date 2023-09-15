import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String text;
  final bool gameOver;
  final bool draw;

  const DisplayText({super.key, required this.text, required this.gameOver, required this.draw});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: gameOver ? (draw ? Colors.amber.shade300 : Colors.green.shade300) : Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(text),
        margin: EdgeInsets.symmetric(vertical: 30),
        padding: EdgeInsets.all(10)
    );
  }
}
