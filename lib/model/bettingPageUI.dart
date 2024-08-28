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

Widget chipsRemaining(playerChips, height, width) {
  return Container(
    alignment: Alignment.topRight,
    height: height,
    width: width,
    child: Text(
      'Chips: ${playerChips}',
      style: TextStyle(color: Colors.white),
    ),
  );
}

Widget chipItem(width, height) {
  return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 220, 48, 42),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 7)),
      child: Text(
        '50',
        style: TextStyle(fontSize: height / 4, color: Colors.white),
      ));
}

Widget betButtonConfig(width, height) {
  return Container(
      alignment: Alignment.center,
      width: width,
      height: height / 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 44, 121, 184),
          border: Border.all(color: Colors.black, width: 2)),
      child: Text(
        'Bet',
        style: TextStyle(fontSize: height / 5, color: Colors.white),
      ));
}
