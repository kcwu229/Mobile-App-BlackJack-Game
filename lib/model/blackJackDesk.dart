import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/chip.dart';
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

Widget chipArea(chip, width, height) {
  return Stack(children: [
    Transform(
      transform: Matrix4.identity()..translate(width / 3, height / -0.71, 0.0),
      child: Container(
        alignment: Alignment.center,
        width: width / 5,
        height: height / 2,
        decoration: BoxDecoration(
            shape: BoxShape.circle, border: Border.all(color: Colors.black)),
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

Widget playerRegion(player, chips, x, y, z, width, height
    //statusList,
    ) {
  //List status = statusList;
  return Transform(
      transform: Matrix4.identity()..translate(x, y, z),
      alignment: Alignment.centerLeft,
      child: Column(children: [
        Row(children: [
          Column(children: [
            displayIcon(player, width, height),
            displayWinIcon(player),
          ]),
          displayCard(player.inHand),
        ]),
        Row(children: [
          chipArea(chips, width, height),
          statusArea(player, width / 3, height / 2.2)
        ]),
      ]));
}

Widget actionButtonConfig(text, width, height) {
  return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.white, width: 3)),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));
}

Widget dealerArea(dealer, width, height) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Transform(
      transform: Matrix4.identity()..translate(width / 2, height / 2, 0.0),
      //child: displayStatus(checkStatus(dealer))
    ),
    Transform(
        transform: Matrix4.identity()..translate(width / 10, height / 5, 0.0),
        child: displayWinIcon(dealer)),
    Column(children: [
      Transform(
          transform: Matrix4.identity()
            ..translate(width / -10, height * 0.04, 0.0),
          child: Row(children: [
            displayCard(dealer.inHand),
            statusAreaDealer(dealer),
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

Widget playerActionButton(playerResponsed, player, waitForHitAction,
    waitForStandAction, width, height) {
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
                child: RawMaterialButton(
              onPressed: waitForHitAction,
              child: actionButtonConfig('Hit', width / 3, height / 3),
            )),
            SizedBox(
              width: 10,
            ),
            Container(
                child: RawMaterialButton(
              onPressed: waitForStandAction,
              child: actionButtonConfig('Stand', width / 3, height / 3),
            )),
          ],
          // RETURN BUTTON
        ),
      ));
}

Widget newGameButton(newGameAction, width, height) {
  return RawMaterialButton(
      shape: CircleBorder(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            image:
                DecorationImage(image: AssetImage('assets/img/newGame.png'))),
      ),
      onPressed: newGameAction);
}

Widget playersArea(cpu1, player, cpu2, height, width, widthChip, heightChip) {
  return Row(children: [
    playerRegion(cpu1, chips(cpu1.hasBet), width / -5, height / 8, 0.0,
        widthChip, heightChip),
    //showScore(cpu1.score, cpu1.showScore),
    playerRegion(player, chips(player.hasBet), 0.0, height / 8, 0.0, widthChip,
        heightChip),
    //showScore(player.score, player.showScore),
    playerRegion(cpu2, chips(cpu2.hasBet), width / 8, height / 8, 0.0,
        widthChip, heightChip),
    //showScore(cpu2.score, cpu2.showScore)
  ]);
}

Widget statusArea(
  player,
  width,
  height,
) {
  return Transform(
      transform: Matrix4.identity()..translate(0.0, height / -1.98, 0.0),
      child: Container(
          width: width,
          height: height,
          child: Text(
            player.isBust
                ? 'Bust'
                : player.hasStand
                    ? 'Stand'
                    : '',
            style: TextStyle(
              color: Colors.red,
              fontSize: height / 2,
              fontWeight: FontWeight.bold,
            ),
          )));
}

Widget statusAreaDealer(player) {
  return Transform(
      transform: Matrix4.identity()..translate(-30.0, 65.0, 0.0),
      child: Container(
          width: 80,
          height: 30,
          child: Text(
            player.isBust
                ? 'Bust'
                : player.hasStand
                    ? 'Stand'
                    : '',
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          )));
}
