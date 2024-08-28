import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/player.dart';
import 'package:flutter_blackjack/model/resultPageUI.dart';
import 'package:flutter_blackjack/model/userData.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// one of the function on mainPage
// ignore: must_be_immutable
class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  bool slideOne = true;
  late Animation<Offset> slideAnimation;
  late AnimationController animationController;
  final int level = 0;
  final int exp = 0;
  int expAward = 50;
  UserExp userExp = new UserExp();

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    slideAnimation = Tween<Offset>(
      begin: Offset(0.0, -0.45),
      end: Offset(0.0, 0.0),
    ).animate(animationController);

    animationController.forward();
    addUserExp();
  }

  void addUserExp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  void goMainPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPageWidget()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // obtain the parameter for further action
    final winners = ModalRoute.of(context)?.settings.arguments as List<Player>;
    int totalExp = userExp.getExp(level);
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    return MaterialApp(
        home: Scaffold(
            body: PopScope(
                canPop: false,
                child: Container(
                    alignment: Alignment.center,
                    width: width,
                    color: Colors.black,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: slideOne
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Expanded(flex: 1, child: Container()),
                                Expanded(
                                    flex: 2,
                                    child: glowingEffect(width, height)),
                                Expanded(
                                    flex: 5,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          for (var winner in winners)
                                            SlideTransition(
                                                position: slideAnimation,
                                                child: showPlayerUI(winner.name,
                                                    width, height)),
                                        ])),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: InkWell(
                                      onTap: slideOne
                                          ? () {
                                              setState(() {
                                                slideOne = false;
                                              });
                                            }
                                          : () {
                                              //
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MainPageWidget()));
                                            },
                                      child: Container(
                                          alignment: Alignment.centerRight,
                                          width: width,
                                          color: const Color.fromARGB(
                                              231, 238, 146, 8),
                                          child: DefaultTextStyle(
                                              style: TextStyle(
                                                fontSize: height / 20,
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
                            )
                          : showUserExp(level, exp, slideOne, goMainPage,
                              totalExp, expAward, width, height),
                    )))));
  }
}
