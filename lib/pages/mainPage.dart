import 'package:flutter/material.dart';
import 'package:flutter_blackjack/pages/quickGamePage.dart';
import 'package:flutter_blackjack/pages/settingPage.dart';
import 'package:flutter_blackjack/pages/dressingPage.dart';

// shift to the main page
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        //height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/img/mainPage/main_1.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
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
                            Positioned(
                                top: 15,
                                left: 13,
                                child: Text('快速遊戲',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 5,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(1.3, 1.3),
                                            blurRadius: 1.0,
                                            color: Colors.black,
                                          ),
                                        ])))
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
                                    Positioned(
                                        top: 15,
                                        left: 13,
                                        child: Text(
                                          '設定',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 5,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(1.3, 1.3),
                                                  blurRadius: 1.0,
                                                  color: Colors.black,
                                                ),
                                              ]),
                                        ))
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
                                    Positioned(
                                        top: 15,
                                        left: 13,
                                        child: Text(
                                          '換裝',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 5,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(1.3, 1.3),
                                                  blurRadius: 1.0,
                                                  color: Colors.black,
                                                ),
                                              ]),
                                        ))
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
