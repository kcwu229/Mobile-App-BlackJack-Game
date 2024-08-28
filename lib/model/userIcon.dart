import 'package:flutter/material.dart';

Widget displayIcon(player, width, height) {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    Padding(
      padding: const EdgeInsets.all(3),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
              padding: const EdgeInsets.all(0),
              height: height / 2,
              width: width / 5,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: player.myTurn
                            ? const Color.fromARGB(214, 250, 201, 26)
                            : const Color.fromARGB(238, 54, 62, 71),
                        width: 5),
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/img/playerIcon/${player.name}.jpg'),
                      fit: BoxFit.cover,
                    )),
              ))),
    )
  ]);
}
