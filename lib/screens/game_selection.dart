import 'package:flutter/material.dart';

class GameSelectionPage extends StatefulWidget {
  final Function() clicked;

  const GameSelectionPage({super.key, required this.clicked});

  @override
  State<GameSelectionPage> createState() => _GameSelectionPageState();
}

class _GameSelectionPageState extends State<GameSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Text("Choose a Game", style: TextStyle(fontSize: 17),)
            )
        ),
        option("Tic Tac Toe"),
        option("Connect 4")
      ],
    );
  }

  Widget option(String text){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {},
        child: Container(
            width: 92,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Text(text)
        ),
      ),
    );
  }
}
