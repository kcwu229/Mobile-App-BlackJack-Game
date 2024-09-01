import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/userData.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

Future<String?> showDialogWindow(context, width, height, imageFiles) {
  final imageHeight = height / 10;
  final imageWidth = width / 8;
  int amountPerRow = 3;
  bool preview = false;
  String imageName = '';
  String appliedBG = '';
  List<String> imageList = imageFiles.sublist(amountPerRow);

  Completer<String?> completer = Completer();
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return FutureBuilder<Map<String, dynamic>>(
          future: loadBG(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!;
              appliedBG = userData['appliedBG'];
              print('This is : ${appliedBG}');
              return dialogContent(
                context,
                width,
                height,
                imageFiles,
                preview,
                amountPerRow,
                imageName,
                imageHeight,
                imageWidth,
              );
            } else if (snapshot.hasError) {
              return Text('Error loading user data: ${snapshot.error}');
            } else {
              return CircularProgressIndicator(); // or some other loading indicator
            }
          },
        );
      });

  return completer.future;
}

Widget iconButton(context, width, iconShape, function) {
  return IconButton(
      color: const Color.fromARGB(255, 240, 116, 8),
      iconSize: width / 12,
      onPressed: () => function,
      icon: Icon(iconShape));
}

Widget closeButton(context, width, iconShape) {
  return IconButton(
      color: Colors.black,
      iconSize: width / 30,
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(iconShape));
}

moveToLeft(context) {
  return null;
}

moveToRight(context) {
  return null;
}

Widget dialogContent(
  context,
  width,
  height,
  imageFiles,
  preview,
  int amountPerRow,
  imageName,
  imageHeight,
  imageWidth,
) {
  return Dialog(
      //set as full screen
      insetPadding: EdgeInsets.zero,
      child: StatefulBuilder(builder: (context, setState) {
        return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage((preview == false)
                        ? 'assets/img/background/bride_2.jpg'
                        : imageName),
                    fit: BoxFit.cover)),
            child: Column(children: [
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 9,
                          child: Container(
                            height: height / 10,
                          )),
                      // close button
                      Expanded(
                        flex: 1,
                        child: closeButton(context, width, Icons.close),
                      )
                    ],
                  )),
              Expanded(
                  flex: 8,
                  child: SizedBox(
                    height: height / 6,
                  )),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                iconButton(context, width, Icons.arrow_left, null),
                for (int i = 0; i < 5; i += amountPerRow)
                  Padding(
                    padding: EdgeInsets.all(width / 120),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          preview = true;
                          imageName = imageFiles[i];
                          print(imageName);
                        });
                      },
                      child: Container(
                        width: imageWidth,
                        height: imageHeight,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(imageFiles[i]),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                iconButton(context, width, Icons.arrow_right, null),
                MaterialButton(
                  onPressed: () => {
                    setState(() {
                      saveBG(imageName);
                    }),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainPageWidget()),
                    ),
                  },
                  child: Container(
                    width: width / 10,
                    height: height / 10,
                    color: Colors.orange,
                    child: Text(
                      'Apply',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: width / 38,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                )
              ]),
            ]));
      }));
}
