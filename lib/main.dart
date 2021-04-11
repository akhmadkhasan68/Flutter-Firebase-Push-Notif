import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_notif/screen_notif.dart';
import 'package:flutter_notif/services/push_notification.dart';
import 'package:flutter/material.dart';
import 'models/data.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: App(),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController _matakuliahController = TextEditingController();
  TextEditingController _labController = TextEditingController();
  TextEditingController _kursiController = TextEditingController();
  TextEditingController _jamController = TextEditingController();

  String _token = "";

  String title = "";
  String body = "";
  String kelas = "";
  String lab = "";
  String kursi = "";
  String jam = "";

  void Submit() async {
    final pushNotificationService =
        PushNotificationService(_firebaseMessaging, context);
    //SEND
    print(pushNotificationService.callOnFcmApiSendPushNotifications(
        _token, kelas, lab, kursi, jam));
  }

  @override
  void initState() {
    final pushNotificationService =
        PushNotificationService(_firebaseMessaging, context);
    pushNotificationService.initialise();
    pushNotificationService.getToken().then((value) {
      setState(() {
        _token = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Notif"),
        backgroundColor: Color(0xFFFF5B16),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Nama Mata Kuliah",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    kelas = value;
                  });
                },
                controller: _matakuliahController,
                style: TextStyle(
                  color: Color(0xff757575),
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Masukkan Nama Mata Kuliah",
                  hintStyle: TextStyle(color: Color(0xff757575)),
                  filled: true,
                  fillColor: Color(0xffe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Lokasi Lab",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    lab = value;
                  });
                },
                controller: _labController,
                style: TextStyle(
                  color: Color(0xff757575),
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Masukkan Lokasi Lab",
                  hintStyle: TextStyle(color: Color(0xff757575)),
                  filled: true,
                  fillColor: Color(0xffe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Kursi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    kursi = value;
                  });
                },
                controller: _kursiController,
                style: TextStyle(
                  color: Color(0xff757575),
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Masukkan Kursi",
                  hintStyle: TextStyle(color: Color(0xff757575)),
                  filled: true,
                  fillColor: Color(0xffe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                "Jam Praktikum",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    jam = value;
                  });
                },
                controller: _jamController,
                style: TextStyle(
                  color: Color(0xff757575),
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: "Masukkan Jam Praktikum",
                  hintStyle: TextStyle(color: Color(0xff757575)),
                  filled: true,
                  fillColor: Color(0xffe8e8e8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                minWidth: double.infinity,
                color: Color(0xFFFF5B16),
                textColor: Color(0xfffefefe),
                child: Text('OK'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                onPressed: Submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
