import 'package:flutter/material.dart';

class GameSelectionPage extends StatefulWidget {
  final Function(String) changePage;

  const GameSelectionPage({super.key, required this.changePage});

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
                margin: const EdgeInsets.symmetric(vertical: 40),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Text("Choose a Game", style: TextStyle(fontSize: 17),)
            )
        ),
        option("Tic Tac Toe", "tictactoeModePage"),
        option("Connect 4", "connect4GamePage")
      ],
    );
  }

  Widget option(String text, String option){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.changePage(option);
        },
        child: Container(
            width: 92,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
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
