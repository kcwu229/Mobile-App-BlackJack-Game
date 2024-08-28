import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/bettingPageUI.dart';
import 'package:flutter_blackjack/model/blackJackDesk.dart';

class QuickGamePage extends StatefulWidget {
  @override
  _QuickGamePageState createState() => _QuickGamePageState();
}

class _QuickGamePageState extends State<QuickGamePage> {
  late double height;
  late double width;
  @override
  void initState() {
    super.initState();
  }

  void _showBetDialogBox(height, width) {
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
                width: width,
                height: height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Text(
                          'Please select the chips amount for betting: ',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(width: width / 8, height: height / 8),
                      chipItem(width, height / 2.5),
                    ])),
            actions: [
              Container(
                alignment: Alignment.center,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/second-screen');
                  },
                  child: betButtonConfig(width, height / 2.5),
                ),
              )
            ],
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final height = mediaQuery.size.height;
    final width = mediaQuery.size.width;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showBetDialogBox(height / 2.5, width / 6);
    });

    return Scaffold(
        body: PopScope(
            canPop: false,
            child: Container(
              alignment: Alignment.center,
              width: width,
              height: height,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/pokerCard/table.jpg"),
                      fit: BoxFit.cover)),
              child: Center(
                child: SizedBox(
                  width: width,
                  child: Stack(children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Dealer's card in hand
                          chipsRemaining(500, height / 4, width / 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  //regionHomepage(),
                                  SizedBox(
                                    height: height / 2,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ])
                  ]),
                ),
              ),
            )));
  }
}
