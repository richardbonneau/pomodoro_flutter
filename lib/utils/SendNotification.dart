import 'dart:convert';

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
    var details = new Map<String, String>();
    details["title"] = title;
    details["body"] = body;
    details['sound'] = sound;
    details['click_action']= 'FLUTTER_NOTIFICATION_CLICK';
    details['priority'] = 'high';
    map["to"] = id;
    map["notification"] = json.encode(details);

    return map;
  }
}