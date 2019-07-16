import 'package:flutter/material.dart';

class TimerOnly extends StatefulWidget {
  @override
  State createState() => new TimerOnlyState();
}

class TimerOnlyState extends State<TimerOnly> {
  int globalHours = 1;
  int globalMinutes = 0;
  int globalSeconds = 0;

  int currentHours = 0;
  int currentMinutes = 0;
  int currentSeconds = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF18435A),
      body: SafeArea(
        child: Flexible(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  globalHours.toString() +
                      ":" +
                      globalMinutes.toString() +
                      ":" +
                      globalSeconds.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 20.0)),
              SizedBox(height: 30.0),
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
              Text(
                "Current State",
                style: TextStyle(
                    fontFamily: 'Roboto Condensed', color: Colors.white),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Next State",
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
