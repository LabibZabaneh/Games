import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function(bool) clickGameType;

  const Login({super.key, required this.clickGameType});

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
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30)
            ),
            child: const Text("Welcome!", style: TextStyle(fontSize: 20)),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              widget.clickGameType(true);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text("Single Player Mode"),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              widget.clickGameType(false);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Text(" Multi Player Mode "),
            ),
          ),
        )
      ],
    );
  }
}
