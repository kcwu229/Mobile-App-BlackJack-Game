import 'package:flutter/material.dart';
import 'package:flutter_blackjack/pages/quickPage.dart';
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
                        flex: 4,
                        child: Column(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => QuickGamePage()));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/mainPage/startGame.jpg"),
                                          fit: BoxFit.cover)),
                                ),
                              ),
                            )
                          ],
                        )),
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(right: 18),
                        )),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => SettingPage()));
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/img/mainPage/setting.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                            )),
                          ],
                        )),
                    Expanded(
                        flex: 0,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 18),
                        )),
                    Expanded(
                        flex: 5,
                        child: Row(children: <Widget>[
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SettingPage()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/img/mainPage/change_1.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          )),
                        ])),
                  ],
                )),
            Expanded(flex: 4, child: Container())
          ],
        ),
      ),
    );
  }
}
