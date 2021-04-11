import 'package:flutter/material.dart';

import 'models/data.dart';

class NotificationData extends StatelessWidget {
  final Data data;
  NotificationData({this.data});

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
              // Text('${data.mata_kuliah}'),
              // Text('${data.lab}'),
              // Text('${data.kursi}'),
              // Text('${data.jam}'),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Color(0xFFFF5B16),
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Jadwal Praktikum',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(15.0),
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${data.mata_kuliah}',
                            style: TextStyle(
                                color: Color(0xFF1A1A1A),
                                fontWeight: FontWeight.w800),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time_outlined,
                                      color: Color(0xFFFF5B16), size: 16.0),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      '${data.jam}',
                                      style: TextStyle(
                                          color: Color(0xFFA0A0A0),
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.sensor_door_outlined,
                                      color: Color(0xffff5b16), size: 16.0),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text('${data.lab}',
                                        style: TextStyle(
                                            color: Color(0xffa0a0a0),
                                            fontWeight: FontWeight.w300)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.desktop_windows,
                                      color: Color(0xffff5b16), size: 16.0),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.0),
                                    child: Text('${data.kursi}',
                                        style: TextStyle(
                                            color: Color(0xffa0a0a0),
                                            fontWeight: FontWeight.w300)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
