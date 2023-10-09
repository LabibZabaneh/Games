import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function(bool, bool) clickGameType;
  final bool gameType;

  const Login({super.key, required this.clickGameType, required this.gameType});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
            child: const Text("Welcome!", style: TextStyle(fontSize: 17)),
          ),
        ),
        option("Single Player Mode", true),
        option("Multi Player Mode", false)
      ],
    );
  }

  Widget option(String text, bool option){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          widget.clickGameType(option, widget.gameType);
        },
        child: Container(
          width: 140,
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
