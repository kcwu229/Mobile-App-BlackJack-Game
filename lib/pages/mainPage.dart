import 'package:flutter/material.dart';
import 'package:flutter_blackjack/main.dart';
import 'package:flutter_blackjack/model/mainPageUI.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/quickGamePage.dart';
import 'package:flutter_blackjack/pages/settingPage.dart';
import 'package:flutter_blackjack/pages/dressingPage.dart';

// shift to the main page
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mainPage/main_2.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                  ),
                  userIcon(100.0, 100.0),
                  userInfo(),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
                flex: 4,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 5, child: Container()),
                    Expanded(
                        flex: 3,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => QuickGamePage()));
                          },
                          child: Stack(children: [
                            Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/mainPage/quickGame.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            mainPagePanel(160.0, 13.0, 'Quick Game')
                          ]),
                        )),
                    Expanded(
                        flex: 2,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingPage()));
                                  },
                                  child: Stack(children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/img/mainPage/setting.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                    mainPagePanel(60.0, 13.0, 'Setting')
                                  ]),
                                )),
                            Expanded(
                                flex: 5,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SettingPage()));
                                  },
                                  child: Stack(children: [
                                    Container(
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/img/mainPage/change.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                    mainPagePanel(60.0, 13.0, 'Dressing')
                                  ]),
                                ))
                          ],
                        )),
                    Expanded(flex: 1, child: Container()),
                  ],
                )),
            Expanded(flex: 4, child: Container())
          ],
        ),
      ),
    );
  }
}
