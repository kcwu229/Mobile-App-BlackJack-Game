import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/mainPageUI.dart';
import 'package:flutter_blackjack/model/userData.dart';

Widget showPlayerUI(winnerName, width, height) {
  // adding exp and level up

  return Padding(
      padding: EdgeInsets.all(height / 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                    height: height / 1.4,
                    width: width / 8,
                  ))),
          Expanded(
            flex: 1,
            child: Transform.rotate(
                angle: -5 * 3.14159 / 180,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white,
                  height: height / 4,
                  width: width / 8,
                  child: Text(
                    '${winnerName}',
                    style: TextStyle(
                        fontSize: height / 40,
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

Widget showUserExp(
    level, exp, slideOne, function, totalExp, expAward, width, height) {
  // Add a state variable to keep track of the user's level and experience

  UserExp userExpClass = new UserExp();

  return FutureBuilder<Map<String, dynamic>>(
    future: loadUserData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final userData = snapshot.data!;
        final userExpTable = UserExp();
        final int userlevel = userData['level'];
        final int userCurrentExp = userData['exp'];
        final int totalExp = userExpTable.getExp(userlevel);
        userExpClass.levelUp(userlevel, userCurrentExp, expAward);

        return Padding(
            padding: EdgeInsets.all(height / 80),
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
                                  flex: 2, child: glowingEffect(height, width)),
                              Expanded(flex: 1, child: Container()),
                              levelBar(userlevel, userCurrentExp, totalExp,
                                  expAward, width, height),
                              Expanded(flex: 1, child: Container()),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    width: width / 3,
                                    height: height / 3,
                                    child: obtainItemList(height),

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
                                FadeAnimatedText('Tap here to HomePage     ')
                              ],
                              repeatForever: true,
                            )))),
              ),
            ]));
      } else if (snapshot.hasError) {
        return Text('Error loading user data: ${snapshot.error}');
      } else {
        return CircularProgressIndicator(); // or some other loading indicator
      }
    },
  );
}

Widget levelBar(userlevel, userCurrentExp, totalExp, expAward, width, height) {
  userCurrentExp += expAward;
  return Row(children: [
    Expanded(
        flex: 2,
        child: Text(
          '  Lv.${userlevel}',
          style: TextStyle(color: Colors.white, fontSize: height / 20),
        )),
    SizedBox(
      height: height / 10,
    ),
    Expanded(
        flex: 6,
        child: Container(
          width: width / 4,
          height: height / 20,
          color: Colors.green,
          child: userExp(
              '${userCurrentExp}  / ${totalExp}', width, height, height / 28),
          // To Do List
        )),
    Expanded(
        flex: 2,
        child: Text(
          '   + ${expAward}',
          style: TextStyle(color: Colors.white, fontSize: height / 25),
        ))
  ]);
}

Widget obtainItemList(height) {
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
            padding: EdgeInsets.all(height / 80),
            child: Text(
              '1',
              style: TextStyle(color: Colors.white, fontSize: height / 25),
            ),
          ))
    ],
  );
}
