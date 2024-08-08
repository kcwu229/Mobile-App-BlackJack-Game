import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/blackJackDesk.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/chip.dart';
import 'package:flutter_blackjack/model/myController.dart';
import 'package:flutter_blackjack/model/userIcon.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/dialogConfig.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/score.dart';
import 'package:flutter_blackjack/model/suit.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class SecondScreen extends StatefulWidget {
  // dialog location
  late final MyController controller;
  SecondScreen({required this.controller});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late final MyController controller;
  // create the instance
  InitalGameState gs = InitalGameState();
  bool gameOver = false;
  bool playerResponsed = false;
  Completer<void> completer = Completer<void>();
  bool playerTurn = false;
  String status = '';

  @override
  void initState() {
    super.initState();
    loop();
  }

// return Bust / Stand
  List checkStatus(Player player) {
    if (player.isBust) {
      setState(() {});
      return [
        player.isBust,
        'Bust',
      ];
    } else if (player.hasStand) {
      setState(() {});
      return [
        player.hasStand,
        'Stand',
      ];
    } else if (player.gotNaturalBlackJack) {
      setState(() {});
      return [
        true,
        'Won',
      ];
    }
    return [false, ''];
  }

// looping the round;
  Future<void> loop() async {
    List<Player> players = gs.players;
    dialogLocation;

    // if no winner, go round 2

    // if not all players cannot take action, the game would go on until a winner is shown
    while (((gs.countBust(players) +
                gs.countStand(players) +
                gs.countWon(players)) <
            players.length) ||
        gs.countWon(players) < 0) {
      setState(() {
        playerResponsed = false;
      });
      for (var player in players) {
        player.myTurn = true;
        await Future.delayed(Duration(seconds: 1));
        if ((player.hasStand == false) & (player.isBust == false)) {
          print('${player.name}  -- is his turn ?  ${player.myTurn}');
          setState(() {
            player.myTurn = true;
          });

          if (player.isPlayer == true) {
            setState(() {
              player.myTurn == true;
            });
            if ((player.myTurn == true) &
                (player.hasStand == false) &
                (player.isBust == false) &
                (player.gotNaturalBlackJack == false)) {
              setState(() {});
              if ((playerResponsed == false) && (player.isBust == false)) {
                //await waitForResponse;
                await Future.any([
                  Future.delayed(Duration(days: 365 * 10 ^ 10), () {
                    setState(() {
                      playerResponsed = true;
                      playerTurn = false;
                    });
                  }),
                  completer.future,
                ]);
              }
            }
          } else {
            if ((player.score < 15) && (!player.hasWon)) {
              player.myTurn = true;
              gs.hit(player);
              saySomething(
                'Hit 🫳🏻',
                dialogLocation[player.name],
              );
              player.myTurn = false;

              setState(() {});
            } else if ((player.score > 15) && (!player.hasWon)) {
              player.myTurn = true;
              gs.stand(player);
              saySomething(
                'Stand ✋🏻',
                dialogLocation[player.name],
              );
              player.myTurn = false;
            }
          }
        }
      }
    }
    gameOver = true;
  }

  late Player dealer = gs.getPlayer('dealer');
  late Player cpu1 = gs.getPlayer('cpu1');
  late Player cpu2 = gs.getPlayer('cpu2');
  late Player player = gs.getPlayer('player');

  // add dialog
  void saySomething(text, distanceConfig) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: FractionalOffset(distanceConfig[0], distanceConfig[1]),
          child: Positioned(
            width: 200,
            height: 50,
            left: 20.0,
            top: 20.0,
            child: Card(
              color: Color.fromRGBO(86, 164, 227, 0.721),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
          ),
        );
      },
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 500),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
    });
    gs.playerEndTurn(player);
  }

  void hit() {
    gs.hit(player);
    saySomething('Hit 🫳🏻', dialogLocation[player.name]);
    setState(() {
      playerTurn = false;
    });
    completer.complete();
  }

  void stand() {
    gs.stand(player);
    saySomething('Stand ✋🏻', dialogLocation[player.name]);
    gs.playerEndTurn(player);
    setState(() {
      playerTurn = false;
    });
    completer.complete();
  }

  List<Widget> dealerHandWidgets(Player player) {
    return player.inHand
        .map((card) => MyCard(suit: card.suit, rank: card.rank))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Color.fromARGB(255, 76, 135, 78)),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Dealer's card in hand

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                displayStatus(checkStatus(player)),
                Column(children: [
                  Column(children: [
                    displayCard(dealer.inHand),
                  ]),
                ]),

                //showScore(dealer.score, dealer.showScore)
              ]),

              Container(
                  alignment: Alignment.center,
                  height: 180,
                  child: Stack(children: [
                    Align(
                      alignment: Alignment.center,
                      child: label(550.0, 80.0, 'Black Jack Pays 3 To 2'),
                    ),
                  ])),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    Stack(children: [
                      playerRegion(
                          cpu1.inHand,
                          cpu1.name,
                          cpu1.myTurn,
                          chips(cpu1.hasBet),
                          cpu1.isBust,
                          cpu1.hasStand,
                          -200.0,
                          0.0,
                          0.0,
                          checkStatus(cpu1),
                          cpu1.hasWon,
                          cpu1.gotNaturalBlackJack),
                      //showScore(cpu1.score, cpu1.showScore),
                      playerRegion(
                          player.inHand,
                          player.name,
                          player.myTurn,
                          chips(player.hasBet),
                          player.isBust,
                          player.hasStand,
                          0.0,
                          0.0,
                          0.0,
                          checkStatus(player),
                          player.hasWon,
                          player.gotNaturalBlackJack),
                      //showScore(player.score, player.showScore),
                      playerRegion(
                          cpu2.inHand,
                          cpu2.name,
                          cpu2.myTurn,
                          chips(cpu2.hasBet),
                          cpu2.isBust,
                          cpu2.hasStand,
                          200.0,
                          0.0,
                          0.0,
                          checkStatus(cpu2),
                          cpu2.hasWon,
                          cpu2.gotNaturalBlackJack),
                      //showScore(cpu2.score, cpu2.showScore)
                    ]),
                    Row(children: [
                      IgnorePointer(
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
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0, 0.0),
                                    child: RawMaterialButton(
                                      shape: CircleBorder(),
                                      onPressed: () async {
                                        setState(() {
                                          playerResponsed = true;
                                          hit();
                                          completer.isCompleted;
                                        });
                                        await completer.future;
                                        setState(() {
                                          playerResponsed = false;
                                          completer = Completer<void>();
                                        });
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Text(
                                            'Hit',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    )),
                                Container(
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0, 0.0),
                                    child: RawMaterialButton(
                                      shape: CircleBorder(),
                                      onPressed: () async {
                                        setState(() {
                                          playerResponsed = true;
                                          stand();
                                          completer.isCompleted;
                                        });
                                        await completer.future;
                                        setState(() {
                                          playerResponsed = false;
                                          completer = Completer<void>();
                                        });
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3)),
                                          child: Text(
                                            'Stand',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    )),
                              ],
                              // RETURN BUTTON
                            ),
                          )),
                      Container(
                          child: RawMaterialButton(
                        shape: CircleBorder(),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/img/homePage.png'))),
                        ),
                        onPressed: () {
                          // Navigate to the new page
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                        },
                      )),
                    ]),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
