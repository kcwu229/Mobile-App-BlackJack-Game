import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/player.dart';

Widget showPlayerUI(winnerName) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              flex: 9,
              child: Transform.rotate(
                  angle: 5 * 3.14159 / 180,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/img/resultPage/${winnerName}Won.jpg"),
                          fit: BoxFit.cover,
                        )),
                    height: 70.0,
                    width: 170.0,
                  ))),
          Expanded(
            flex: 1,
            child: Transform.rotate(
                angle: -5 * 3.14159 / 180,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 30.0,
                  width: 170.0,
                  child: Text(
                    '${winnerName}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 32, 32, 32)),
                  ),
                )),
          )
        ],
      ));
}

Widget glowingEffect() {
  return AvatarGlow(
    glowShape: BoxShape.circle,
    repeat: true,
    curve: Curves.fastOutSlowIn,
    glowColor: Colors.orange,
    duration: Duration(seconds: 3),
    child: Image(
        image: AssetImage("assets/img/playerIcon/winLogo.png"),
        width: 80,
        height: 80),
  );
}
