import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pomodoro/utils/SendNotification.dart';
import 'package:audioplayers/audio_cache.dart';

AudioCache audioCache = AudioCache();

class TimerApp extends StatefulWidget {
  @override
  State createState() => new TimerAppState();
}

class TimerAppState extends State<TimerApp> {
  DateTime startingTime = DateTime.now();
  String timeWorked = "0:00:01";
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

  String remainingTimeUntilNextPhase = "24:59";
  DateTime phaseStartingTime = DateTime.now();
  var phaseTimes = {"FOCUS": 1, "Small Break": 5, "Big Break": 30};
  int currentPhaseIndex = 0;
  int nextPhaseIndex = 1;

  // Pause Button
  bool isAppPaused = false;
  Duration appPauseDuration = Duration();
  Icon pauseOrPlayIcon = Icon(Icons.pause);
  onPressPause() async {
    if (!isAppPaused) {
      await audioCache.play("pause.wav");
      this.setState(() {
        isAppPaused = true;

        pauseOrPlayIcon = Icon(Icons.play_arrow);
      });
    } else {
      await audioCache.play("play.wav");
      isAppPaused = false;
      this.setState(() => pauseOrPlayIcon = Icon(Icons.pause));
    }
  }

  goToNextPhase() async {
    if (phases[nextPhaseIndex] == "FOCUS") {
      print("back to work");
    } else if (phases[nextPhaseIndex] == "Small Break") {
      print("break time");
    } else {
      print("break time");
    }
    if (mounted)
      this.setState(() {
        phaseStartingTime = DateTime.now();
        appPauseDuration = Duration();
        remainingTimeUntilNextPhase = "00:00";
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

    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (remainingTimeUntilNextPhase == "00:01")
        this.goToNextPhase();
      else if (isAppPaused)
        appPauseDuration = appPauseDuration + Duration(seconds: 1);

      //  Global Time Worked
      Duration elapsedTime =
          DateTime.now().difference(startingTime) + Duration(seconds: 1);
      String stringifiedElapsedTime = elapsedTime.toString().substring(0, 7);

      //  Phase Timer
      Duration remainingTime = phaseStartingTime.difference(DateTime.now()) +
          Duration(minutes: phaseTimes[phases[currentPhaseIndex]]) +
          appPauseDuration;

      String stringifiedRemainingMinutes =
          remainingTime.toString().substring(2, 5);
      // We need to math.round the microseconds, otherwise, the app skips seconds sometimes.
      String stringifiedRemainingSeconds =
          (double.parse(remainingTime.toString().substring(5, 14)).round() - 1)
              .toString();

      if (stringifiedRemainingSeconds.length == 1)
        stringifiedRemainingSeconds = "0" + stringifiedRemainingSeconds;

      String stringifiedRemainingTime =
          stringifiedRemainingMinutes + stringifiedRemainingSeconds;

      if (mounted) {
        this.setState(() {
          timeWorked = stringifiedElapsedTime;
          remainingTimeUntilNextPhase = stringifiedRemainingTime;
        });
      }
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
              SizedBox(height: 0.0),
              Text(remainingTimeUntilNextPhase,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 70.0,
                      fontFamily: 'Roboto Condensed')),
              Text(
                phases[currentPhaseIndex],
                style: TextStyle(
                    fontFamily: 'Roboto Condensed',
                    color: Colors.white,
                    fontSize: 20.0),
              ),
              IconButton(
                icon: pauseOrPlayIcon,
                onPressed: this.onPressPause,
                iconSize: 40.0,
                color: Colors.white,
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
