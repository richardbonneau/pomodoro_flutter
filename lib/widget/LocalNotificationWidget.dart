import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro/utils/LocalNotificationHelper.dart';
import 'package:pomodoro/pages/TimerApp.dart';

class LocalNotificationWidget extends StatefulWidget {
  @override
  _LocalNotificationWidgetState createState() =>
      _LocalNotificationWidgetState();
}

class _LocalNotificationWidgetState extends State<LocalNotificationWidget> {
  final notifications = FlutterLocalNotificationsPlugin();

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
  }

  Future onSelectNotification(String payload) async => print("clicked");


  @override
  Widget build(BuildContext context) => SizedBox.shrink();

//      RaisedButton(
//      child: Text("Notification"),
//      onPressed: () {
//        return showOngoingNotification(notifications,
//            title: "title", body: "body");
//      });
}
