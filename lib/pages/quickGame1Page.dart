import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/suit.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class QuickGamePage extends StatelessWidget {
  // create the instance
  InitalGameState gs = InitalGameState();

  // stopped at here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(color: Colors.green),
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Dealer's card in hand
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var card in gs.getPlayer('dealer').inHand)
                    Container(
                      child: card,
                    )
                ],
              ),
              // Player's card in hand
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(children: [
                    for (var card in gs.getPlayer('cpu1').inHand)
                      Container(child: card)
                  ]),
                  Row(children: [
                    for (var card in gs.getPlayer('player').inHand)
                      Container(child: card)
                  ]),
                  Row(children: [
                    for (var card in gs.getPlayer('cpu2').inHand)
                      Container(child: card)
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
