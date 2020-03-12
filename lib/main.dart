import 'package:flutter/material.dart';

import 'package:flutter_beacon/screens/home_page.dart';
import 'package:flutter_beacon/screens/follow_beacon.dart';
import 'package:flutter_beacon/screens/form.dart';

import 'common.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/follow': (context) => FollowBeacon(),
        '/form': (context) => MyForm(),
      },
    );
  }
}
