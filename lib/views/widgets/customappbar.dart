import 'package:flutter/material.dart';

class customappbar extends StatelessWidget {
  const customappbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
                text: "Wall",
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.w600)),
            TextSpan(
                text: "zz",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontWeight: FontWeight.w600)),
          ])),
    );
  }
}
