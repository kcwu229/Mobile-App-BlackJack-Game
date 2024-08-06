import 'package:flutter/material.dart';

Map<String, List<double>> dialogLocation = {
  // 1:left 2:top 3:right 4. bottom
  'dealer': [0.33, 0.23],
  'cpu1': [0.2, 0.6],
  'player': [0.55, 0.7],
  'cpu2': [0.88, 0.65],
};

Widget dialogFrameWork(text, distanceConfig) {
  return Align(
    child: Positioned(
      width: 120,
      height: 80,
      left: distanceConfig[0],
      top: distanceConfig[1],
      right: distanceConfig[2],
      bottom: distanceConfig[3],
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    ),
  );
}
