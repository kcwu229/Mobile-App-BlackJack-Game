import 'package:flutter/material.dart';

Widget displayWinIcon(playerWon, playerNatureBJ) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Transform(
        transform: Matrix4.identity()..translate(-70.0, -100.0, 0.0),
        child: Opacity(
          opacity: (playerWon | playerNatureBJ) ? 1.0 : 0.0,
          child: ClipRRect(
              child: Container(
                  padding: const EdgeInsets.all(0),
                  height: 60,
                  width: 100,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/img/playerIcon/win.png'),
                      fit: BoxFit.cover,
                    )),
                  ))),
        ))
  ]);
}
