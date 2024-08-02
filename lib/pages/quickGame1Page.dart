import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/suit.dart';
import 'package:flutter_blackjack/pages/number.dart';

// one of the function on mainPage
class QuickGamePage extends StatelessWidget {
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
                  MyCard(
                    suit: diamond(),
                    number: 20,
                    showBack: false,
                  ),
                  MyCard(
                    suit: club(),
                    number: 20,
                    showBack: false,
                  )
                ],
              ),
              // Player's card in hand
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(children: [
                    MyCard(
                      suit: heart(),
                      number: 20,
                      showBack: false,
                    ),
                    MyCard(
                      suit: heart(),
                      number: 20,
                      showBack: true,
                    ),
                  ]),
                  Row(children: [
                    MyCard(
                      suit: heart(),
                      number: 20,
                      showBack: true,
                    ),
                    MyCard(
                      suit: heart(),
                      number: 20,
                      showBack: true,
                    ),
                  ]),
                  Row(children: [
                    MyCard(
                      suit: heart(),
                      number: 20,
                      showBack: true,
                    ),
                    MyCard(
                      suit: heart(),
                      number: 20,
                      showBack: true,
                    )
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
