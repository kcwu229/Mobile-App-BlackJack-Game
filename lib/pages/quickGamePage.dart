import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/card.dart';
import 'package:flutter_blackjack/model/cardBack.dart';
import 'package:flutter_blackjack/model/deck.dart';
import 'package:flutter_blackjack/model/gameLogic.dart';
import 'package:flutter_blackjack/model/player.dart';
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
  late Player dealer = gs.getPlayer('dealer');
  late Player cpu1 = gs.getPlayer('cpu1');
  late Player cpu2 = gs.getPlayer('cpu2');
  late Player player = gs.getPlayer('player');

  void _drawCardFromDeck() {
    print('button pressed');
    gs.drawCard(player.inHand, gs.deck);
    print(player.inHand.length);
    setState(() {
      // Update the UI to reflect the new card in the player's hand
    });
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
                  for (var card in dealer.inHand)
                    Container(
                      child: card,
                    ),
                  Offstage(
                    child: Container(
                      child: Text('${dealer.score}'),
                    ),
                    offstage: !dealer.showScore,
                  )
                ],
              ),
              Visibility(
                  visible: !player.actionEnded,
                  child: ElevatedButton(
                      onPressed: _drawCardFromDeck, child: Text('Hit'))),
              // Player's card in hand
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(children: [
                    for (var card in gs.getPlayer('cpu1').inHand)
                      Container(child: card)
                  ]),
                  Offstage(
                    child: Container(
                      child: Text('${cpu1.score}'),
                    ),
                    offstage: !cpu1.showScore,
                  ),
                  Row(children: [
                    for (var card in gs.getPlayer('player').inHand)
                      Container(child: card)
                  ]),
                  Offstage(
                    child: Container(
                      child: Text('${player.score}'),
                    ),
                    offstage: !player.showScore,
                  ),
                  Row(children: [
                    for (var card in gs.getPlayer('cpu2').inHand)
                      Container(child: card)
                  ]),
                  Offstage(
                    child: Container(
                      child: Text('${cpu2.score}'),
                    ),
                    offstage: !cpu2.showScore,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
