import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/player.dart';

Widget showPlayerUI(winnerName) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              flex: 9,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image:
                      AssetImage("assets/img/resultPage/${winnerName}Won.jpg"),
                  fit: BoxFit.cover,
                )),
                height: 70.0,
                width: 170.0,
              )),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                color: const Color.fromARGB(202, 41, 41, 41),
                height: 30.0,
                width: 170.0,
                child: Text(
                  '${winnerName}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(234, 255, 255, 255)),
                ),
              )),
        ],
      ));
}
