import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/userData.dart';

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

Widget userInfo() {
  // need further study
  return FutureBuilder<Map<String, dynamic>>(
    future: loadUserData(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        final userData = snapshot.data!;
        final userExpTable = UserExp();
        final userlevel = userData['level'];
        final userCurrentExp = userData['level'];
        final totalExp = userExpTable.getExp(userlevel);

        return Column(
          children: [
            userLevel('LV. ${userlevel}'),
            userExp('${userCurrentExp}  / ${totalExp}', 15.0),
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

Widget userLevel(text) {
  return Container(
    alignment: Alignment.bottomLeft,
    width: 180,
    height: 40,
    child: Text(
      text,
      style: TextStyle(
        color: const Color.fromARGB(255, 24, 24, 24),
        fontWeight: FontWeight.w400,
        fontSize: 20,
      ),
    ),
  );
}

Widget userExp(text, fontSize) {
  return Container(
    alignment: Alignment.center,
    width: 180,
    height: 25,
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
