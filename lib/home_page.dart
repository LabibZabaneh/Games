import 'package:flutter/material.dart';
import 'grid.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> values = [0,0,0,0,0,0,0,0,0];
  bool turn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red.shade400,
        appBar: Dashboard(),
        body: Grid(values: values, turn: turn)
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
              onPressed: () {}
          )
        ],
      ),
    );
  }
}
