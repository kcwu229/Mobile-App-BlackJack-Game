import 'package:flutter/material.dart';

Widget displayWinIcon(player) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Transform(
        transform: Matrix4.identity()..translate(0.0, 10.0, 0.0),
        child: Opacity(
          opacity: ((player.hasWon | player.gotNaturalBlackJack)) ? 1.0 : 0.0,
          child: ClipRRect(
              child: Container(
                  padding: const EdgeInsets.all(0),
                  height: 60,
                  width: 60,
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage('assets/img/playerIcon/winLogo.png'),
                      fit: BoxFit.cover,
                    )),
                  ))),
        ))
  ]);
}
