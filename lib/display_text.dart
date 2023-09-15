import 'package:flutter/material.dart';

class DisplayText extends StatelessWidget {
  final String text;

  const DisplayText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Text(text),
        margin: EdgeInsets.symmetric(vertical: 30),
        padding: EdgeInsets.all(10)
    );
  }
}
