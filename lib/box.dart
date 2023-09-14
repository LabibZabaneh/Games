import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  const Box({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child: null,
      ),
    );;
  }
}
