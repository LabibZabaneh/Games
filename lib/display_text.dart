import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  const DisplayText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text("X to play"),
        margin: EdgeInsets.symmetric(vertical: 30),
        padding: EdgeInsets.all(10)
    );
  }
}
