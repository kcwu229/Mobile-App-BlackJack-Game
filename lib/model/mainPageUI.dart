import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/musicPlayer.dart';
import 'package:flutter_blackjack/model/userData.dart';
import 'package:flutter_blackjack/pages/bettingPage.dart';
import 'package:flutter_blackjack/pages/settingPage.dart';

Widget mainPagePanel(
  top,
  left,
  text,
) {
  return Positioned(
      top: top,
      left: left,
      child: Text(text,
          style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1.3, 1.3),
                  blurRadius: 1.0,
                  color: Colors.black,
                ),
              ])));
}

Widget userIcon(width, height) {
  return Container(
    width: width,
    height: height,
    decoration: const BoxDecoration(
        image: DecorationImage(
      image: AssetImage("assets/img/mainPage/gameIcon_2.png"),
    )),
  );
}

Widget userInfo(width, height, fontSize) {
  // need further study
  return FutureBuilder<Map<String, dynamic>>(
    future: loadUserData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final userData = snapshot.data!;
        final userExpTable = UserExp();
        final userlevel = userData['level'];
        final userCurrentExp = userData['exp'];
        final totalExp = userExpTable.getExp(userlevel);

        return Column(
          children: [
            userLevel('LV. ${userlevel}', width, height, fontSize),
            userExp(
                '${userCurrentExp}  / ${totalExp}', width, height, fontSize),
          ],
        );
      } else if (snapshot.hasError) {
        return Text('Error loading user data: ${snapshot.error}');
      } else {
        return CircularProgressIndicator(); // or some other loading indicator
      }
    },
  );
}

Widget userLevel(text, width, height, fontSize) {
  return Container(
    alignment: Alignment.bottomLeft,
    width: width,
    height: height,
    child: Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(255, 24, 24, 24),
        fontWeight: FontWeight.w400,
        fontSize: fontSize,
      ),
    ),
  );
}

Widget coinField(width, height, itemName, imageName, musicplayer, context) {
  return FutureBuilder<Map<String, dynamic>>(
      future: loadUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data!;
          final gachaCoin = userData[itemName];

          return Container(
              transform: Matrix4.identity()
                ..translate(width / 5, height / -5, 0.0),
              color: const Color.fromARGB(201, 50, 50, 50),
              child: Row(children: [
                SizedBox(
                    height: height / 2.5,
                    width: width / 1.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            flex: 2,
                            child: Container(
                                width: width,
                                height: height,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      'assets/img/mainPage/${imageName}.png'),
                                  fit: BoxFit.cover,
                                )))),
                        Expanded(
                            flex: 4,
                            child: Center(
                              child: Text(
                                '${gachaCoin}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: height / 5),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: IconButton(
                                iconSize: height / 5,
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  musicplayer.stopAudio();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BattlePage()),
                                  );
                                }))
                      ],
                    ))
              ]));
        } else if (snapshot.hasError) {
          return Text('Error loading user data: ${snapshot.error}');
        } else {
          return CircularProgressIndicator(); // or some other loading indicator
        }
      });
}

Widget userExp(text, width, height, fontSize) {
  return Container(
    alignment: Alignment.center,
    width: width,
    height: height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.yellow,
        Colors.transparent,
      ],
    )),
    child: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}

Widget mainPanels(
    height, width, musicplayer, context, imageName, text, pageFunction) {
  return Expanded(
      flex: 2,
      child: InkWell(
        onTap: () {
          musicplayer.stopAudio();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => pageFunction));
        },
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2),
                image: DecorationImage(
                    image: AssetImage("assets/img/mainPage/${imageName}.png"),
                    fit: BoxFit.cover)),
          ),
          mainPagePanel(height / 3.3, width / 30, text)
        ]),
      ));
}

Widget iconPanels(iconHeight, iconWidth, musicplayer, context, iconShape) {
  return SizedBox(
      height: iconHeight,
      width: iconWidth,
      child: IconButton(
          icon: Icon(
            iconShape,
            color: Colors.white,
          ),
          onPressed: () {
            musicplayer.stopAudio();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BattlePage()),
            );
            //
          }));
}
