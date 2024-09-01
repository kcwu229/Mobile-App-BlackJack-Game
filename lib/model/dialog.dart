import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_blackjack/model/userData.dart';
import 'package:flutter_blackjack/pages/mainPage.dart';

showDialogWindow(BuildContext context, double width, double height,
    List<String> imageFiles) {
  ValueNotifier<String> selectedImage = ValueNotifier<String>(imageFiles[0]);
  final imageHeight = height / 10;
  final imageWidth = width / 8;

  int amountPerRow = 3;
  int currentIndex = 0;

  void nextImage() {
    if (currentIndex + amountPerRow < imageFiles.length) {
      currentIndex += 1;
      selectedImage.value = imageFiles[currentIndex];
    }
  }

  void prevImage() {
    if (currentIndex > 0) {
      currentIndex -= 1;
      selectedImage.value = imageFiles[currentIndex];
    }
  }

  void onSwipe(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      prevImage();
    } else if (details.delta.dx < 0) {
      nextImage();
    }
  }

  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (context, animation1, animation2) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        child: ValueListenableBuilder<String>(
          valueListenable: selectedImage,
          builder: (context, currentImage, child) {
            return GestureDetector(
              onHorizontalDragUpdate: onSwipe,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(selectedImage.value),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 9,
                            child: Container(height: height / 10),
                          ),
                          Expanded(
                            flex: 1,
                            child: closeButton(context, width, Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: SizedBox(height: height / 6),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_left),
                          color: const Color.fromARGB(255, 240, 116, 8),
                          iconSize: width / 12,
                          onPressed: prevImage,
                        ),
                        for (var i = 0; i < amountPerRow; i++)
                          Padding(
                            padding: EdgeInsets.all(width / 130),
                            child: GestureDetector(
                              onTap: () {
                                selectedImage.value =
                                    imageFiles[currentIndex + i];
                              },
                              child: ValueListenableBuilder<String>(
                                valueListenable: selectedImage,
                                builder: (context, currentImage, child) {
                                  bool isSelected = currentImage ==
                                      imageFiles[currentIndex + i];
                                  return AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    transform: isSelected
                                        ? Matrix4.translationValues(0, -10, 0)
                                        : Matrix4.identity(),
                                    child: Container(
                                      width: imageWidth,
                                      height: imageHeight,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              imageFiles[currentIndex + i]),
                                          fit: BoxFit.cover,
                                        ),
                                        border: (selectedImage.value ==
                                                imageFiles[currentIndex + i])
                                            ? Border.all(
                                                width: 6, color: Colors.orange)
                                            : null,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        IconButton(
                          icon: Icon(Icons.arrow_right),
                          color: const Color.fromARGB(255, 240, 116, 8),
                          iconSize: width / 12,
                          onPressed: nextImage,
                        ),
                        MaterialButton(
                          onPressed: () {
                            saveBG(selectedImage.value);
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        MainPageWidget(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width / 10,
                            height: height / 10,
                            color: Colors.orange,
                            child: Text(
                              'Apply',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: width / 50,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

Widget closeButton(BuildContext context, double width, IconData iconShape) {
  return IconButton(
    color: Colors.black,
    iconSize: width / 30,
    onPressed: () => Navigator.of(context).pop(),
    icon: Icon(iconShape),
  );
}
