import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.4,
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 10,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Host a\nbeacon',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/form'),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width*0.4,
              height: MediaQuery.of(context).size.width*0.4,
              child: Card(
                color: Colors.lightBlueAccent,
                elevation: 10,
                child: RaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Follow a\nbeacon',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '/follow'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
