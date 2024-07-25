import 'package:flutter/material.dart';

// one of the function on mainPage
class QuickGamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Page'),
      ),
      body: Center(
        child: Text('This is the new page'),
      ),
    );
  }
}
