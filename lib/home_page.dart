import 'package:flutter/material.dart';
import 'package:games/screens/connect4/connect4Grid.dart';
import 'screens/game_selection.dart';
import 'screens/tictactoe/grid.dart';
import 'screens/tictactoe/game_mode_selection.dart';
import 'screens/tictactoe/difficulty.dart';

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
  Map<String, bool> pages = {"startPage" : true, "tictactoeModePage" : false, "tictactoeDifficultyPage" : false, "tictactoeGamePage" : false, "connect4GamePage" : false};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade400,
        appBar: Dashboard(),
        body: getCurrentPage()
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
            cursor: getCurrentPageName(pages) == "startPage" ? SystemMouseCursors.basic : SystemMouseCursors.click,
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
          const Text('Games'),
          MouseRegion(
            cursor: (getCurrentPageName(pages) == "tictactoeGamePage") || (getCurrentPageName(pages) == "connect4GamePage")  ? SystemMouseCursors.click : SystemMouseCursors.basic,
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

  Widget getCurrentPage() {
    String currentPage = getCurrentPageName(pages);
    if (currentPage != "error") {
      for (var entry in pages.entries) {
        if (entry.value) {
          return getWidgetByName(entry.key);
        }
      }
    }
    return Container();
  }

  Widget getWidgetByName(String name){
    if (name == "startPage"){
      return GameSelectionPage(changePage: changePage);
    } else if (name == "tictactoeModePage"){
      return Login(clickGameType: clickGameType, gameType: true);
    } else if (name == "connect4ModePage"){
      return Login(clickGameType: clickGameType, gameType: false,);
    } else if (name == "tictactoeDifficultyPage"){
      return Difficulty(clickDifficultyLevel: clickDifficultyLevel);
    } else if (name == "tictactoeGamePage"){
      return Grid(gameType: gameType,values: values, turn: turn, displayText: displayText, winValues: winValues,
          getPlayerScore: getPlayerScore, changeScoreTurn: changeScoreTurn, changeScore: changeScore, getScoreTurn: getScoreTurn, difficulty: difficulty);
    } else if (name == "connect4GamePage"){
      return Connect4Grid(getPlayerScore: getPlayerScore, changeScore: changeScore, changeScoreTurn: changeScoreTurn);
    } else{
      return Container();
    }
  }

  void changePage(String targetPageName){
    setState(() {
      String currentPage = getCurrentPageName(pages);
      if (currentPage != "error"){
        pages[currentPage] = false;
        pages[targetPageName] = true;
      }
    });
  }

  String getCurrentPageName(Map<String, bool> pages) {
    for (var page in pages.entries) {
      if (page.value) {
        return page.key;
      }
    }
    return 'error';
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
    difficulty = i;
    changePage("tictactoeGamePage");
  }


  void clickGameType(bool gameMode, bool gameType){
    this.gameType = gameMode;
    if (gameType){
      gameMode ? changePage("tictactoeDifficultyPage") : changePage("tictactoeGamePage");
    } else {
      gameMode ? changePage("connect4GamePage") : changePage("connect4GamePage");
    }
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
    changePage("startPage");
    scoreTurn = false;
    clear();

  }
}
