import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/blackJackDesk.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/dialogConfig.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class SecondScreen extends StatefulWidget {
  // dialog location

  SecondScreen();

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
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

    // if not all players cannot take action, the game would go on until a winner is shown
    while (((gs.countBust(players) +
            gs.countStand(players) +
            gs.countWon(players)) <
        players.length)) {
      setState(() {
        playerResponsed = false;
      });
      for (var player in players) {
        if (player.hasWon) {
          setState(() {
            player.myTurn = false;
          });
        } else if (player.isBust == false &&
            player.hasWon == false &&
            player.hasStand == false) {
          player.myTurn = true;
        }
        await Future.delayed(Duration(seconds: 1));
        if ((player.hasStand == false) &
            (player.isBust == false) &
            (player.hasWon == false)) {
          setState(() {});

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
            if ((player.score <= 15) && (!player.hasWon)) {
              player.myTurn = true;
              gs.hit(player);
              saySomething(
                'Hit 🫳🏻',
                dialogLocation[player.name],
              );
              player.myTurn = false;

              setState(() {});
            } else if ((player.score > 15) && (player.hasWon == false)) {
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

    if (gameOver) {
      List<Player> winnerList = gs.winnerList;
      print('gameOver man');
      // push to another page and pass the parameter
      Navigator.of(context).pushNamed('/result-screen', arguments: winnerList);
    }
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
        return dialogConfig(text, distanceConfig);
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

  void hitActionCallback() {
    waitForHitAction();
  }

  void newGameAction() {
    print('can i run it ?');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuickGamePage()),
    );
  }

  void standActionCallback() {
    waitForStandAction();
  }

  Future<void> waitForHitAction() async {
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
  }

  Future<void> waitForStandAction() async {
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
    gs.stand(
      player,
    );
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
    return MaterialApp(
        home: Scaffold(
            body: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/pokerCard/table.jpg"),
              fit: BoxFit.cover)),
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              dealerArea(dealer),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: [
                    playersArea(cpu1, player, cpu2),
                    SizedBox(
                      height: 210,
                    ),
                    Row(children: [
                      // Hit & Stand button code location
                      playerActionButton(playerResponsed, player,
                          hitActionCallback, standActionCallback),

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
                            MaterialPageRoute(
                                builder: (context) => MainPageWidget()),
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
    )));
  }
}
