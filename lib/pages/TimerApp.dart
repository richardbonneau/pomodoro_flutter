import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pomodoro/utils/AppColors.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:pomodoro/utils/LocalNotificationHelper.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/my_flutter_app_icons.dart';

AudioCache audioCache = AudioCache();

class TimerApp extends StatefulWidget {
  @override
  State createState() => new TimerAppState();
}

class TimerAppState extends State<TimerApp> {
  final notifications = FlutterLocalNotificationsPlugin();

  DateTime startingTime = DateTime.now();
  String timeWorked = "0:00:01";
  int sessionBeforeBigBreak = 4;
  List<String> phases = [
    "Focus Session",
    "Small Break",
    "Focus Session",
    "Small Break",
    "Focus Session",
    "Small Break",
    "Focus Session",
    "Big Break"
  ];

  String remainingTimeUntilNextPhase = "24:59";
  DateTime phaseStartingTime = DateTime.now();
  var phaseTimes = {"Focus Session": 1, "Small Break": 5, "Big Break": 30};
  int currentPhaseIndex = 0;
  int nextPhaseIndex = 1;
  double circularProgress = 0.0;
  Icon currentPhaseIcon = Icon(CustomIcons.laptop);

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

    String notificationTitle = "";
    String notificationBody = "";

    if (phases[nextPhaseIndex] == "Focus Session") {
      if (sessionBeforeBigBreak != 0)
        sessionBeforeBigBreak -= 1;
      else
        sessionBeforeBigBreak = 4;
      currentPhaseIcon = Icon(
        CustomIcons.center_focus_strong,
      );
      notificationTitle = "Back to work!";
      notificationBody = "Break's over ";
      print("back to work");
    } else if (phases[nextPhaseIndex] == "Small Break") {
      currentPhaseIcon = Icon(CustomIcons.coffee);
      notificationTitle = "Time for a break!";
      notificationBody =
          "This is your own time. Do whatever you want for 5 minutes.";
      print("break time");
    } else {
      currentPhaseIcon = Icon(CustomIcons.bed);
      notificationTitle = "Time for a long break!";
      notificationBody = "You deserve this. Step away from work for a while.";
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
    showOngoingNotification(notifications,
        title: notificationTitle, body: notificationBody);
  }

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);

    Timer.periodic(Duration(seconds: 1), (timer) async {
      if (remainingTimeUntilNextPhase == "00:00")
        this.goToNextPhase();
      else if (isAppPaused)
        appPauseDuration = appPauseDuration + Duration(seconds: 1);

      //  Global Time Worked
      Duration elapsedTime =
          DateTime.now().difference(startingTime) + Duration(seconds: 1);
      String stringifiedElapsedTime = elapsedTime.toString().substring(0, 7);

      //  Phase Timer
      Duration remainingTime = phaseStartingTime.difference(DateTime.now()) +
          Duration(
              minutes: phaseTimes[phases[currentPhaseIndex]], seconds: -1) +
          appPauseDuration;

      circularProgress = 1 -
          (remainingTime).inSeconds /
              (Duration(minutes: phaseTimes[phases[currentPhaseIndex]])
                  .inSeconds);
      // Clamps the duration over 0 seconds.
      if (remainingTime.isNegative) remainingTime = new Duration(seconds: 0);
      String stringifiedRemainingMinutes =
          remainingTime.toString().substring(2, 5);
      // We need to math.round the microseconds, otherwise, the app skips seconds sometimes.
      String stringifiedRemainingSeconds =
          (double.parse(remainingTime.toString().substring(5, 14)).round())
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

  Future onSelectNotification(String payload) async => print("clicked");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: mainBackgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
//              LocalNotificationWidget(),
              Text(timeWorked,
                  style: TextStyle(color: textColor, fontSize: 20.0)),
              SizedBox(height: 50.0),
              Stack(
                children: <Widget>[
                  Positioned(
                    child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                            height: 240.0,
                            width: 240.0,
                            child: CircularProgressIndicator(
                              value: circularProgress,
                              backgroundColor: circleProgressBackgroundColor,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  circleProgressBarColor),
                            ))),
                  ),
                  Positioned(
                      top: 70.0,
                      left: MediaQuery.of(context).size.width / 2 - 77.0,
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(remainingTimeUntilNextPhase,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 70.0,
                                  fontFamily: 'Roboto Condensed')))),
                  Positioned(
                    top: 160.0,
                    left: MediaQuery.of(context).size.width / 2 - 27.0,
                    child: IconButton(
                      icon: pauseOrPlayIcon,
                      onPressed: this.onPressPause,
                      iconSize: 40.0,
                      color: textColor,
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: currentPhaseIcon,
                    onPressed: this.onPressPause,
                    iconSize: 25.0,
                    color: textColor,
                  ),
                  Text(
                    phases[currentPhaseIndex],
                    style: TextStyle(
                        fontFamily: 'Roboto Condensed',
                        color: textColor,
                        fontSize: 25.0),
                  ),
                ],
              ),

              SizedBox(height: 55.0),
              Text(

                sessionBeforeBigBreak.toString()+" Focus "+(sessionBeforeBigBreak == 1 ? "Session" : "Sessions" )+" before Big Break",
                style:
                    TextStyle(fontFamily: 'Roboto Condensed', color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
