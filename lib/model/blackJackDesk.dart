import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/statusIcon.dart';
import 'package:flutter_blackjack/model/userIcon.dart';

Widget label(width, height, text) {
  return Positioned(
      child: Transform(
          transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
          child: Container(
            alignment: Alignment.center,
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 5),
            ),
            child: Text(text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          )));
}

Widget chipArea(chip) {
  return Stack(children: [
    Transform(
      transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3),
        ),
        child: Text(
          'Bet here',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
    chip,
  ]);
}

Widget cardRegion() {
  return Stack(children: [
    Transform(
      transform: Matrix4.identity()..translate(60.0, -3.0, 0.0),
      child: Container(
        alignment: Alignment.center,
        width: 70,
        height: 90,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3),
        ),
      ),
    ),
  ]);
}

Widget playerRegion(
  player,
  chips,
  x,
  y,
  z,
  statusList,
) {
  List status = statusList;
  return Transform(
      transform: Matrix4.identity()..translate(x, y, z),
      alignment: Alignment.centerLeft,
      child: Column(children: [
        Row(children: [
          cardRegion(),
          displayCard(player.inHand),
        ]),
        Row(children: [
          displayIcon(player),
          chipArea(chips),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          displayStatus(status),
          displayWinIcon(player),
        ])
      ]));
}

Widget actionButtonConfig(text) {
  return Container(
      alignment: Alignment.center,
      width: 80,
      height: 80,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 3)),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));
}
