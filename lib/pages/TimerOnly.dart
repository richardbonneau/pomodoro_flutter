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

  // Pause Button
  Icon pauseOrPlayIcon = Icon(Icons.pause_circle_filled);
  bool isTimerPaused = false;
  onPressPause() {
    if (!isTimerPaused)
      this.setState(() => {
      isTimerPaused = true,
        pauseOrPlayIcon = Icon(Icons.play_circle_filled)
      });
    else{
    isTimerPaused = false;
    this.setState(() => pauseOrPlayIcon = Icon(Icons.pause_circle_filled));
    }
  }

  @override
  void initState() {
    super.initState();
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
              Text(
                  globalHours.toString() +
                      ":" +
                      globalMinutes.toString() +
                      ":" +
                      globalSeconds.toString(),
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
