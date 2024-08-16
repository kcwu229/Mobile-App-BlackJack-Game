import 'package:flutter/material.dart';

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
  return Column(
    children: [
      userLevel('LV.20'),
      userExp('20/100'),
    ],
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

Widget userExp(text) {
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
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
