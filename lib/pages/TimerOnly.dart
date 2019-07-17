import 'package:flutter/material.dart';
import 'dart:async';

class TimerOnly extends StatefulWidget {
  @override
  State createState() => new TimerOnlyState();
}

class TimerOnlyState extends State<TimerOnly> {
  DateTime startingTime = DateTime.now();
  String timeWorked = "0:00:00";
  List<String> phases = [
    "FOCUS",
    "Small Break",
    "FOCUS",
    "Small Break",
    "FOCUS",
    "Small Break",
    "FOCUS",
    "Big Break"
  ];

  String remainingTime = "0:00:00";
  DateTime phaseStartingTime = DateTime.now();
  var phaseTimes = {"FOCUS": 25, "Small Break": 5, "Big Break": 30};
  int currentPhaseIndex = 0;
  int nextPhaseIndex = 1;

  // Pause Button
  Icon pauseOrPlayIcon = Icon(Icons.pause_circle_filled);
  bool isTimerPaused = false;
  onPressPause() {
    if (!isTimerPaused)
      this.setState(() {
        isTimerPaused = true;
        pauseOrPlayIcon = Icon(Icons.play_circle_filled);
      });
    else {
      isTimerPaused = false;
      this.setState(() => pauseOrPlayIcon = Icon(Icons.pause_circle_filled));
    }
  }

  goToNextPhase() {
    this.setState(() {
      currentPhaseIndex = nextPhaseIndex;
      if (currentPhaseIndex == 7)
        nextPhaseIndex = 0;
      else
        nextPhaseIndex = nextPhaseIndex + 1;
    });
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(new Duration(seconds: 1), (timer) {
      //  Global Time Worked
      Duration elapsedTime = DateTime.now().difference(startingTime);
      String stringifiedElapsedTime = elapsedTime.toString().substring(0, 7);

      //  Phase Timer
      Duration remainingTIme = phaseStartingTime.difference(DateTime.now()) +
          Duration(minutes: phaseTimes[phases[currentPhaseIndex]]);
      String stringifiedRemainingTIme =
          remainingTIme.toString().substring(0, 7);

      this.setState(() {
        timeWorked = stringifiedElapsedTime;
      });
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
              Text("00:00",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                      fontFamily: 'Roboto Condensed')),
              IconButton(icon: pauseOrPlayIcon, onPressed: this.onPressPause),
              Text(
                phases[currentPhaseIndex],
                style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              SizedBox(height: 0.0),
              Text(
                "Coming up : " + phases[nextPhaseIndex],
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
