import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/mainPageUI.dart';
import 'package:flutter_blackjack/model/musicPlayer.dart';
import 'package:flutter_blackjack/model/userData.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/settingPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final prefs = SharedPreferences.getInstance();
    List<IconData> iconList = [
      Icons.email_rounded,
      Icons.settings,
      Icons.facebook,
      Icons.menu
    ];

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
                                color: const Color.fromARGB(154, 59, 59, 59),
                                child: Row(children: [
                                  for (var iconItem in iconList)
                                    iconPanels(iconHeight, iconWidth,
                                        musicplayer, context, iconItem),
                                ])),
                          ]),
                      SizedBox(width: width / 10),
                      coinField(width / 5, height / 7, 'coin', 'coin',
                          musicplayer, context),
                      SizedBox(width: width / 40),
                      coinField(width / 5, height / 7, 'gachaCoin', 'gachaCoin',
                          musicplayer, context),
                    ],
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex: 5, child: Container()),
                        mainPanels(height, width, musicplayer, context,
                            'quickGame', 'Quick Game', QuickGamePage()),
                        Padding(padding: EdgeInsets.all(2)),
                        mainPanels(height, width, musicplayer, context,
                            'battle', 'Battle', BattlePage()),
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
