import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';

import '../model/blackJackDesk.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
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

    return MaterialApp(
        home: Scaffold(
            body: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 40,
            color: const Color.fromARGB(255, 247, 131, 7),
            child: Text(
              'Winner(s) is / are',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 50,
            width: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Fail, need to fix
              for (var item in winners)
                Column(children: [
                  Expanded(
                      flex: 7,
                      child: Container(
                          height: 150,
                          width: 130,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/img/playerIcon/cpu1.jpg"),
                            fit: BoxFit.cover,
                          )))),
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.grey,
                        height: 50,
                        width: 130,
                      )),
                ])
            ],
          ),
          newGameButton(newGameAction),
        ],
      ),
    )));
  }
}
