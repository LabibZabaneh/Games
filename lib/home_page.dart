import 'package:flutter/material.dart';
import 'screens/game_selection.dart';
import 'screens/grid.dart';
import 'screens/game_mode_selection.dart';
import 'screens/difficulty.dart';

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
  bool gameType = false;
  bool gameSelectionPage = true;
  bool loginPage = false;
  bool difficultyPage = false;
  bool gamePage = false;
  int difficulty = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade400,
        appBar: Dashboard(),
        body: gameSelectionPage ? GameSelectionPage(clicked : clickGame) : (loginPage ? Login(clickGameType: clickGameType) : (difficultyPage ? Difficulty(clickDifficultyLevel: clickDifficultyLevel,) : (gamePage ? Grid(gameType: gameType,values: values, turn: turn, displayText: displayText, winValues: winValues,
            getPlayerScore: getPlayerScore, changeScoreTurn: changeScoreTurn, changeScore: changeScore, getScoreTurn: getScoreTurn, difficulty: difficulty,) : null)))
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
          Text('Games'),
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

  void clickGame(bool option){
    if (option){
      setState(() {
        gameSelectionPage = false;
        loginPage = true;
      });
    }
  }

  void changeScore(bool playerWon){
    if (scoreTurn) {
      playerWon ? player1Score++ : player2Score++;
    } else {
      playerWon ? player2Score++ : player1Score++;
    }
  }

  void clickDifficultyLevel(int i){
    setState(() {
      loginPage = false;
      difficultyPage = false;
      gamePage = true;
      difficulty = i;
    });
  }


  void clickGameType(bool gameType){
    setState(() {
      loginPage = false;
      if (gameType){
        difficultyPage = true;
      } else {
        gamePage = true;
      }
      gameType ? this.difficultyPage = true : this.difficultyPage = false;
      this.gameType = gameType;
    });
  }

  int getPlayerScore(bool player){
    return player ? player1Score : player2Score;
  }

  void changeScoreTurn(){
    scoreTurn = !scoreTurn; // Which player to be X
  }

  bool getScoreTurn(){
    return scoreTurn;
  }

  void clickMenu(){
    setState(() {
      gameSelectionPage = true;
      clear();
      player1Score = 0;
      player2Score = 0;
      scoreTurn = false;
    });
  }
}
