import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/resultPageUI.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> slideAnimation;
  late AnimationController animationController;
  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.2),
      end: Offset(0.0, 0.0),
    ).animate(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/playerIcon/winLogo.png"),
                            )),
                            height: 120.0,
                            width: 120.0,
                          )),
                      Expanded(
                          flex: 5,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (var winner in winners)
                                  SlideTransition(
                                      position: slideAnimation,
                                      child: showPlayerUI(winner.name)),
                              ])),
                      Expanded(
                        flex: 1,
                        child: Container(),
                      ),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                            onTap: () {
                              //
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MainPageWidget()));
                            },
                            child: Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width,
                                color: const Color.fromARGB(210, 247, 158, 24),
                                child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        FadeAnimatedText(
                                            'Tap here to HomePage     ')
                                      ],
                                      repeatForever: true,
                                    )))),
                      )
                    ],
                  ),
                ))));
  }
}
