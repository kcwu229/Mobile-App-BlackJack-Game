import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/bettingPageUI.dart';
import 'package:flutter_blackjack/model/blackJackDesk.dart';

class QuickGamePage extends StatefulWidget {
  @override
  _QuickGamePageState createState() => _QuickGamePageState();
}

class _QuickGamePageState extends State<QuickGamePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _showBetDialogBox();
    });
  }

  void _showBetDialogBox() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: AlertDialog(
            backgroundColor: Color.fromARGB(255, 46, 47, 49),
            alignment: Alignment.center,
            title: Text(
              'Welcome',
              style: TextStyle(color: Colors.white),
            ),
            content: SizedBox(
                width: 600,
                height: 500,
                child: Container(
                  child: Text(
                    'Please select the chips amount for betting: ',
                    style: TextStyle(color: Colors.white),
                  ),
                )),
            actions: [
              RawMaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second-screen');
                  },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        chipItem(),
                        Container(
                          width: 200,
                          height: 200,
                        ),
                        betButtonConfig(),
                      ])),
            ],
          ));
        });
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
          child: Stack(children: [
            Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Dealer's card in hand
                  chipsRemaining(500),
                  Container(
                      alignment: Alignment.center,
                      height: 100,
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.center,
                          child: Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, 80.0, 0.0),
                              child:
                                  label(550.0, 80.0, 'Black Jack Pays 3 To 2')),
                        ),
                      ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          regionHomepage(),
                          SizedBox(
                            height: 200,
                          ),
                        ],
                      ),
                    ],
                  ),
                ])
          ]),
        ),
      ),
    ));
  }
}
