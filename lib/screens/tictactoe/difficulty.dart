import 'package:flutter/material.dart';

class Difficulty extends StatefulWidget {
  final Function(int, bool) clickDifficultyLevel;
  final bool gameType;

  const Difficulty({super.key, required this.clickDifficultyLevel, required this.gameType});

  @override
  State<Difficulty> createState() => _DifficultyState();
}

class _DifficultyState extends State<Difficulty> {
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
              child: const Text("Choose a difficulty", style: TextStyle(fontSize: 17),)
          ),
        ),
        option("Easy", 1),
        option("Medium", 2),
        option("Hard", 3),
      ],
    );
  }

  Widget option(String text, int difficulty){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.clickDifficultyLevel(difficulty, widget.gameType);
        },
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
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
