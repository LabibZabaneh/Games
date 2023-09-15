import 'package:flutter/material.dart';
import 'grid.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade400,
        appBar: Dashboard(),
        body: Grid(values: values, turn: turn, displayText: displayText, winValues: winValues)
    );
  }

  AppBar Dashboard() {
    return AppBar(
      backgroundColor: Colors.red.shade400,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu),
          Text('Tic Tac Toe'),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                clear();
              }
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
}
