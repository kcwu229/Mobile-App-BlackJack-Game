import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/mainPageUI.dart';
import 'package:flutter_blackjack/model/musicPlayer.dart';
import 'package:flutter_blackjack/model/userData.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/settingPage.dart';

// shift to the main page

class MainPageWidget extends StatefulWidget {
  @override
  _MainPageWidgetState createState() => _MainPageWidgetState();
}

class _MainPageWidgetState extends State<MainPageWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Musicplayer musicplayer = new Musicplayer();
  int userLevel = 0;
  int userExp = 0;

  @override
  void initState() {
    super.initState();
    musicplayer.playAudio('music/mainPage.mp3');

    // read the User Data
    loadUserData();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double width = mediaQuery.size.width;
    double iconHeight = height / 12;
    double iconWidth = width / 25;
    return Scaffold(
      body: PopScope(
          canPop: false,
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/img/mainPage/mainPage.gif"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Transform(
                          alignment: Alignment.topRight,
                          transform: Matrix4.identity()
                            ..translate(width / 19, height / 100, 0.0),
                          child: userIcon(width / 5, height / 5)),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            userInfo(width / 4.5, height / 20, height / 30),
                            Container(
                                color: const Color.fromARGB(104, 158, 158, 158),
                                child: Row(children: [
                                  SizedBox(
                                      height: iconHeight,
                                      width: iconWidth,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.email_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            musicplayer.stopAudio();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BattlePage()),
                                            );
                                            //
                                          })),
                                  SizedBox(
                                      height: iconHeight,
                                      width: iconWidth,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.settings,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            musicplayer.stopAudio();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BattlePage()),
                                            );
                                            //
                                          })),
                                  SizedBox(
                                      height: iconHeight,
                                      width: iconWidth,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.facebook,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            musicplayer.stopAudio();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BattlePage()),
                                            );
                                            //
                                          })),
                                  SizedBox(
                                      height: iconHeight,
                                      width: iconWidth,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.menu,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            musicplayer.stopAudio();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BattlePage()),
                                            );
                                            //
                                          }))
                                ])),
                          ])
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 5, child: Container()),
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {
                                musicplayer.stopAudio();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => QuickGamePage()));
                              },
                              child: Stack(children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/mainPage/quickGame.png"),
                                          fit: BoxFit.cover)),
                                ),
                                mainPagePanel(
                                    height / 3.3, width / 30, 'Quick Game')
                              ]),
                            )),
                        Padding(padding: EdgeInsets.all(2)),
                        Expanded(
                            flex: 2,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                    flex: 6,
                                    child: InkWell(
                                      onTap: () {
                                        musicplayer.stopAudio();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BattlePage()));
                                      },
                                      child: Stack(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 2),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/img/mainPage/battle.png'),
                                                  fit: BoxFit.cover)),
                                        ),
                                        mainPagePanel(
                                            height / 3.2, width / 15, 'Battle')
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
          )),
    );
  }
}
