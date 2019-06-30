import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xFF13293D),
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                color: Color(0xFF18435A),
              ),
            ),
            Flexible(
              flex: 5,
              child: Container(
                color: Color(0xFFF0F7EE),
                child: Text("hi"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
