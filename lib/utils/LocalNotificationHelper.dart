import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

NotificationDetails get _ongoing {
  final androidChannelSpecifics = AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    'your channel desc',
    importance: Importance.Max,
    priority: Priority.High,
    ongoing: true,
    autoCancel: false,
    sound: "phase_finished",
);
  final iOSChannelSpecifics = IOSNotificationDetails();
  return NotificationDetails(androidChannelSpecifics, iOSChannelSpecifics);
}

Future showOngoingNotification(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  int id = 0,

}) =>
    _showNotifications(notifications,
        title: title, body: body, id: id, type: _ongoing);

Future _showNotifications(
  FlutterLocalNotificationsPlugin notifications, {
  @required String title,
  @required String body,
  @required NotificationDetails type,
  int id = 0,
}) =>
    notifications.show(id, title, body, type);
