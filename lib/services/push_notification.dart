import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_notif/models/data.dart';
import 'package:http/http.dart' as http;

import '../screen_notif.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm;
  final context;
  final String api_token =
      "AAAADQGC4kE:APA91bHDXx5X4Rv5VaWR9UgFlxvEJYUPRsp3y0gqVzdCrsZRvbBfb3wSRvSIWDWC1Uw0NyXi3ykKbbof205tJjP9X9sue-kilv4TdTrDPkEAwmJNMTF7YGZLyYKAyzsVbK5WDZk2zfSw";

  PushNotificationService(this._fcm, this.context);

  Future getToken() async {
    String token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
    return token;
  }

  Future<void> callOnFcmApiSendPushNotifications(
      String _token, String kelas, String lab, String kursi, String jam) async {
    final postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "to": _token,
      "notification": {
        "title": 'Berhasil',
        "body":
            'Selamat anda berhasil menambahkan data jadwal praktikum. Klik tombol untuk melihat data',
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "sound": "default"
      },
      "data": {
        "mata_kuliah": kelas,
        "lab": lab,
        "kursi": kursi,
        "jam": jam,
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization': "key=$api_token" // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print('CFM error');
      // on failure do sth
      return false;
    }
  }

  void initialise() {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(
              message['notification']['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(message['notification']['body']),
            actions: [
              FlatButton(
                color: Color(0xFFFF5B16),
                textColor: Colors.white,
                child: Text("Lihat"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () {
                  final data = Data(
                    title: message['notification']['title'],
                    body: message['notification']['body'],
                    mata_kuliah: message['data']['mata_kuliah'],
                    lab: message['data']['lab'],
                    kursi: message['data']['kursi'],
                    jam: message['data']['jam'],
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationData(data: data),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        final data = Data(
          title: message['notification']['title'],
          body: message['notification']['body'],
          mata_kuliah: message['data']['mata_kuliah'],
          lab: message['data']['lab'],
          kursi: message['data']['kursi'],
          jam: message['data']['jam'],
        );
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotificationData(data: data)));
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        final data = Data(
          title: message['notification']['title'],
          body: message['notification']['body'],
          mata_kuliah: message['data']['mata_kuliah'],
          lab: message['data']['lab'],
          kursi: message['data']['kursi'],
          jam: message['data']['jam'],
        );
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => NotificationData(data: data)));
        });
      },
    );
  }
}
