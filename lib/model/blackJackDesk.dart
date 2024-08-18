import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/chip.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/statusIcon.dart';
import 'package:flutter_blackjack/model/userIcon.dart';

Widget label(width, height, text) {
  return Transform(
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
      ));
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
          Column(children: [
            displayIcon(player),
            displayWinIcon(player),
          ]),
          displayCard(player.inHand),
          //displayStatus(player)
        ]),
        Row(children: [
          chipArea(chips),
        ]),
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

Widget dealerArea(dealer) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Transform(transform: Matrix4.identity()..translate(50.0, 70.0, 0.0)),
    //child: displayStatus(checkStatus(dealer))),
    Transform(
        transform: Matrix4.identity()..translate(-80.0, 30.0, 0.0),
        child: displayWinIcon(dealer)),
    Column(children: [
      Transform(
          transform: Matrix4.identity()..translate(-75.0, 20.0, 0.0),
          child: Column(children: [
            displayCard(dealer.inHand),
          ])),
    ]),

    //showScore(dealer.score, dealer.showScore)
  ]);

  //showScore(dealer.score, dealer.showScore)
}

Widget dialogConfig(text, distanceConfig) {
  return Align(
    alignment: FractionalOffset(distanceConfig[0], distanceConfig[1]),
    child: Transform(
      transform: Matrix4.identity()..translate(50.0, 70.0, 0.0),
      child: Card(
        color: Color.fromRGBO(86, 164, 227, 0.721),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
        ),
      ),
    ),
  );
}

Widget playerActionButton(
    playerResponsed, player, waitForHitAction, waitForStandAction) {
  return IgnorePointer(
      ignoring: !((playerResponsed == false) &&
          (player.hasStand == false) &&
          (player.isBust == false) &&
          (player.gotNaturalBlackJack == false) &&
          (player.myTurn == true)),
      child: Opacity(
        opacity: ((playerResponsed == false) &&
                (player.hasStand == false) &&
                (player.isBust == false) &&
                (player.gotNaturalBlackJack == false) &&
                (player.myTurn == true))
            ? 1.0
            : 0.0,
        child: Row(
          children: [
            Container(
                transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: waitForHitAction,
                  child: actionButtonConfig('Hit'),
                )),
            Container(
                transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
                child: RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: waitForStandAction,
                  child: actionButtonConfig('Stand'),
                )),
          ],
          // RETURN BUTTON
        ),
      ));
}

Widget newGameButton(newGameAction) {
  return RawMaterialButton(
      shape: CircleBorder(),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/img/newGame.png'))),
      ),
      onPressed: newGameAction);
}

Widget playersArea(cpu1, player, cpu2, checkStatus) {
  return Stack(children: [
    playerRegion(
      cpu1,
      chips(cpu1.hasBet),
      -330.0,
      260.0,
      0.0,
      checkStatus(cpu1),
    ),
    //showScore(cpu1.score, cpu1.showScore),
    playerRegion(
      player,
      chips(player.hasBet),
      -100.0,
      260.0,
      0.0,
      checkStatus(player),
    ),
    //showScore(player.score, player.showScore),
    playerRegion(
      cpu2,
      chips(cpu2.hasBet),
      160.0,
      260.0,
      0.0,
      checkStatus(cpu2),
    ),
    //showScore(cpu2.score, cpu2.showScore)
  ]);
}
