import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/blackJackDesk.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/chip.dart';
import 'package:flutter_blackjack/model/userIcon.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/dialogConfig.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/score.dart';
import 'package:flutter_blackjack/model/suit.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class QuickGamePage extends StatefulWidget {
  // dialog location

  @override
  _QuickGamePageState createState() => _QuickGamePageState();
}

class _QuickGamePageState extends State<QuickGamePage> {
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

// looping the round;
  Future<void> loop() async {
    List<Player> players = gs.players;
    dialogLocation;

    // if not all the players are bust, the game would go on
    while ((gs.countBust(players) + gs.countStand(players)) < players.length) {
      setState(() {
        playerResponsed = false;
      });
      for (var player in players) {
        // if player not stand / bust, he/ she can take action
        print('Player busted: ${player.name}');
        print('Player stand: ${player.name}');
        player.myTurn = true;
        await Future.delayed(Duration(seconds: 3));
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
            if (player.score < 15) {
              player.myTurn = true;
              gs.hit(player);
              saySomething(
                'Hit',
                dialogLocation[player.name],
              );
              player.myTurn = false;

              setState(() {});
            } else {
              player.myTurn = true;
              gs.stand(player);
              saySomething(
                'Stand',
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
    saySomething('Hit', dialogLocation[player.name]);
    setState(() {
      playerTurn = false;
    });
    completer.complete();
  }

  void stand() {
    gs.stand(player);
    saySomething('Stand', dialogLocation[player.name]);
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Dealer's card in hand
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Column(children: [
                  Column(children: [
                    displayStatus(dealer.hasStand, 'Stand'),
                    displayCard(dealer.inHand),
                  ]),
                ])
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
                  Transform(
                      transform: Matrix4.identity()..translate(0.0, -35.0, 0.0),
                      child: Column(children: [
                        Row(children: [
                          cardArea(),
                          displayCard(cpu1.inHand),
                        ]),
                        Row(children: [
                          displayIcon(cpu1.name, cpu1.myTurn),
                          chipArea(chips()),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              displayBust(cpu1.isBust, 'Bust'),
                              displayStatus(cpu1.hasStand, 'Stand'),
                            ])
                      ])),
                  //showScore(cpu1.score, cpu1.showScore),
                  Transform(
                      transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
                      child: Column(children: [
                        Row(children: [
                          cardArea(),
                          displayCard(player.inHand),
                        ]),
                        Row(children: [
                          displayIcon(player.name, player.myTurn),
                          //  displayStatus(player.hasStand, 'Stand'),
                          chipArea(chips()),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              displayBust(player.isBust, 'Bust'),
                              displayStatus(player.hasStand, 'Stand'),
                            ])
                      ])),
                  //showScore(player.score, player.showScore),
                  Transform(
                      transform: Matrix4.identity()..translate(0.0, -35.0, 0.0),
                      child: Column(children: [
                        Row(children: [
                          cardArea(),
                          displayCard(cpu2.inHand),
                        ]),
                        Row(children: [
                          displayIcon(cpu2.name, cpu2.myTurn),
                          chipArea(chips()),
                        ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              displayBust(cpu2.isBust, 'Bust'),
                              displayStatus(cpu2.hasStand, 'Stand'),
                            ])
                      ])),
                  Stack(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                Align(
                                    alignment: FractionalOffset(0.1, 0.1),
                                    child: RawMaterialButton(
                                      shape: CircleBorder(),
                                      fillColor: const Color.fromARGB(
                                          242, 236, 144, 45),
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
                                                  color: Colors.black,
                                                  width: 2)),
                                          child: Text(
                                            'Hit',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    )),
                                Align(
                                    alignment: FractionalOffset(0.1, 0.5),
                                    child: RawMaterialButton(
                                      fillColor: const Color.fromARGB(
                                          234, 28, 71, 150),
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
                                                  color: Colors.black,
                                                  width: 2)),
                                          child: Text(
                                            'Stand',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
                  //showScore(cpu2.score, player.showScore),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
