import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/suit.dart';
import 'package:flutter_blackjack/pages/number.dart';

// one of the function on mainPage
class QuickGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCard(
                    suit: diamond(),
                    color: Colors.red,
                    number: 20,
                    showBack: false,
                  ),
                  MyCard(
                    suit: club(),
                    color: Colors.red,
                    number: 20,
                    showBack: false,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Row(
                      children: [
                        MyCard(
                          suit: heart(),
                          color: Colors.red,
                          number: 20,
                          showBack: false,
                        ),
                        MyCard(
                          suit: heart(),
                          color: Colors.red,
                          number: 20,
                          showBack: false,
                        )
                      ],
                    ),
                  ),

                  // Deck for drawing card
                  CardBack(),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Row(
                      children: [
                        MyCard(
                          suit: heart(),
                          color: Colors.red,
                          number: 20,
                          showBack: false,
                        ),
                        MyCard(
                          suit: heart(),
                          color: Colors.red,
                          number: 20,
                          showBack: false,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyCard(
                    suit: heart(),
                    color: Colors.red,
                    number: 20,
                    showBack: false,
                  ),
                  MyCard(
                    suit: heart(),
                    color: Colors.red,
                    number: 20,
                    showBack: true,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
