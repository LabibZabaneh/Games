import 'package:flutter/material.dart';
import 'package:games/widgets/display_text.dart';
import 'package:games/widgets/score_keeping.dart';

class Connect4Grid extends StatelessWidget {
  const Connect4Grid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DisplayScore(player: "Player 1", score: 0),
            const DisplayText(text: "Player 1 to play", gameOver: false, draw: false),
            DisplayScore(player: "Player 2", score: 0)
          ],
        ),
        rowOfBoxes(),
        rowOfBoxes(),
        rowOfBoxes(),
        rowOfBoxes(),
        rowOfBoxes(),
      ],
    );
  }

  Widget rowOfBoxes(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        box(), box(),box(),box(),box(),box()
      ],
    );
  }


  Widget box(){
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100)
      ),
      child: Text(' '),
    );
  }
}
