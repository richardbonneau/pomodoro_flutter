import 'package:http/http.dart';

class SendNotification {
  final String id;
  final String title;
  final String body;
  final String sound;

  SendNotification({this.id,this.title,this.body,this.sound});

  factory SendNotification.fromJson(Map<String, dynamic> json) {
    return SendNotification(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["title"] = title;
    map["body"] = body;
    map['sound'] = sound;
    map['click_action']= 'FLUTTER_NOTIFICATION_CLICK';

    return map;
  }
}