import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/blackJackDesk.dart';
import 'package:flutter_blackjack/model/chip.dart';

Widget regionHomepage() {
  return Stack(
    alignment: Alignment.center,
    children: [
      Row(
        children: List.generate(6, (index) {
          if (index % 2 == 0) {
            return Transform(
              transform: Matrix4.identity()..translate(-30.0, 100.0, 0.0),
              child: cardRegion(),
            );
          } else {
            return Transform(
              transform: Matrix4.identity()..translate(-40.0, 190.0, 0.0),
              child: chipArea(chips(false)),
            );
          }
        }),
      )
    ],
  );
}

Widget chipsRemaining(playerChips) {
  return Container(
    alignment: Alignment.topRight,
    height: 80,
    width: 150,
    child: Text(
      'Chips: ${playerChips}',
      style: TextStyle(color: Colors.black),
    ),
  );
}

Widget chipItem() {
  return Container(
      alignment: Alignment.center,
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 48, 42),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 7)),
      child: Text(
        '50',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));
}

Widget betButtonConfig() {
  return Container(
      alignment: Alignment.center,
      width: 180,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 44, 121, 184),
          border: Border.all(color: Colors.black, width: 2)),
      child: Text(
        'Bet',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));
}
