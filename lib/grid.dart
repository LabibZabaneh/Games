import 'package:flutter/material.dart';
import 'box.dart';
import 'display_text.dart';

class Grid extends StatefulWidget {
  const Grid({super.key});

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
          DisplayText(),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Box(), Box(), Box()]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Box(), Box(), Box()]),
          Row(mainAxisAlignment: MainAxisAlignment.center,children: [Box(), Box(), Box()])
          ],
      ),
    );
  }
}
