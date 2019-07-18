import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pomodoro/pages/TimerApp.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xFF13293D),
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      home: new TimerApp()
    );
  }
}
