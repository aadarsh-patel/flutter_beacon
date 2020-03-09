import 'package:flutter/material.dart';

import 'package:flutter_beacon/screens/home_page.dart';
import 'package:flutter_beacon/screens/host_beacon.dart';
import 'package:flutter_beacon/screens/follow_beacon.dart';
import 'package:flutter_beacon/screens/search_key.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/host': (context) => HostBeacon(),
        '/follow': (context) => FollowBeacon(),
        '/search': (context) => SearchKey(),
      },
    );
  }
}
