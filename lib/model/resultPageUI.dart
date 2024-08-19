import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/mainPageUI.dart';
import 'package:flutter_blackjack/model/userData.dart';

Widget showPlayerUI(winnerName) {
  // adding exp and level up

  return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(
              flex: 9,
              child: Transform.rotate(
                  angle: 5 * 3.14159 / 180,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 3),
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/img/resultPage/${winnerName}Won.jpg"),
                          fit: BoxFit.cover,
                        )),
                    height: 70.0,
                    width: 170.0,
                  ))),
          Expanded(
            flex: 1,
            child: Transform.rotate(
                angle: -5 * 3.14159 / 180,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: 30.0,
                  width: 170.0,
                  child: Text(
                    '${winnerName}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 32, 32, 32)),
                  ),
                )),
          )
        ],
      ));
}

Widget glowingEffect(width, height) {
  return AvatarGlow(
    glowShape: BoxShape.circle,
    repeat: true,
    curve: Curves.fastOutSlowIn,
    glowColor: Colors.orange,
    duration: Duration(seconds: 3),
    child: Image(
        image: AssetImage("assets/img/playerIcon/winLogo.png"),
        width: width,
        height: height),
  );
}

Widget showUserExp(level, exp, slideOne, function, width, totalExp, expAward) {
  // Add a state variable to keep track of the user's level and experience

  final ValueNotifier<Map<String, dynamic>> _userData =
      ValueNotifier<Map<String, dynamic>>({
    'level': 0,
    'exp': 0,
  });

  UserExp userExpClass = new UserExp();

  userExpClass.levelUp(level, exp, expAward);

  return FutureBuilder<Map<String, dynamic>>(
    future: loadUserData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final userData = snapshot.data!;
        final userExpTable = UserExp();

        // Update the state variable with the user's level and experience
        _userData.value = {
          'level': userData['level'],
          'exp': userData['exp'],
        };

        return ValueListenableBuilder(
            valueListenable: _userData,
            builder: (context, userData, _) {
              final userlevel = userData['level'];
              final userCurrentExp = userData['exp'];
              final totalExp = userExpTable.getExp(userlevel);

              userExpClass.levelUp(userlevel, userCurrentExp, expAward);

              return Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Expanded(
                        flex: 9,
                        child: Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 3,
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/resultPage/playerFullBody.png"),
                                          fit: BoxFit.cover,
                                        )))),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                        flex: 2,
                                        child: glowingEffect(100.0, 100.0)),
                                    Expanded(flex: 1, child: Container()),
                                    levelBar(userlevel, userCurrentExp,
                                        totalExp, expAward),
                                    Expanded(flex: 1, child: Container()),
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: 400,
                                          height: 160,
                                          child: obtainItemList(),

                                          // To Do List
                                        )),
                                    Expanded(flex: 1, child: Container()),
                                  ],
                                )),
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: slideOne ? '' : function,
                          child: Container(
                              color: const Color.fromARGB(231, 238, 146, 8),
                              alignment: Alignment.centerRight,
                              width: width,
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
                    ),
                  ]));
            });
      } else if (snapshot.hasError) {
        return Text('Error loading user data: ${snapshot.error}');
      } else {
        return CircularProgressIndicator(); // or some other loading indicator
      }
    },
  );
}

Widget levelBar(userlevel, userCurrentExp, totalExp, expAward) {
  return Row(children: [
    Expanded(
        flex: 2,
        child: Text(
          '  Lv.${userlevel}',
          style: TextStyle(color: Colors.white, fontSize: 15),
        )),
    SizedBox(
      height: 80,
    ),
    Expanded(
        flex: 6,
        child: Container(
          width: 200,
          height: 20,
          color: Colors.green,
          child: userExp('${userCurrentExp}  / ${totalExp}', 10.0),
          // To Do List
        )),
    Expanded(
        flex: 2,
        child: Text(
          '   + ${expAward}',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ))
  ]);
}

Widget obtainItemList() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(
                  color: const Color.fromARGB(243, 246, 246, 246), width: 3),
              image: DecorationImage(
                image: AssetImage("assets/img/resultPage/coin.jpg"),
                fit: BoxFit.cover,
              )),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              '1',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ))
    ],
  );
}
