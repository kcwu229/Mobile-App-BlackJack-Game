import 'package:flutter/material.dart';

showDialogWindow(context, width, height, imageFiles) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Container(
            alignment: Alignment.center,
            child: AlertDialog(
              backgroundColor: Color.fromARGB(255, 247, 247, 248),
              alignment: Alignment.center,
              title: Text(
                'Welcome',
                style: TextStyle(color: Colors.black),
              ),
              content: SizedBox(
                  width: width * 0.9,
                  height: height * 0.9,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            for (var imageFile in imageFiles)
                              Container(
                                width: width / 3,
                                height: height / 5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(imageFile))),
                              )
                          ],
                        )
                      ])),
              actions: [],
            ));
      });
}
