import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Beacon'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.withOpacity(0.4), Colors.white, Colors.blue.withOpacity(0.2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 10,
                  child: RaisedButton(
                    color: Colors.lightBlueAccent,
                    child: Text(
                      'Host a\nbeacon',
                      style: TextStyle(fontSize: 30,),
                    ),
                    onPressed: () => Navigator.pushNamed(context, '/form'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.width * 0.4,
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
      ),
    );
  }
}
