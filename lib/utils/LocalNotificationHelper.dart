import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

NotificationDetails get normal {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel desc',
    importance: Importance.Max,
    priority: Priority.High,
    autoCancel: false,
    sound: "phase_finished",
);
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,

}) {
    print(title.toString()+ body.toString()+ id.toString()+ notifications.toString());
  return _showNotifications(notifications,
    title: title, body: body, type: normal);}


Future _showNotifications(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
}) =>
    notifications.show(0, title, body, type);
