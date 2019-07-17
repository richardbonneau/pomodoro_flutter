import 'package:flutter/material.dart';
import 'dart:async';

class TimerOnly extends StatefulWidget {
  @override
  State createState() => new TimerOnlyState();
}

class TimerOnlyState extends State<TimerOnly> {
  DateTime startingTime = DateTime.now();

  String timeWorked = "0:00:00";

  int currentHours = 0;
  int currentMinutes = 0;
  int currentSeconds = 0;

  // Pause Button
  Icon pauseOrPlayIcon = Icon(Icons.pause_circle_filled);
  bool isTimerPaused = false;
  onPressPause() {
    if (!isTimerPaused)
      this.setState(() => {
            isTimerPaused = true,
            pauseOrPlayIcon = Icon(Icons.play_circle_filled),
          });
    else {
      isTimerPaused = false;
      this.setState(() => pauseOrPlayIcon = Icon(Icons.pause_circle_filled));
    }
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(new Duration(seconds: 1), (timer) {
      Duration currentTime = DateTime.now().difference(startingTime);
      String stringifiedTime = currentTime.toString().substring(0, 7);
      print(stringifiedTime);

      this.setState(() => {timeWorked = stringifiedTime});
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF18435A),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(timeWorked,
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              SizedBox(height: 0.0),
              Text(
                  currentHours.toString() +
                      ":" +
                      currentMinutes.toString() +
                      ":" +
                      currentSeconds.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                      fontFamily: 'Roboto Condensed')),
              IconButton(icon: pauseOrPlayIcon, onPressed: this.onPressPause),
              Text(
                "FOCUS",
                style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              SizedBox(height: 0.0),
              Text(
                "Coming up : Small break",
                style: TextStyle(
                    fontFamily: 'Roboto Condensed', color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
