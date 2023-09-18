import 'package:flutter/material.dart';
import 'grid.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> values = [0,0,0,0,0,0,0,0,0];
  List<bool> winValues = [false,false,false,false,false,false,false,false,false];
  bool turn = true;
  String displayText = "X to play";
  int player1Score = 0;
  int player2Score = 0;
  bool scoreTurn = false;
  bool page = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade400,
        appBar: Dashboard(),
        body: page ? Login(clickMultiPlayer: clickMultiPlayer) : Grid(values: values, turn: turn, displayText: displayText, winValues: winValues,
          getPlayerScore: getPlayerScore, changeScoreTurn: changeScoreTurn, changeScore: changeScore)
    );
  }

  AppBar Dashboard() {
    return AppBar(
      backgroundColor: Colors.red.shade400,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MouseRegion(
            cursor: page ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                clickMenu();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Set the background color to transparent
                ),
                child: const Icon(Icons.menu),
              ),
            ),
          ),
          Text('Tic Tac Toe'),
          MouseRegion(
            cursor: page ? SystemMouseCursors.basic : SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                clear();
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.transparent, // Set the background color to transparent
                ),
                child: const Icon(Icons.refresh),
              ),
            ),
          )
        ],
      ),
    );
  }

  void clear(){
    setState(() {
      values = [0,0,0,0,0,0,0,0,0];
      turn = true;
      displayText = "X to play";
      winValues = [false,false,false,false,false,false,false,false,false];
    });
  }

  void changeScore(bool playerWon){
    if (scoreTurn) {
      playerWon ? player1Score++ : player2Score++;
    } else {
      playerWon ? player2Score++ : player1Score++;
    }
  }

  void clickMultiPlayer(){
    setState(() {
      page = false;
    });
  }

  int getPlayerScore(bool player){
    return player ? player1Score : player2Score;
  }

  void changeScoreTurn(){
    scoreTurn = !scoreTurn; // Which player to be X
  }

  void clickMenu(){
    setState(() {
      page = true;
    });
  }
}
