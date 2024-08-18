import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  // create the instance

  @override
  void initState() {
    super.initState();
  }

  // add dialog
  void newGameAction() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuickGamePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // obtain the parameter for further action
    final winners = ModalRoute.of(context)?.settings.arguments as List<Player>;

    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        children: [
          // Fail, need to fix
          Row(
            children: [
              Container(
                color: Colors.white,
                height: 200,
                width: 80,
              )
            ],
          ),
          // newGameButton(gameOver, newGameAction)
        ],
      ),
    ));
  }
}
