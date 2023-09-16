import 'package:flutter/material.dart';

class DisplayScore extends StatelessWidget {
  final String player;
  final int score;

  const DisplayScore({super.key, required this.player, required this.score});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          Text(player, style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 7),
          Text("$score", style: const TextStyle(fontSize: 13))
        ],
      ),
    );
  }
}
