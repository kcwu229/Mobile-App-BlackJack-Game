import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/score.dart';
import 'package:flutter_blackjack/model/suit.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class QuickGamePage extends StatefulWidget {
  @override
  _QuickGamePageState createState() => _QuickGamePageState();
}

class _QuickGamePageState extends State<QuickGamePage> {
  // create the instance
  InitalGameState gs = InitalGameState();
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

    // if not all the players are bust, the game would go on

    while ((gs.countBust(players) + gs.countStand(players)) < players.length) {
      setState(() {
        playerResponsed = false;
      });
      for (var player in players) {
        await Future.delayed(const Duration(seconds: 2));
        // if player not stand / bust, he/ she can take action
        if ((player.hasStand == false) & (player.isBust == false)) {
          player.actionEnded = false;

          if (player.isPlayer == true) {
            setState(() {
              playerTurn = true;
            });
            if ((player.actionEnded == false) &
                (player.hasStand == false) &
                (player.isBust == false) &
                (player.gotNaturalBlackJack == false)) {
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
              gs.hit(player);
              setState(() {});
            } else {
              gs.stand(player);
            }
          }
        }
      }
    }
  }

  late Player dealer = gs.getPlayer('dealer');
  late Player cpu1 = gs.getPlayer('cpu1');
  late Player cpu2 = gs.getPlayer('cpu2');
  late Player player = gs.getPlayer('player');

  // add String
  String _playerAction = 'waiting';

  void hit() {
    gs.hit(player);
    gs.playerEndTurn(player);
    setState(() {
      playerTurn = false;
    });
    completer.complete();
  }

  void stand() {
    gs.stand(player);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IgnorePointer(
                    ignoring: !((playerResponsed == false) &&
                        (player.hasStand == false) &&
                        (player.isBust == false) &&
                        (player.gotNaturalBlackJack == false) &&
                        (playerTurn == true)),
                    child: Opacity(
                      opacity: ((playerResponsed == false) &&
                              (player.hasStand == false) &&
                              (player.isBust == false) &&
                              (player.gotNaturalBlackJack == false) &&
                              (playerTurn == true))
                          ? 1.0
                          : 0.0,
                      child: Row(
                        children: [
                          Positioned(
                              left: 0,
                              child: ElevatedButton(
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
                                child: const Text('Hit'),
                              )),
                          Positioned(
                              left: 0,
                              child: ElevatedButton(
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
                                child: const Text('Stand'),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform(
                      transform: Matrix4.identity()..translate(0.0, -35.0, 0.0),
                      child: Column(children: [
                        Row(children: [
                          displayIcon(cpu1.name),
                          displayStatus(cpu1.hasStand, 'Stand'),
                        ]),
                        displayCard(cpu1.inHand),
                      ])),
                  showScore(cpu1.score, cpu1.showScore),
                  Transform(
                      transform: Matrix4.identity()..translate(0.0, 0.0, 0.0),
                      child: Column(children: [
                        Row(children: [
                          displayIcon(player.name),
                          displayStatus(player.hasStand, 'Stand'),
                        ]),
                        displayCard(player.inHand),
                      ])),
                  showScore(player.score, player.showScore),
                  Transform(
                      transform: Matrix4.identity()..translate(0.0, -35.0, 0.0),
                      child: Column(children: [
                        Row(children: [
                          displayIcon(cpu2.name),
                          displayStatus(cpu2.hasStand, 'Stand'),
                        ]),
                        displayCard(cpu2.inHand),
                      ])),
                  showScore(cpu2.score, player.showScore),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
